//
//  TTCUserDetailHeaderView.m
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserDetailHeaderView.h"

@interface TTCUserDetailHeaderView()
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *downView;
@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UIButton *upgradeButton;
@end

@implementation TTCUserDetailHeaderView
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
    self.backgroundColor = WHITE;
    //topView
    _topView  = [[UIView alloc] init];
    _topView.backgroundColor = LIGHTGRAY;
    [self addSubview:_topView];
    //downView
    _downView  = [[UIView alloc] init];
    _downView.backgroundColor = WHITE;
    [self addSubview:_downView];
    //headerImageVIew
    _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"udel_img_address"]];
    [_downView addSubview:_headerImageView];
    //addressLabel
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.text = @"广州市天河智慧园C座602";
    _addressLabel.textColor = LIGHTDARK;
    _addressLabel.font = FONTSIZESBOLD(30/2);
    [_downView addSubview:_addressLabel];
    //升级
    _upgradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _upgradeButton.hidden = YES;
    [_upgradeButton addTarget:self action:@selector(upgradeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_upgradeButton setTitle:@"升级" forState:UIControlStateNormal];
    _upgradeButton.titleLabel.font = FONTSIZESBOLD(30/2);
    _upgradeButton.backgroundColor = DARKBLUE;
    _upgradeButton.layer.masksToBounds = YES;
    _upgradeButton.layer.cornerRadius = 4;
    [_downView addSubview:_upgradeButton];
}
- (void)setSubViewLayout{
    //topView
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(24/2);
    }];
    //downView
    [_downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self);
    }];
    //headerImageView
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_downView.mas_centerY);
        make.left.mas_equalTo(75/2);
    }];
    //addressLabel
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_downView.mas_centerY);
        make.left.mas_equalTo(_headerImageView.mas_right).with.offset(24/2);
    }];
    //升级
    [_upgradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_downView.mas_centerY);
        make.right.mas_equalTo(-60/2);
        make.width.mas_equalTo(150/2);
    }];
}
#pragma mark - Event response
//升级按钮
- (void)upgradeButtonPressed:(UIButton *)button{
    self.cellIndexBlock(0,0);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//读取地址
- (void)loadAddressTitle:(NSString *)addressString{
    _addressLabel.text = addressString;
}
@end
