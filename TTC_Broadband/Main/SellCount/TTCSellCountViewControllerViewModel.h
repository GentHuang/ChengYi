//
//  TTCSellCountViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCSellCountViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataSaleMonthArray;
@property (strong, nonatomic) NSMutableArray *dataAnalysisArray;
//销售类型字典
@property (strong, nonatomic) NSMutableArray *dataSaleBusinessArray;

//获取销售统计信息
- (void)getSalesStatisticsSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
//获取当前营销人员的本月目标
- (void)getMonthTargetSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//获取销售统计对应的类型数据统计
- (void)getSalesBusinessStatisticsSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
