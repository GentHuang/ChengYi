//
//  TTCSellDetailMonthViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TTCSellDetailMonthViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataOdsArray;
@property (strong, nonatomic) NSMutableArray *dataOrderArray;
@property (strong, nonatomic) NSMutableArray *dataChartArray;
//获取所有销售明细
- (void)getMyOrdersWithPage:(NSString *)page success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
