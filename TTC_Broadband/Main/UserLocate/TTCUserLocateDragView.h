//
//  TTCUserLocateDragView.h
//  TTC_Broadband
//
//  Created by apple on 15/12/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCUserLocateDragView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//隐藏拉下菜单
- (void)hideDragView;
//显示下拉菜单
- (void)showDragView;
@end
