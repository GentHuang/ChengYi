//
//  TTCSellDetailMonthBar.h
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCSellDetailMonthBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置标题
- (void)loadSellDetailMonthHeaderLabel:(NSString *)title;
//设置年、月
- (void)loadYearTitle:(NSString *)year monthTitle:(NSString *)month;
//更新点选按钮
- (void)reloadSelectedButton;
//更新销售额(月)
- (void)loadMonthSellCount:(NSString *)count;
//是否隐藏本月销售和今日销售
- (void)hideMonthAndDaySell:(BOOL)isHide;
@end
