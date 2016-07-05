//
//  TTCSellDetailDayChartView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PieLayer;
@interface TTCSellDetailDayChartView : UIView
@end
@interface TTCSellDetailDayChartView (ex)
@property(nonatomic,readonly,retain) PieLayer *layer;
//加载标题名
- (void)loadPiePercentWithArray:(NSArray *)dataArray;
@end
