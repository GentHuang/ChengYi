//
//  TTCUserLocateBar.m
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateBar.h"

@interface TTCUserLocateBar()
//客户定位
@property (strong, nonatomic) UIImageView *userLocateBackgroundImageView;
@property (strong, nonatomic) UILabel *userLocateHeaderLabel;
@property (strong, nonatomic) UIButton *userLoacateScanButton;
@property (strong, nonatomic) UIButton *userLoacateBackButton;
//add
//提示扫一扫
@property (strong, nonatomic) UILabel *hitScanLabel;
//扫一扫button
@property (strong, nonatomic) UIButton *scanButton;

@end
@implementation TTCUserLocateBar
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
    //客户定位
    self.barTintColor = CLEAR;
    //背景
    _userLocateBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    _userLocateBackgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_userLocateBackgroundImageView];
    //顶部标题
    _userLocateHeaderLabel = [[UILabel alloc] init];
    _userLocateHeaderLabel.textColor = WHITE;
    _userLocateHeaderLabel.textAlignment = NSTextAlignmentCenter;
    _userLocateHeaderLabel.text = @"客户定位";
    _userLocateHeaderLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_userLocateHeaderLabel];
    
    //扫一扫按钮
    _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_scanButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_scanButton setBackgroundImage:[UIImage imageNamed:@"barCodeScan"] forState:UIControlStateNormal];
    [_scanButton setBackgroundImage:[UIImage imageNamed:@"barCodeScan"] forState:UIControlStateHighlighted];

    [_userLocateBackgroundImageView addSubview:_scanButton];
    //添加扫一扫按钮以及提示
    _hitScanLabel = [[UILabel alloc]init];
    _hitScanLabel.text = @"扫一扫";
    _hitScanLabel.textColor = WHITE;
    _hitScanLabel.font = FONTSIZES(19);
    _hitScanLabel.textAlignment = NSTextAlignmentCenter;
    [_userLocateBackgroundImageView addSubview:_hitScanLabel];
    
    //后退按钮
    _userLoacateBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userLoacateBackButton.backgroundColor = CLEAR;
    [_userLoacateBackButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_userLoacateBackButton setImageEdgeInsets:UIEdgeInsetsMake(-4, -40, 0, 0)];
    [_userLoacateBackButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_userLoacateBackButton];

}
- (void)setSubViewLayout{
    //背景
    [_userLocateBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        
    }];
    //顶部标题
    [_userLocateHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //扫一扫button
    [_scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_userLocateBackgroundImageView);
        make.width.height.mas_equalTo(150/2);
    }];
    //提示扫一扫
    [_hitScanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_userLocateBackgroundImageView).offset(-20);
        make.centerX.equalTo(_userLocateHeaderLabel);
//        make.height
    }];
    
    //后退按钮
    [_userLoacateBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(STA_HEIGHT+20);
        make.width.mas_equalTo(100);
    }];
}
#pragma mark - Event response
//点击按钮(全局按钮)
- (void)buttonPressed:(UIButton *)button{
    if(button == _scanButton){
        //点击扫一扫按钮
        self.stringBlock(@"扫一扫");
    }else if(button == _userLoacateBackButton){
        //点击后退按钮
        self.stringBlock(@"后退");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置客户定位标题
- (void)loadUserLocateHeaderLabel:(NSString *)title{
    _userLocateHeaderLabel.text = title;
}
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack{
    _userLoacateBackButton.hidden = !canGoBack;
}

@end
