//
//  TTCSellCountViewCellPieView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/12.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PieLayer;
@interface TTCSellCountViewCellPieView : UIView
@end
@interface TTCSellCountViewCellPieView (ex)
@property(nonatomic,readonly,retain) PieLayer *layer;
//加载信息
- (void)loadPiePercentWithArray:(NSArray *)dataArray;
@end
