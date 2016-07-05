//
//  TTCUserLocateBar.h
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCUserLocateBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置客户定位标题
- (void)loadUserLocateHeaderLabel:(NSString *)title;
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack;
@end
