//
//  TTCAddCustAddrViewControllerCellTopViewDragView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCAddCustAddrViewControllerCellTopViewDragView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//加载数组信息
- (void)loadWithDataArray:(NSArray *)dataArray;
//弹出View
- (void)dragDownList;
//收起View
- (void)packUpList;

@end
