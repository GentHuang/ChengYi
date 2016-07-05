//
//  TTCProductLibDragView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/28.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCProductLibDragView : UIView
//弹出View
- (void)dragDownList;
//收起View
- (void)packUpList;
//加载用户数据
- (void)loadUserListWithArray:(NSArray *)dataArray permarkArray:(NSArray *)permarkArray;

@end
