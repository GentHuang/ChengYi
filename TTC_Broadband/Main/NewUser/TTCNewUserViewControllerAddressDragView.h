//
//  TTCNewUserViewControllerAddressDragView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/28.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCNewUserViewControllerAddressDragView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//加载数组信息
- (void)loadWithDataArray:(NSArray *)dataArray;
//弹出View
- (void)dragDownList;
//收起View
- (void)packUpList;
@end
