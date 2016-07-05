//
//  TTCAccountInfoBar.m
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCAccountInfoBar.h"
@interface TTCAccountInfoBar()
@property (strong, nonatomic) UIImageView *accountInfoBackgroundImageView;
@property (strong, nonatomic) UILabel *accountInfoHeaderLabel;
@property (strong, nonatomic) UIButton *accountInfoBackButton;
@property (strong, nonatomic) UIButton *accountInfoLeaveButton;
@end
@implementation TTCAccountInfoBar
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
    self.barTintColor = CLEAR;
    //背景
    _accountInfoBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_accountInfoBackgroundImageView];
    //顶部标题
    _accountInfoHeaderLabel = [[UILabel alloc] init];
    _accountInfoHeaderLabel.textColor = WHITE;
    _accountInfoHeaderLabel.textAlignment = NSTextAlignmentCenter;
    _accountInfoHeaderLabel.text = @"账本信息";
    _accountInfoHeaderLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_accountInfoHeaderLabel];
    //后退按钮
    _accountInfoBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _accountInfoBackButton.backgroundColor = CLEAR;
    [_accountInfoBackButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_accountInfoBackButton setImageEdgeInsets:UIEdgeInsetsMake(-4, -40, 0, 0)];
    [_accountInfoBackButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_accountInfoBackButton];
    //客户离开
    _accountInfoLeaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _accountInfoLeaveButton.backgroundColor = CLEAR;
//    _accountInfoLeaveButton.hidden = YES;
    [_accountInfoLeaveButton setImage:[UIImage imageNamed:@"nav_img_leave_udel"] forState:UIControlStateNormal];
    [_accountInfoLeaveButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_accountInfoLeaveButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 40, 0)];
    [self addSubview:_accountInfoLeaveButton];
}
- (void)setSubViewLayout{
    //背景
    [_accountInfoBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //顶部标题
    [_accountInfoHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //后退按钮
    [_accountInfoBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.mas_equalTo(100);
    }];
    //客户离开
    [_accountInfoLeaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STA_HEIGHT);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(80);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if(button == _accountInfoBackButton){
        self.stringBlock(@"后退");
    }else{
        self.stringBlock(@"客户离开");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置标题
- (void)loadAccountInfoHeaderLabel:(NSString *)title{
    _accountInfoHeaderLabel.text = title;
}
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack{
    _accountInfoBackButton.hidden = !canGoBack;
}
- (void)accountInfoLeaveButton:(BOOL)isShowButton {
    _accountInfoLeaveButton.hidden = isShowButton;
}
@end

