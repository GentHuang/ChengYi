//
//  TTCSellDetailMonthChartView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PieLayer;
@interface TTCSellDetailMonthChartView : UIView
@end
@interface TTCSellDetailMonthChartView (ex)
@property(nonatomic,readonly,retain) PieLayer *layer;
//加载圆形图
- (void)loadPiePercentWithArray:(NSArray *)dataArray;
@end
