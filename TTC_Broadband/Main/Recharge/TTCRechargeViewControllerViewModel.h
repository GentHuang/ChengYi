//
//  TTCRechargeViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCRechargeViewControllerViewModel : NSObject
//充值
- (void)rechargeWithKeyno:(NSString *)keyno Fees:(NSString *)fees fbid:(NSString *)fbid payway:(NSString *)payway bankaccno:(NSString *)bankaccno payreqid:(NSString *)payreqid success:(SuccessBlock)success fail:(FailBlock)fail;
@end
