//
//  TTCAccuntResultBar.h
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCAccuntResultBar : UINavigationBar

@property (copy, nonatomic) StringTransBlock stringBlock;

//设置订单记录标题
- (void)loadOrderRecordLabel:(NSString *)title;
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack;

@end
