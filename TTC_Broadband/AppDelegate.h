//
//  AppDelegate.h
//  TTC_Broadband
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCTabbarController.h"
#import "TTCNavigationController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TTCTabbarController *tabbarVC;
@property (strong, nonatomic) TTCNavigationController *loginNVC;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@end

