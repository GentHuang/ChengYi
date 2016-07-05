//
//  TTCSellCountViewCellRoundChartView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellCountViewCellRoundChartView.h"
#import "TTCSellCountViewCellPieView.h"
@interface TTCSellCountViewCellRoundChartView()
@property (strong, nonatomic) TTCSellCountViewCellPieView *leftPieView;
@end
@implementation TTCSellCountViewCellRoundChartView
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
    self.clipsToBounds = YES;
    //左边饼状图
    _leftPieView = [[TTCSellCountViewCellPieView alloc] init];
    _leftPieView.center  = CGPointMake(SCREEN_MAX_WIDTH/2, 300/2);
    _leftPieView.bounds = CGRectMake(0, 0, 400, 300);
    [self addSubview:_leftPieView];
    //透明前景
    UIView *frontView = [[UIView alloc] init];
    frontView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    frontView.layer.masksToBounds = YES;
    frontView.layer.cornerRadius = 35;
    [self addSubview:frontView];
    [frontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_leftPieView);
        make.width.height.mas_equalTo(70);
    }];
}
- (void)setSubViewLayout{
//    //左边饼状图
//    [_leftPieView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self);
//        make.height.mas_equalTo(self.mas_height);
//        make.width.mas_equalTo(300);
//    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载
- (void)loadPiePercentWithArray:(NSArray *)dataArray{
    [_leftPieView loadPiePercentWithArray:dataArray];
}
@end
