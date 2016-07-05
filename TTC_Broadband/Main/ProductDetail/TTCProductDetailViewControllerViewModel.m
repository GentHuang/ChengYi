//
//  TTCProductDetailViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCProductDetailViewControllerViewModel.h"
//Model
#import "TTCShoppingCarViewControllerModel.h"
#import "TTCPayViewControllerOrderModel.h"
#import "TTCPayViewControllerOrderOutputModel.h"
#import "TTCPayViewControllerOrderOutputOrderinfosModel.h"
@interface TTCProductDetailViewControllerViewModel()
@property (strong, nonatomic) SellManInfo *sellManInfo;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@end
@implementation TTCProductDetailViewControllerViewModel
- (void)initData{
    _sellManInfo = [SellManInfo sharedInstace];
    _customerInfo = [CustomerInfo shareInstance];
}
//初始化
- (instancetype)init{
    if (self = [super init]) {
        [self initData];
    }
    return self;
}
//根据ID返回产品详细信息
- (void)getProductById:(NSString *)id_conflict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //下载数据
    [[NetworkManager sharedManager] GET:kGetProductByIdAPI parameters:@{@"id":id_conflict} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //数据初始化
        _vcModel = [[TTCProductDetailViewControllerModel alloc] init];
        //获取数据
        [_vcModel setValuesForKeysWithDictionary:responseObject];
        if (_vcModel.id_conflict.length > 0 || _vcModel.code.length > 0) {
            //成功
            successBlock(nil);
        }else{
            //失败
            _failMSG = @"本产品库不存在该产品";
            failBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        _failMSG = @"本产品库不存在该产品";
        failBlock(nil);
    }];
}
//加入购物车
- (void)addToShoppingCarWithModel:(TTCProductDetailViewControllerModel *)dataModel keyno:(NSString *)keyno count:(NSString *)count permark:(NSString *)permark success:(SuccessBlock)successBlock fail:(FailBlock)fail{
    //将产品信息录入本地数据库
    TTCShoppingCarViewControllerModel *carModel = [[TTCShoppingCarViewControllerModel alloc] init];
    if ([dataModel.permark isEqualToString:permark]) {
        carModel.keyno = keyno;
        carModel.count = count;
        carModel.id_conflict = dataModel.id_conflict;
        carModel.title = dataModel.title;
        carModel.code = dataModel.code;
        carModel.dmonth = dataModel.dmonth;
        carModel.price = dataModel.price;
        carModel.intro = dataModel.intro;
        carModel.contents = dataModel.contents;
        carModel.smallimg = dataModel.smallimg;
        carModel.pubdate = dataModel.pubdate;
        carModel.type = dataModel.type;
        carModel.permark = dataModel.permark;
        [[FMDBManager sharedInstace] creatTable:carModel];
        [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:carModel withCheckNum:3];
        successBlock(nil);
    }else{
        _failMSG = @"该卡不能订购此产品或套餐";
        fail(nil);
    }
}
//马上订购
- (void)productOrderWithModel:(TTCProductDetailViewControllerModel *)dataModel keyno:(NSString *)keyno count:(NSString *)count success:(SuccessBlock)successBlock fail:(FailBlock)fail{
    //keyno转换格式
    NSRange range = [keyno rangeOfString:@" "];
    if (range.location != NSNotFound) {
        keyno = [keyno substringFromIndex:(range.location+1)];
    }
    //订购请求
    [[NetworkManager sharedManager] GET:kProductOrderAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"clientpwd":_sellManInfo.password,@"custid":_customerInfo.custid,@"keyno":keyno,@"ordertype":dataModel.type,@"salescode":dataModel.code,@"count":count,@"proname":dataModel.title,@"permark":dataModel.permark,@"Deptname":_sellManInfo.depName,@"Mname":_sellManInfo.name,@"Uname":_customerInfo.custname} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        _dataOrderArray = [NSMutableArray array];
        //获取数据
        TTCPayViewControllerOrderModel *orderModel = [[TTCPayViewControllerOrderModel alloc] init];
        [orderModel setValuesForKeysWithDictionary:responseObject];
        //判断是否存在流水号冲突
        NSRange range = [orderModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            NSLog(@"%@",responseObject);
            [self productOrderWithModel:dataModel keyno:keyno count:count success:^(NSMutableArray *resultArray) {
            } fail:^(NSError *error) {
            }];
            return;
        }
        TTCPayViewControllerOrderOutputModel *outputModel = orderModel.output;
        if (outputModel.orderinfos.count > 0) {
            //支付成功的订单信息
            [_dataOrderArray addObject:outputModel.orderid];
            TTCPayViewControllerOrderOutputOrderinfosModel *infoModel = [outputModel.orderinfos firstObject];
            _vcModel.price = [NSString stringWithFormat:@"%.02f",(float)([infoModel.price floatValue]/[count floatValue])];
        }
        if (_dataOrderArray.count > 0) {
            successBlock(nil);
        }else{
            _failMSG = outputModel.message;
            NSRange range = [_failMSG rangeOfString:@"Index"];
            if (range.location != NSNotFound) {
                _failMSG = @"无法订购该产品或套餐";
            }
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        _failMSG = @"网络开小差了哦";
        fail(nil);
        NSLog(@"%@",error);
    }];
}
@end
