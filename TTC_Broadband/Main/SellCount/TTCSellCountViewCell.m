//
//  TTCSellCountViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//View
#import "TTCSellCountViewCell.h"
#import "TTCSellCountViewCellTopView.h"
#import "TTCSellCountViewCellGoalView.h"
#import "TTCSellCountViewCellRoyaltyView.h"
#import "TTCSellCountViewCellLineChartView.h"
#import "TTCSellCountViewCellRoundChartView.h"
#import "TTCSellCountViewCellBusinessView.h"
//add
#import "TTCSellCountViewCellNewPieView.h"
@interface TTCSellCountViewCell()
@property (strong, nonatomic) TTCSellCountViewCellTopView *topView;
@property (strong, nonatomic) TTCSellCountViewCellRoyaltyView *royaltyView;
@property (strong, nonatomic) TTCSellCountViewCellGoalView *goalView;
@property (strong, nonatomic) TTCSellCountViewCellLineChartView *lineChartView;
@property (strong, nonatomic) TTCSellCountViewCellBusinessView *businessView;
//@property (strong, nonatomic) TTCSellCountViewCellRoundChartView *roundChartView;
//add
@property (strong, nonatomic) TTCSellCountViewCellNewPieView *roundChartView;

@end

@implementation TTCSellCountViewCell
#pragma mark - Init methods
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma mark - Getters and setters
- (void)createUI{
    //本月提成
    _businessView = [[TTCSellCountViewCellBusinessView alloc] init];
    
    _businessView.hidden = YES;
    [self.contentView addSubview:_businessView];
    //topView
    _topView = [[TTCSellCountViewCellTopView alloc] init];
    _topView.hidden = YES;
    [self.contentView addSubview:_topView];
    //每月目标
    _goalView = [[TTCSellCountViewCellGoalView alloc] init];
    _goalView.hidden = YES;
    [self.contentView addSubview:_goalView];
    //折线图
    _lineChartView = [[TTCSellCountViewCellLineChartView alloc] init];
    _lineChartView.hidden = YES;
    [self.contentView addSubview:_lineChartView];
    //圆形统计图
//    _roundChartView = [[TTCSellCountViewCellRoundChartView alloc] init];
//    _roundChartView.hidden = YES;
//    [self.contentView addSubview:_roundChartView];
    
    //新添加的饼状图
    _roundChartView = [[TTCSellCountViewCellNewPieView alloc]init];
    _roundChartView.hidden = YES;
    [self.contentView addSubview:_roundChartView];
    
}
- (void)setSubViewLayout{
    //本月提成
    [_businessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //topView
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //每月目标
    [_goalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //折线图
    [_lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //圆形统计图
    [_roundChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //-----add------
//    //新添加的饼状图
//    [_NewPieView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.contentView);
//    }];
    //销售类型统计
    [_businessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];

}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//选择Cell类型
- (void)selectCellType:(CellType)type{
    switch (type) {
        case 0:
            [self useRoyaltyViewType];
            break;
        case 1:
            [self useTopViewType];
            break;
        case 2:
            [self useGoalViewType];
            break;
        case 3:
            [self useLineChartViewType];
            break;
        case 4:
            [self useRoundChartViewType];
            break;
        default:
            break;
    }
}
//本月提成
- (void)useRoyaltyViewType{
    _goalView.hidden = YES;
    _businessView.hidden = NO;
    _topView.hidden = YES;
    _lineChartView.hidden = YES;
    _roundChartView.hidden = YES;
}
//TopView
- (void)useTopViewType{
    _goalView.hidden = YES;
    _businessView.hidden = YES;
    _topView.hidden = NO;
    _lineChartView.hidden = YES;
    _roundChartView.hidden = YES;
}
//每月目标
- (void)useGoalViewType{
    _goalView.hidden = NO;
    _businessView.hidden = YES;
    _topView.hidden = YES;
    _lineChartView.hidden = YES;
    _roundChartView.hidden = YES;
}
//折线图
- (void)useLineChartViewType{
    _goalView.hidden = YES;
    _businessView.hidden = YES;
    _lineChartView.hidden = NO;
    _topView.hidden = YES;
    _roundChartView.hidden = YES;
}
//圆形统计图
- (void)useRoundChartViewType{
    _goalView.hidden = YES;
    _businessView.hidden = YES;
    _topView.hidden = YES;
    _lineChartView.hidden = YES;
    _roundChartView.hidden = NO;
}

//载入顶部数据
- (void)loadWithMSales:(NSString *)mSales dSales:(NSString *)dSales ranking:(NSString *)ranking{
    [_topView loadWithMSales:mSales dSales:dSales ranking:ranking];
}
//载入数据
- (void)loadLineChartWithArray:(NSArray *)array{
    [_lineChartView loadLineChartWithArray:array];
}
////加载提成
//- (void)loadRoyaltyWithRoyalty:(NSString *)royaltyString{
//    [_royaltyView loadRoyaltyWithRoyalty:royaltyString];
//}
//加载饼状图
- (void)loadPiePercentWithArray:(NSArray *)dataArray{
    [_roundChartView loadPiePercentWithArray:dataArray];
}
//加载本月已完成百分比
- (void)loadFinishPercentWithPercent:(float)percent{
    [_goalView loadFinishPercentWithPercent:percent];
}
//加载销售类型统计
- (void)loadBusinessStatisticsWithArray:(NSArray*)array{
    [_businessView loadDataWithArray:array];
}
@end
