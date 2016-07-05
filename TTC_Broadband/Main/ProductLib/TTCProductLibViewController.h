//
//  TTCProductLibViewController.h
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"
#import "AppDelegate.h"
@interface TTCProductLibViewController : TTCParentViewController
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (assign, nonatomic) BOOL canGoBack;
@end
