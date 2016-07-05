//
//  TTCNewUserViewControllerDragView.h
//  TTC_Broadband
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCNewUserViewControllerDragView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//加载数组信息
- (void)loadWithDataArray:(NSArray *)dataArray;
//弹出View
- (void)dragDownList;
//收起View
- (void)packUpList;
@end
