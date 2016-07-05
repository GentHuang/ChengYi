//
//  TTCProductLibBar.m
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCProductLibBar.h"

@interface TTCProductLibBar()
//产品库
@property (strong, nonatomic) UIImageView *productLibBackgroundImageView;
@property (strong, nonatomic) UILabel *productLibHeaderLabel;
@property (strong, nonatomic) UIButton *productLibSearchButton;
@property (strong, nonatomic) UIButton *productLibBackButton;
@end
@implementation TTCProductLibBar
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
    //产品库
    self.barTintColor = CLEAR;
    //背景
    _productLibBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_productLibBackgroundImageView];
    //顶部标题
    _productLibHeaderLabel = [[UILabel alloc] init];
    _productLibHeaderLabel.textColor = WHITE;
    _productLibHeaderLabel.textAlignment = NSTextAlignmentCenter;
    _productLibHeaderLabel.text = @"产品库";
    _productLibHeaderLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_productLibHeaderLabel];
    //客户离开
    _productLibSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_productLibSearchButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _productLibSearchButton.backgroundColor = CLEAR;
    [_productLibSearchButton setImage:[UIImage imageNamed:@"nav_img_leave_udel"] forState:UIControlStateNormal];
    _productLibSearchButton.titleLabel.font = FONTSIZESBOLD(29/2);
    [_productLibSearchButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -10, 0, 0)];
    [_productLibSearchButton setImageEdgeInsets:UIEdgeInsetsMake(20, -10, 0, 0)];
    [self addSubview:_productLibSearchButton];
}
- (void)setSubViewLayout{
    //产品库
    //背景
    [_productLibBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //顶部标题
    [_productLibHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //客户离开
    [_productLibSearchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _productLibSearchButton) {
        self.stringBlock(@"客户离开");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置产品库标题
- (void)loadProductLibHeaderLabel:(NSString *)title{
    _productLibHeaderLabel.text = title;
}

@end
