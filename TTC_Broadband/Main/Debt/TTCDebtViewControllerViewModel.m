//
//  TTCDebtViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCDebtViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerArrearModel.h"
#import "TTCUserLocateViewControllerArrearOutputModel.h"
#import "TTCUserLocateViewControllerArrearOutputArreardetsModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
#import "TTCUserLocateViewControllerBalanceModel.h"
#import "TTCUserLocateViewControllerBalanceOutputModel.h"
#import "TTCUserLocateViewControllerBalanceOutputFeebooksModel.h"
@interface TTCDebtViewControllerViewModel()
@property (assign, nonatomic) int arrearTaskCount;
@property (assign, nonatomic) int curArrearTaskCount;
@end

@implementation TTCDebtViewControllerViewModel
//初始化
- (instancetype)init{
    if (self = [super init]) {
        [self addObserver];
    }
    return self;
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"curArrearTaskCount" context:nil];
}
//获取所有用户的欠费信息
- (void)getArrearsListWithServsArray:(NSArray *)servsArray withPage:(int)page{
    //没有用户
    if(servsArray.count > 0){
        //初始化存储数据
        if (page == 1) {
            _dataOutputArray = [NSMutableArray array];
        }
        _curArrearTaskCount = 0;
        self.arrearTaskCount = (int)servsArray.count;
        [CustomerInfo shareInstance].arrearsun = 0;
        //获取数据
        SellManInfo *sellManInfo = [SellManInfo sharedInstace];
        //重复数组
        NSMutableArray *existArray;
        for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel in servsArray) {
            BOOL isExist = NO;
            //观察是否有重复
            if (existArray.count > 0) {
                if ([existArray indexOfObject:servsModel.keyno] < 99999) {
                    isExist = YES;
                }else{
                    [existArray addObject:servsModel.keyno];
                }
            }else{
                existArray = [NSMutableArray arrayWithObject:servsModel.keyno];
            }
            if (isExist) {
                self.curArrearTaskCount ++;
                continue;
            }
            [[NetworkManager sharedManager] GET:kGetArrearsListAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"clientpwd":sellManInfo.password,@"keyno":servsModel.keyno,@"pagesize":@"100",@"currentPage":[NSString stringWithFormat:@"%d",page]} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
                TTCUserLocateViewControllerArrearModel *arrearModel = [[TTCUserLocateViewControllerArrearModel alloc] init];
                [arrearModel setValuesForKeysWithDictionary:responseObject];
                TTCUserLocateViewControllerArrearOutputModel *outputModel = arrearModel.output;
                outputModel.keyno = servsModel.keyno;
                outputModel.permark = servsModel.permark;
                //获取所有用户的欠费信息
                if (outputModel.arreardets.count > 0) {
                    [_dataOutputArray addObject:outputModel];
                }
                //计算欠费总额
                [CustomerInfo shareInstance].arrearsun += [outputModel.arrearsun floatValue];
                //判断下载任务是否完成
                self.curArrearTaskCount ++;
            } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
                NSLog(@"%@",error);
                self.curArrearTaskCount ++;
            }];
        }
    }else{
        //欠费请求完成
        self.arrearSuccessBlock(nil);
    }
}
//通过下标返回该用户的欠费信息
- (NSArray *)getServsArrearsListWithIndex:(int)index{
    if (_dataOutputArray.count > 0) {
        TTCUserLocateViewControllerArrearOutputModel *outputModel = _dataOutputArray[index];
        return outputModel.arreardets;
    }else{
        return [NSArray new];
    }
}
//获取余额信息
- (void)getBalanceInfo{
    __block CustomerInfo *customerInfo = [CustomerInfo shareInstance];
    //获取数据
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    [[NetworkManager sharedManager] GET:kGetBalanceByCustidAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"clientpwd":sellManInfo.password,@"custid":customerInfo.custid} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化存储数据
        _dataBalanceArray = [NSMutableArray array];
        customerInfo.allBalanceArray = [NSMutableArray array];
        customerInfo.feesums = 0;
        customerInfo.cashsums = 0;
        customerInfo.incrementsums = 0;
        //获取数据
        TTCUserLocateViewControllerBalanceModel *balanceModel = [[TTCUserLocateViewControllerBalanceModel alloc] init];
        [balanceModel setValuesForKeysWithDictionary:responseObject];
        //判断是否存在流水号冲突
        NSRange range = [balanceModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            NSLog(@"%@",responseObject);
            [self getBalanceInfo];
            return;
        }
        TTCUserLocateViewControllerBalanceOutputModel *outputModel = balanceModel.output;
        //判断账本是否为空
        if (outputModel.feebooks.count > 0) {
            //账本非空
            for (TTCUserLocateViewControllerBalanceOutputFeebooksModel *feedModel in outputModel.feebooks) {
                //每个账本信息
                [_dataBalanceArray addObject:feedModel];
                [customerInfo.allBalanceArray addObject:feedModel];
                if ([feedModel.fbname isEqualToString:@"客户现金账本"]) {
                    customerInfo.cashsums = [feedModel.fbfees floatValue];
                }else if ([feedModel.fbname isEqualToString:@"增值业务账本"]) {
                    customerInfo.incrementsums = [feedModel.fbfees floatValue];
                }
            }
            //计算总余额
            NSInteger feesums = [outputModel.feesums integerValue];
            customerInfo.feesums += feesums;
        }else{
            //账本为空
            NSLog(@"账本为空");
        }
        //余额请求完成
        self.balanceSuccessBlock(nil);
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        //余额请求失败
        NSLog(@"%@",error);
    }];
}
#pragma mark - Event response
//添加观察者
- (void)addObserver{
    //观察欠费请求是否完成
    [self addObserver:self forKeyPath:@"curArrearTaskCount" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"curArrearTaskCount"]) {
        if (_curArrearTaskCount == _arrearTaskCount) {
            //欠费请求完成
            self.arrearSuccessBlock(nil);
        }
    }
}
@end
