//
//  TTCSellCountViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellCountViewControllerViewModel.h"
//Model
#import "TTCSellCountViewControllerModel.h"
#import "TTCSellCountViewControllerAnalysisModel.h"
#import "TTCSellCountViewControllerSalesMonthModel.h"
//add
#import "TTCSellCountViewControllerSalesBusinessModel.h"
@implementation TTCSellCountViewControllerViewModel
//获取销售统计信息
- (void)getSalesStatisticsSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //获取销售人员信息
    __block SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    //
    //下载数据
    [[NetworkManager sharedManager] GET:kGetSalesStatisticsAPI parameters: @{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"mname":sellManInfo.name,@"deptname":sellManInfo.depName} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        _dataSaleMonthArray = [NSMutableArray array];
        _dataAnalysisArray = [NSMutableArray array];
        TTCSellCountViewControllerModel *vcModel = [[TTCSellCountViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        //加载销售信息
        if ([vcModel.mname isEqualToString:sellManInfo.name]) {
            sellManInfo.commission = [NSString stringWithFormat:@"%.02f",[vcModel.commission floatValue]];
            sellManInfo.mSales = [NSString stringWithFormat:@"%.02f",[vcModel.mSales floatValue]];
            sellManInfo.dSales = [NSString stringWithFormat:@"%.02f",[vcModel.dSales floatValue]];
            sellManInfo.ranking = [NSString stringWithFormat:@"%d",[vcModel.ranking intValue]];
        }
        for (TTCSellCountViewControllerSalesMonthModel *saleModel in vcModel.salemonths) {
            [_dataSaleMonthArray addObject:saleModel];
        }
        for (TTCSellCountViewControllerAnalysisModel *anModel in vcModel.analysis) {
            [_dataAnalysisArray addObject:anModel];
        }
        if (_dataAnalysisArray.count > 0 || _dataSaleMonthArray.count > 0) {
            successBlock(nil);
        }else{
            failBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
//获取当前营销人员的本月目标
- (void)getMonthTargetSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    [[FMDBManager sharedInstace] selectModelArrayInDatabase:[Goal class] withDic:@{@"name":[SellManInfo sharedInstace].name,@"psw":[SellManInfo sharedInstace].password} success:^(NSMutableArray *resultArray) {
        //获取成功
        success(resultArray);
    } fail:^(NSError *error) {
        //获取失败
        fail(nil);
    }];
}
//获取销售统计对应的类型数据统计
- (void)getSalesBusinessStatisticsSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //获取销售人员信息
    __block SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    //获取当前时间
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    //时间从本月第一天开始
    NSString *stringTime = [currentTime substringToIndex:8];
    NSString *firtDateTime = [NSString stringWithFormat:@"%@%@",stringTime,@"1"];
    
    //参数拼接
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"deptid"] = sellManInfo.depID;
    parameters[@"clientcode"] = sellManInfo.loginname;
    parameters[@"clientpwd"] = sellManInfo.password;
    parameters[@"etime"] = currentTime;
    parameters[@"stime"] = firtDateTime;
    
    [[NetworkManager sharedManager]GET:kGetSalesBusinessStatisticsAPI parameters:parameters success:^(AFHTTPRequestOperation * operation, id responseObject) {
        //初始化数组
        _dataSaleBusinessArray  = [NSMutableArray array];
        //外层model
        TTCSellCountViewControllerSalesBusinessModel *BusinessModel = [[TTCSellCountViewControllerSalesBusinessModel alloc]init];
        [BusinessModel setValuesForKeysWithDictionary:responseObject];
        //下一层model
        TTCSellCountViewControllerSalesBusinessOutputModel *outputModel = [[TTCSellCountViewControllerSalesBusinessOutputModel alloc]init];
        [outputModel setValuesForKeysWithDictionary:BusinessModel.output];
        [_dataSaleBusinessArray addObject:outputModel];
        if (_dataSaleBusinessArray.count>0) {
            successBlock(nil);
        }
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error);
        failBlock(nil);
        
    }];
    
}

@end
