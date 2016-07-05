//
//  TTCPrintDetailViewClickButtonView.m
//  TTC_Broadband
//
//  Created by apple on 16/2/18.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCPrintDetailViewConfirmButtonView.h"

@interface TTCPrintDetailViewConfirmButtonView()

@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIButton *fillInButton;
@end

@implementation TTCPrintDetailViewConfirmButtonView

- (instancetype)init {
    if (self=[super init]) {
        [self creatUI];
    }                 
    return self;
}
- (void)creatUI {
    
    //打印发票
    _fillInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _fillInButton.layer.masksToBounds = YES;
    _fillInButton.layer.cornerRadius = 3;
    _fillInButton.backgroundColor = DARKBLUE;
    [_fillInButton setTitle:@"确认打印" forState:UIControlStateNormal];
    [_fillInButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _fillInButton.titleLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_fillInButton];
    
    [_fillInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-58/2);
        make.top.mas_equalTo((112/2-73/2)/2);
        make.width.mas_equalTo(194/2);
        make.height.mas_equalTo(73/2);
    }];
    
}
//全局按钮点击
- (void)buttonPressed:(UIButton *)button{
    self.stringBlock(button.titleLabel.text);
}


@end
