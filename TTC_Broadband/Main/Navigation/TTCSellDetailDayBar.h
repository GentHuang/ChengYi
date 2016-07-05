//
//  TTCSellDetailDayBar.h
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCSellDetailDayBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置标题
- (void)loadSellDetailDayHeaderLabel:(NSString *)title;
//更新点选按钮
- (void)reloadSelectedButton;
//更新销售额(日)
- (void)loadDaySellCount:(NSString *)count;
@end
