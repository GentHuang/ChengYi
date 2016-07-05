//
//  TTCAddCustAddrViewControllerCellTopViewMenuView.h
//  TTC_Broadband
//
//  Created by apple on 16/3/10.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TTCAddCustAddrViewControllerCellTopViewMenuView : UIView

@property (copy, nonatomic) StringTransBlock stringBlock;

//加载数组信息
- (void)loadWithDataArray:(NSArray *)dataArray;
//弹出View
- (void)dragDownList;
//收起View
- (void)packUpList;
@end
