//
//  TTCAccountInfoBar.h
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCAccountInfoBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置标题
- (void)loadAccountInfoHeaderLabel:(NSString *)title;
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack;
- (void)accountInfoLeaveButton:(BOOL)isShowButton;
@end
