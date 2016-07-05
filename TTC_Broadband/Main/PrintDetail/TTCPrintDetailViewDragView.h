//
//  TTCPrintDetailViewDragView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/12/21.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCPrintDetailViewDragView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//弹出View
- (void)dragDownList;
//收起View
- (void)packUpList;
//加载发票本号数据
- (void)loadBooknoListWithArray:(NSArray *)dataArray;
@end
