//
//  TTCOrderRecordBar.m
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCAccuntResultBar.h"
//Macro
#define kButtonTag 14100
#define kSelectedColor  [UIColor colorWithRed:255/256.0 green:180/256.0 blue:0 alpha:1]

@interface TTCAccuntResultBar()

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *leaveButton;
@property (strong, nonatomic) UIImageView *custImageView;
@property (strong, nonatomic) UILabel *custNameLabel;
@end

@implementation TTCAccuntResultBar
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
    //背景
    _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_backImageView];
    //顶部标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = WHITE;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"";
    _titleLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_titleLabel];
    //后退按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.backgroundColor = CLEAR;
    [_backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(-140, -40, 0, 0)];
    [_backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    //客户离开
    _leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leaveButton.backgroundColor = CLEAR;
    [_leaveButton setImage:[UIImage imageNamed:@"nav_img_leave_udel"] forState:UIControlStateNormal];
    [_leaveButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_leaveButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 40, 0)];
    [self addSubview:_leaveButton];
}
- (void)setSubViewLayout{
    //背景
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //顶部标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //后退按钮
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.mas_equalTo(100);
    }];
    //客户离开
    [_leaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STA_HEIGHT);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(80);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if(button == _backButton){
        self.stringBlock(@"后退");
    }else if (button == _leaveButton){
        self.stringBlock(@"客户离开");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置标题
- (void)loadOrderRecordLabel:(NSString *)title{
    _titleLabel.text = title;
}
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack{
    _backButton.hidden = !canGoBack;
}
//加载订单记录客户名称
- (void)loadOrderRecordCustNameLabelWith:(NSString *)custNameString{
    _custNameLabel.text = [NSString stringWithFormat:@"客户 %@",custNameString];
}

@end
