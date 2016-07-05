//
//  TTCOrderRecordBar.h
//  TTC_Broadband
//
//  Created by apple on 15/12/19.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCOrderRecordBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置订单记录标题
- (void)loadOrderRecordLabel:(NSString *)title;
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack;
//加载订单记录客户名称
- (void)loadOrderRecordCustNameLabelWith:(NSString *)custNameString;
//更新点选按钮
- (void)reloadSelectedButtonWithIsAll:(BOOL)isAll;
@end
