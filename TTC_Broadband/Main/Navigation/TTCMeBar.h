//
//  TTCMeBar.h
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCMeBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//填入我信息(姓名,ID,部门,营业厅,片区)
- (void)loadMeInformation:(NSArray *)dataArray;
//设置我标题
- (void)loadMeHeaderLabel:(NSString *)title;
//新消息提示
- (void)newsHint:(BOOL)hasNew;

@end
