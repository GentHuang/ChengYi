//
//  TTCDepartmentViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCDepartmentViewControllerViewModel.h"
//Model
#import "TTCSellCountViewControllerModel.h"
@implementation TTCDepartmentViewControllerViewModel
//获取销售统计信息
- (void)getSalesStatisticsSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //获取销售人员信息
    __block SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    //下载数据
    [[NetworkManager sharedManager] GET:kGetSalesStatisticsAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"mname":sellManInfo.name,@"deptname":sellManInfo.depName} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        TTCSellCountViewControllerModel *vcModel = [[TTCSellCountViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        if ([vcModel.mname isEqualToString:sellManInfo.name]) {
            sellManInfo.commission = [NSString stringWithFormat:@"%@",vcModel.commission];
            sellManInfo.mSales = [NSString stringWithFormat:@"%@",vcModel.mSales];
            sellManInfo.dSales = [NSString stringWithFormat:@"%@",vcModel.dSales];
            sellManInfo.ranking = [NSString stringWithFormat:@"%@",vcModel.ranking];
            successBlock(nil);
        }else{
            failBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
@end
