//
//  TTCSellCountViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kRoyaltyType,
    kTopViewType,
    kGoalViewType,
    kLineChartViewType,
    kRoundChartViewType,
    kBusinessViewType
}CellType;
@interface TTCSellCountViewCell : UITableViewCell
//选择Cell类型
- (void)selectCellType:(CellType)type;
//载入顶部数据
- (void)loadWithMSales:(NSString *)mSales dSales:(NSString *)dSales ranking:(NSString *)ranking;
//载入数据
- (void)loadLineChartWithArray:(NSArray *)array;
//加载提成
//- (void)loadRoyaltyWithRoyalty:(NSString *)royaltyString;
//加载饼状图
- (void)loadPiePercentWithArray:(NSArray *)dataArray;
//加载本月已完成百分比
- (void)loadFinishPercentWithPercent:(float)percent;
//加载销售类型统计
- (void)loadBusinessStatisticsWithArray:(NSArray*)array;
@end
