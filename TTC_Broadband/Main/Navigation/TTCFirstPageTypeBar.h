//
//  TTCFirstPageTypeBar.h
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCFirstPageTypeBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//填入首页信息(姓名,ID,部门,营业厅,片区)
- (void)loadFirstPageInformation:(NSArray *)dataArray;
//客户是否已登录(姓名,地区)
- (void)loadCustomerFirstPageInformation:(BOOL)isLog;
//设置首页标题
- (void)loadFirstPageHeaderLabel:(NSString *)title;
//新消息提示
- (void)newsHint:(BOOL)hasNew;
@end
