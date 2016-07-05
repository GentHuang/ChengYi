//
//  TTCOrderRecordViewCellSellDetailView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordViewCellSellDetailView.h"


@interface TTCOrderRecordViewCellSellDetailView()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *locateButton;
@end

@implementation TTCOrderRecordViewCellSellDetailView
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
    //日期，周几，客户ID
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"2015-10-13 周二 客户ID：54321";
    _titleLabel.textColor = LIGHTDARK;
    _titleLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_titleLabel];
    //定位该客户
    _locateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _locateButton.hidden = YES;
    [_locateButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _locateButton.backgroundColor = DARKBLUE;
    [_locateButton setTitle:@"定位该客户" forState:UIControlStateNormal];
    [_locateButton setTitleColor:WHITE forState:UIControlStateNormal];
    _locateButton.titleLabel.font = FONTSIZESBOLD(31/2);
    _locateButton.layer.masksToBounds = YES;
    _locateButton.layer.cornerRadius = 4;
    [self addSubview:_locateButton];
}
- (void)setSubViewLayout{
    //日期，周几，客户ID
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(57/2);
    }];
    //定位该客户
    [_locateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-57/2);
        make.width.mas_equalTo(204/2);
        make.height.mas_equalTo(50/2);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed{
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:_locateButton.titleLabel.text object:self userInfo:nil];
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载客户信息
- (void)loadWithDate:(NSString *)date keyno:(NSString *)keyno{
    _titleLabel.text = [NSString stringWithFormat:@"%@    客户ID：%@",date,keyno];
}

@end
