//
//  TTCPrintViewDragView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCPrintViewDragView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//隐藏拉下菜单
- (void)hideDragView;
//显示下拉菜单
- (void)showDragView;
//加载下拉菜单信息
- (void)loadDragViewWithArray:(NSArray *)dataArray;
@end
