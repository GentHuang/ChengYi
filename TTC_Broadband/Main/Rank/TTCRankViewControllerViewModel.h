//
//  TTCRankViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCRankViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataRankArray;
//获取下载排行
- (void)getSalesRankingSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
