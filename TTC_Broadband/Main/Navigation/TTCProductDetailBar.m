//
//  TTCProductDetailBar.m
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCProductDetailBar.h"

@interface TTCProductDetailBar()
//产品详情
@property (strong, nonatomic) UIImageView *productDetailBackgroundImageView;
@property (strong, nonatomic) UILabel *productDetailHeaderLabel;
@property (strong, nonatomic) UIButton *productDetailBackButton;
@end
@implementation TTCProductDetailBar
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
    _productDetailBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_productDetailBackgroundImageView];
    //顶部标题
    _productDetailHeaderLabel = [[UILabel alloc] init];
    _productDetailHeaderLabel.textColor = WHITE;
    _productDetailHeaderLabel.textAlignment = NSTextAlignmentCenter;
    _productDetailHeaderLabel.text = @"产品详情";
    _productDetailHeaderLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_productDetailHeaderLabel];
    //后退按钮
    _productDetailBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _productDetailBackButton.backgroundColor = CLEAR;
    [_productDetailBackButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_productDetailBackButton setImageEdgeInsets:UIEdgeInsetsMake(-4, -40, 0, 0)];
    [_productDetailBackButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_productDetailBackButton];
}
- (void)setSubViewLayout{
    //产品库
    //背景
    [_productDetailBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //顶部标题
    [_productDetailHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //后退按钮
    [_productDetailBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.mas_equalTo(100);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if(button == _productDetailBackButton){
        self.stringBlock(@"后退");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置产品详情标题
- (void)loadproductDetailHeaderLabel:(NSString *)title{
    _productDetailHeaderLabel.text = title;
}
//设置是否可以后退
- (void)canGoBack:(BOOL)canGoBack{
    _productDetailBackButton.hidden = !canGoBack;
}

@end

