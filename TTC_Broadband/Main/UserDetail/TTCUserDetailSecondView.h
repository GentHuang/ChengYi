//
//  TTCUserDetailTTopView.h
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCUserDetailSecondView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//加载价格
- (void)loadPriceWithArray:(NSArray *)dataArray;
@end
