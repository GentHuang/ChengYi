//
//  TTCDepartmentViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCDepartmentViewControllerViewModel : NSObject
//获取销售统计信息
- (void)getSalesStatisticsSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
