//
//  TTCTabbarController.h
//  TTC_Broadband
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TTCTabbarController : UITabBarController
//设置跳转页面
- (void)selectedControllerIndex:(int)selectedIndex;
//隐藏Bar
- (void)hideBar;
//显示Bar
- (void)showBar;
@end
