//
//  TTCShoppingCarViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCShoppingCarViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
#import "TTCShoppingCarViewControllerModel.h"
#import "TTCPayViewControllerOrderModel.h"
#import "TTCPayViewControllerOrderOutputModel.h"
#import "TTCPayViewControllerOrderOutputOrderinfosModel.h"
@interface TTCShoppingCarViewControllerViewModel()
@property (strong, nonatomic) SellManInfo *sellManInfo;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@property (assign, nonatomic) int currTaskCount;
@property (assign, nonatomic) int allTaskCount;

@end
@implementation TTCShoppingCarViewControllerViewModel

- (void)initData{
    
    _sellManInfo = [SellManInfo sharedInstace];
    _customerInfo = [CustomerInfo shareInstance];
}
//初始化
- (instancetype)init{
    
    if (self = [super init]) {
        [self initData];
        [self addObserver];
    }
    return self;
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"currTaskCount"];
}
//从数据库获取购物车数据
- (void)getDataFromDB{
    //初始化
    _dataCarArray = [NSMutableArray array];
    _allTaskCount = (int)[CustomerInfo shareInstance].allServsArray.count;
    self.currTaskCount = 0;
    for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel in [CustomerInfo shareInstance].allServsArray) {
        //每个用户的信息
        [[FMDBManager sharedInstace] selectModelArrayInDatabase:[TTCShoppingCarViewControllerModel class] withDic:@{@"keyno":servsModel.keyno,@"permark":servsModel.permark} success:^(NSMutableArray *resultArray) {
            for (TTCShoppingCarViewControllerModel *vcModel in resultArray) {
                //存储该客户所有购物车的信息
                [_dataCarArray addObject:vcModel];
            }
            
            self.currTaskCount ++;
            
        } fail:^(NSError *error) {
            
            self.currTaskCount ++;
        }];
    }
}

//删除实例
- (void)deleteModelWithID:(NSString *)ID keyno:(NSString *)keyno{
    
    [[FMDBManager sharedInstace] deleteModelInDatabase:[TTCShoppingCarViewControllerModel class] withDic:@{@"id_conflict":ID,@"keyno":keyno}];
    
}

//购物车支付
- (void)carPayWithArray:(NSArray *)dataArray sucess:(SuccessBlock)successBlock fail:(FailBlock)fail{
    //初始化
    _dataOrderArray = [NSMutableArray array];
    //初始化请求字符串
    NSString *keynoString = @"";
    NSString *orderTypeString = @"";
    NSString *salesCodeString =  @"";
    NSString *countString = @"";
    NSString *pnameString = @"";
    NSString *permarkString = @"";
    TTCShoppingCarViewControllerModel *carModel;
    
    for (int i = 0; i < dataArray.count; i ++) {
        
        carModel = (TTCShoppingCarViewControllerModel *)dataArray[i];
        //组合请求字符串
        if (i == 0) {
            
            keynoString = [NSString stringWithFormat:@"%@",carModel.keyno];
            orderTypeString = [NSString stringWithFormat:@"%@",carModel.type];
            salesCodeString = [NSString stringWithFormat:@"%@",carModel.code];
            countString = [NSString stringWithFormat:@"%@",carModel.count];
            pnameString = [NSString stringWithFormat:@"%@",carModel.title];
            permarkString = [NSString stringWithFormat:@"%@",carModel.permark];
            
        }else{
            keynoString = [keynoString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.keyno]];
            orderTypeString = [orderTypeString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.type]];
            salesCodeString = [salesCodeString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.code]];
            countString = [countString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.count]];
            pnameString = [pnameString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.title]];
            permarkString = [permarkString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.permark]];
        }
    }
    //订购请求
    [[NetworkManager sharedManager] GET:kProductOrderAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"clientpwd":_sellManInfo.password,@"custid":_customerInfo.custid,@"keyno":keynoString,@"ordertype":orderTypeString,@"salescode":salesCodeString,@"count":countString,@"proname":pnameString,@"permark":permarkString,@"Deptname":_sellManInfo.depName,@"Mname":_sellManInfo.name,@"Uname":_customerInfo.custname} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        
        NSLog(@"%@",operation);
        TTCPayViewControllerOrderModel *orderModel = [[TTCPayViewControllerOrderModel alloc] init];
        [orderModel setValuesForKeysWithDictionary:responseObject];
        TTCPayViewControllerOrderOutputModel *outputModel = orderModel.output;
        
        if (outputModel.orderinfos.count > 0) {
            
            //支付成功的订单信息
            [_dataOrderArray addObject:outputModel.orderid];
            
            for (int i = 0; i < outputModel.orderinfos.count; i ++) {
                
                TTCPayViewControllerOrderOutputOrderinfosModel *infoModel = outputModel.orderinfos[i];
                TTCShoppingCarViewControllerModel *insideCarModel = dataArray[i];
                insideCarModel.price = [NSString stringWithFormat:@"%.02f",[infoModel.price floatValue]/[insideCarModel.count floatValue]];
            }
        }
        if (_dataOrderArray.count > 0) {
            successBlock(nil);
        }else{
            _failMSG = outputModel.message;
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        _failMSG = @"网络开小差了哦";
        NSLog(@"%@",error);
        fail(nil);
    }];
}

//添加观察者
- (void)addObserver{
    
    //观察数据库是否完成取出
    [self addObserver:self forKeyPath:@"currTaskCount" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //观察数据库是否完成取出
    if ([keyPath isEqualToString:@"currTaskCount"]) {
        
        if (_currTaskCount == _allTaskCount) {
            
            self.dbSuccessBlock(nil);
        }
    }
}


@end
