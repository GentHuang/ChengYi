//
//  TTCSellDetailDayViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailDayViewControllerViewModel.h"
//Model
#import "TTCSellDetailDayViewControllerModel.h"
#import "TTCSellDetailDayViewControllerOdsModel.h"
@interface TTCSellDetailDayViewControllerViewModel()
@property (strong, nonatomic) SellManInfo *sellManInfo;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@end
@implementation TTCSellDetailDayViewControllerViewModel
- (instancetype)init{
    if (self = [super init]) {
        _sellManInfo = [SellManInfo sharedInstace];
        _customerInfo = [CustomerInfo shareInstance];
    }
    return self;
}
//获取今天销售明细
- (void)getMyOrdersWithPage:(NSString *)page success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //请求
    [[NetworkManager sharedManager] GET:kGetMyOrdersTodayAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"page":page,@"row":@"10"} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        if ([page isEqualToString:@"1"]) {
            _dataOdsArray = [NSMutableArray array];
            _dataOrderArray = [NSMutableArray array];
        }
        _dataChartArray = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,nil];
        //获取数据
        for (NSDictionary *dic in responseObject) {
            //获取销售明细
            TTCSellDetailDayViewControllerModel *vcModel = [[TTCSellDetailDayViewControllerModel alloc] init];
            [vcModel setValuesForKeysWithDictionary:dic];
            [_dataOrderArray addObject:vcModel];
            for (TTCSellDetailDayViewControllerOdsModel *odsModel in vcModel.ods) {
                //获取销售明细下的所有详细套餐信息
                [_dataOdsArray addObject:odsModel];
                //插入统计数组
                int index = [odsModel.permark intValue];
                if (index < 5) {
                    _dataChartArray[index] = [NSNumber numberWithInt:([odsModel.price intValue]+[_dataChartArray[index] intValue])];
                }
            }
        }
        successBlock(nil);
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
