//
//  TTCProudcntLibExpandMenuView.h
//  TTC_Broadband
//
//  Created by apple on 16/2/28.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCProudcntLibExpandMenuView : UIView

//刷新数据
- (void)getDataWithArray:(NSArray*)array;

//跟随选中
- (void)selectWithIndex:(NSInteger)index;
//弹出菜单
- (void)dragDownMenu;
//隐藏菜单
- (void)paclUpMenu;
@end
