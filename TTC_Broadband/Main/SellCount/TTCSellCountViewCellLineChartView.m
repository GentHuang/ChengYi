//
//  TTCSellCountViewCellLineChartView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//View
#import "TTCSellCountViewCellLineChartView.h"
//Tool
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"

@interface TTCSellCountViewCellLineChartView()
@property (strong, nonatomic) FSLineChart *lineChart;
@end

@implementation TTCSellCountViewCellLineChartView
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    //折线图
    _lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(100, 25, 1140/2, 560/2)];
    //设置折线颜色
    _lineChart.color = [UIColor colorWithRed:45/256.0 green:200/256.0 blue:202/256.0 alpha:1];
    //设置轴线颜色
    _lineChart.axisColor = DARKBLUE;
      //X轴数据
    _lineChart.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    //Y轴数据
    _lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f", value];
    };
    //设置X与Y轴段数
    _lineChart.gridStep = 6;
    [self addSubview:_lineChart];
    
}
- (void)setSubViewLayout{
    //折线图
    [_lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50/2);
        make.left.mas_equalTo(200/2);
        make.right.mas_equalTo(-200/2);
        make.bottom.mas_equalTo(-70/2);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//载入数据
- (void)loadLineChartWithArray:(NSArray *)array{
    if (_lineChart) {
        [_lineChart removeFromSuperview];
        //折线图
        _lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(100, 25, 1140/2, 560/2)];
        //设置折线颜色
        _lineChart.color = [UIColor colorWithRed:45/256.0 green:200/256.0 blue:202/256.0 alpha:1];
        //设置轴线颜色
        _lineChart.axisColor = DARKBLUE;
        //X轴数据
        _lineChart.labelForIndex = ^(NSUInteger item) {
            return [NSString stringWithFormat:@"%lu",(unsigned long)item];
        };
        //Y轴数据
        _lineChart.labelForValue = ^(CGFloat value) {
            return [NSString stringWithFormat:@"%.f", value];
        };
        //设置X与Y轴段数
        _lineChart.gridStep = 6;
        [self addSubview:_lineChart];
        //折线图
        [_lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50/2);
            make.left.mas_equalTo(200/2);
            make.right.mas_equalTo(-200/2);
            make.bottom.mas_equalTo(-70/2);
        }];
    }
    //创建表格
    [_lineChart setChartData:array];
}
@end
