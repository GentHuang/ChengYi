//
//  TTCProductDetailDragView.h
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCProductDetailDragView : UIView
//弹出View
- (void)dragDownList;
//收起View
- (void)packUpList;
//加载用户数据
- (void)loadUserListWithArray:(NSArray *)dataArray permarkArray:(NSArray *)permarkArray;
@end
