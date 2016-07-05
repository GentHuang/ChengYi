//
//  TTCPaySweepQRcodeView.m
//  TTC_Broadband
//
//  Created by apple on 16/5/7.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCPaySweepQRcodeWebView.h"
@interface TTCPaySweepQRcodeWebView()
//背景图
@property (strong ,nonatomic)  UIView *backgroundView;
//返回按钮
@property (strong, nonatomic) UIButton *backButton;
//支付完成按钮
@property (strong, nonatomic) UIButton *finishPayButton;
//分割线
@property (strong, nonatomic) UILabel *spreadLine;
//支付页面
@property (strong, nonatomic) UIWebView *payWebView;
//扫描说明
@property (strong, nonatomic) UILabel *describeLabel;

@end

@implementation TTCPaySweepQRcodeWebView

- (instancetype)init {
    if (self = [super init]) {
        [self CreatUI];
        [self CreatLayout];
    }
    return self;
}
- (void)CreatUI {
    //背景图
    _backgroundView = [[UIView alloc]init];
    _backgroundView.layer.cornerRadius = 5.0;
    _backgroundView.backgroundColor =[UIColor whiteColor];
    [self addSubview:_backgroundView];
    
    //返回按钮
    _backButton = [[UIButton alloc]init];
    [_backgroundView addSubview:_backButton];
    [_backButton setTitle:@"取消" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(ButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitleColor:[UIColor colorWithRed:204/256.0 green:45/256.0 blue:255/256.0 alpha:1] forState:0];
    //支付完成按钮
    _finishPayButton = [[UIButton alloc]init];
    [_backgroundView addSubview:_finishPayButton];
    [_finishPayButton setTitle:@"完成" forState:UIControlStateNormal];
    _finishPayButton.hidden =YES;
    [_finishPayButton setTitleColor:[UIColor colorWithRed:204/256.0 green:45/256.0 blue:255/256.0 alpha:1] forState:0];
    [_finishPayButton addTarget:self action:@selector(ButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    //分割线
    _spreadLine = [[UILabel alloc]init];
    [_backgroundView addSubview:_spreadLine];
    _spreadLine.backgroundColor = [UIColor orangeColor];
    
    //支付页面
    _payWebView = [[UIWebView alloc]init];
    _payWebView.backgroundColor = WHITE;
    [_backgroundView addSubview:_payWebView];
    _payWebView.opaque = NO;
    _payWebView.scrollView.scrollEnabled = NO;
    //扫描说明
    _describeLabel = [[UILabel alloc]init];
    _describeLabel.text = @"扫一扫上面的二维码图案，即可购买";
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    _describeLabel.font = [UIFont systemFontOfSize:20];
    _describeLabel.backgroundColor = WHITE;
    [_backgroundView addSubview:_describeLabel];
    
}
- (void)CreatLayout {
    //背景图
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(400);
    }];
    //取消按钮
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundView.mas_top).offset(10);
        make.left.equalTo(_backgroundView.mas_left).offset(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    //完成按钮
    [_finishPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundView.mas_top).offset(10);
        make.right.equalTo(_backgroundView.mas_right).offset(-30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    //分割线
    [_spreadLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backButton.mas_bottom).offset(5);
        make.left.right.equalTo(_backgroundView);
        make.height.mas_equalTo(1);
    }];
    //支付Web页面
    [_payWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spreadLine.mas_bottom).offset(30);
        make.centerX.equalTo(_backgroundView);
        make.width.height.mas_equalTo(230);
    }];
    //扫描支付说明
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payWebView.mas_bottom).offset(20);
        make.left.right.equalTo(_backgroundView);
        make.height.mas_equalTo(30);
    }];
}
#pragma mar  Event Touch
- (void)ButtonPress:(UIButton*)button {
    self.hidden = YES;
    self.buttonPress(button);
}
//加载数据
- (void)loadWebView:(NSString*)string {
    
    NSString *urlString = [NSString stringWithFormat:@"%@",string];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_payWebView loadRequest:request];
    
}

@end
