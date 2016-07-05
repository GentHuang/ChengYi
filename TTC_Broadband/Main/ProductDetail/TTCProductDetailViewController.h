//
//  TTCProductDetailViewController.h
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"

@interface TTCProductDetailViewController : TTCParentViewController
@property (strong, nonatomic) NSString *id_conflict;
@property (strong, nonatomic) NSString *transPermark;
@property (strong, nonatomic) NSString *transKeyno;
//营销方案
@property (assign, nonatomic) BOOL  isMarketingPlan;
@end
