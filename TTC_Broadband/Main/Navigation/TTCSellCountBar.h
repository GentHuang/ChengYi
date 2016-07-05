//
//  TTCSellCountBar.h
//  TTC_Broadband
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCSellCountBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置销售统计标题
- (void)loadSellCountHeaderLabel:(NSString *)title;
//加载信息
- (void)loadWithMname:(NSString *)mname mcode:(NSString *)mcode deptname:(NSString *)deptname commission:(NSString *)commission;
@end
