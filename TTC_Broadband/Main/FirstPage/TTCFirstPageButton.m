//
//  TTCFirstPageButton.m
//  TTC_Broadband
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCFirstPageButton.h"

@interface TTCFirstPageButton()
@property (strong, nonatomic) UIImageView *buttonImageView;
@property (strong, nonatomic) UILabel *buttonTitleLabel;
@end

@implementation TTCFirstPageButton
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
    self.userInteractionEnabled = YES;
    self.backgroundColor = CLEAR;
    self.layer.borderWidth = 0.25;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"first_btn_sel"] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"first_btn_nor"] forState:UIControlStateNormal];
    //图片
    _buttonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"first_btn_1"]];
    _buttonImageView.userInteractionEnabled = NO;
    [self addSubview:_buttonImageView];
    //标题
    _buttonTitleLabel = [[UILabel alloc] init];
    _buttonTitleLabel.textAlignment = NSTextAlignmentCenter;
    _buttonTitleLabel.text = @"客户定位";
    _buttonTitleLabel.font = FONTSIZESBOLD(33/2);
    _buttonTitleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_buttonTitleLabel];
}
- (void)setSubViewLayout{
    //图片
    [_buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80/2);
        make.top.mas_equalTo(108/2);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    //标题
    [_buttonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(-107/2);
        make.height.mas_equalTo(33/2);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//刷新图片
- (void)loadButtonImage:(UIImage *)image{
    _buttonImageView.image = image;
}
//刷新标题
- (void)loadButtonTitle:(NSString *)title{
    _buttonTitleLabel.text = title;
}
@end
