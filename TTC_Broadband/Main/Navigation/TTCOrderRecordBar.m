//
//  TTCOrderRecordBar.m
//  TTC_Broadband
//
//  Created by apple on 15/12/19.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordBar.h"
//Macro
#define kButtonTag 14000
#define kSelectedColor  [UIColor colorWithRed:255/256.0 green:180/256.0 blue:0 alpha:1]
@interface TTCOrderRecordBar()
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *leaveButton;
@property (strong, nonatomic) UIImageView *custImageView;
@property (strong, nonatomic) UILabel *custNameLabel;
@end

@implementation TTCOrderRecordBar
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
    //客户头像
    _custImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_customer"]];
    [self addSubview:_custImageView];
    //客户名称
    _custNameLabel = [[UILabel alloc] init];
    _custNameLabel.font = FONTSIZESBOLD(30/2);
    _custNameLabel.textColor = WHITE;
    _custNameLabel.text = @"客户 ";
    [self addSubview:_custNameLabel];
    //全部订单 未支付订单
    NSArray *buttonNameArray = @[@"全部订单",@"未支付订单"];
    for (int i = 0; i < 2; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            allButton.backgroundColor = kSelectedColor;
            allButton.selected = YES;
        }else{
            allButton.backgroundColor = WHITE;
            allButton.selected = NO;
        }
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [allButton setTitle:buttonNameArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:DARKBLUE forState:UIControlStateNormal];
        [allButton setTitleColor:WHITE forState:UIControlStateSelected];
        allButton.titleLabel.font = FONTSIZESBOLD(33/2);
        [self addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_custImageView.mas_centerY);
            make.width.mas_equalTo(185/2);
            make.height.mas_equalTo(63/2);
            make.right.mas_equalTo(-272/2+(i*(172/2)));
        }];
    }
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
    //客户头像
    [_custImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(247/2);
        make.top.mas_equalTo(153/2);//210/2
        make.left.mas_equalTo(155/2);//90/2
        make.width.height.mas_equalTo(172/2);
    }];
    //客户名称
    [_custNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_custImageView.mas_centerY);
        make.left.mas_equalTo(_custImageView.mas_right).with.offset(10);
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
//点击带Tag按钮
- (void)tagButtonPressed:(UIButton *)button{
    for (int i = 0; i < 2; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:i+kButtonTag];
        allButton.backgroundColor = WHITE;
        allButton.selected = NO;
    }
    button.backgroundColor = kSelectedColor;
    button.selected = YES;
    NSString *postNameString;
    if (button.tag == kButtonTag) {
        postNameString = @"全部订单";
    }else{
        postNameString = @"未支付订单";
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:postNameString object:self userInfo:nil];
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
//更新点选按钮
- (void)reloadSelectedButtonWithIsAll:(BOOL)isAll{
    for (int i = 0; i < 2; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:i+kButtonTag];
        if (!isAll) {
            if (i == 0) {
                allButton.backgroundColor = WHITE;
                allButton.selected = NO;
            }else if(i == 1){
                allButton.backgroundColor = kSelectedColor;
                allButton.selected = YES;
            }
        }else{
            if (i == 1) {
                allButton.backgroundColor = WHITE;
                allButton.selected = NO;
            }else if(i == 0){
                allButton.backgroundColor = kSelectedColor;
                allButton.selected = YES;
            }
        }
    }
}
@end
