//
//  TTCLoginMainView.m
//  TTC_Broadband
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//View
#import "TTCLoginMainView.h"

@interface TTCLoginMainView()
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *bottomLabel;

@property (strong, nonatomic) UILabel *versionLabelName;

@end

@implementation TTCLoginMainView
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        [self creatUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)creatUI{
    self.backgroundColor = CLEAR;
    //背景图
    _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_img_bg"]];
    [self addSubview:_backImageView];
    //底部介绍
    _bottomLabel = [[UILabel alloc] init];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.text = @"版权所有  天途有线\nCopyright @ 2015 Dalian Tiantu Cable Television Network Co.,LTD.All Rights Reserved";
    _bottomLabel.numberOfLines = 0;
    _bottomLabel.textColor = WHITE;
    _bottomLabel.font = FONTSIZESBOLD(25/2);
    [self addSubview:_bottomLabel];
    
    //版本号
    _versionLabelName = [[UILabel alloc]init];
    _versionLabelName.textColor = WHITE;
    _versionLabelName.textAlignment = NSTextAlignmentCenter;
    _versionLabelName.font = FONTSIZESBOLD(25/2);
    [self addSubview:_versionLabelName];
    [self judgeVersionName];
}
- (void)setSubViewLayout{
    //背景图
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //底部介绍
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-46/2);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    //版本提示
    [_versionLabelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-70);
        make.centerX.equalTo(self.mas_centerX);
    }];
}
//添加判断是测试版还是正式版
- (void)judgeVersionName {
    NSString *versionName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];// CFBundleVersion
    _versionLabelName.text = [NSString stringWithFormat:@"当前版本%@",versionName] ;
    if ([HTML5URL isEqualToString:@"http://10.1.131.100"]) {
        _versionLabelName.text = [NSString stringWithFormat:@"当前版本%@  内网测试版",versionName];
        NSLog(@"内网测试");
        
    }else if ([HTML5URL isEqualToString:@"http://10.1.131.100:8080"]){
        _versionLabelName.text = [NSString stringWithFormat:@"当前版本%@  内网正式版",versionName];
        NSLog(@"内网正式");

    }else if ([HTML5URL isEqualToString:@"http://58.244.255.161:20023"]){
        _versionLabelName.text = [NSString stringWithFormat:@"当前版本%@  外网测试版",versionName];

        NSLog(@"外网测式");

    }else if ([HTML5URL isEqualToString:@"http://222.62.210.6:20025"]){
        _versionLabelName.text = [NSString stringWithFormat:@"当前版本%@  外网正式版",versionName];
        NSLog(@"外网正式");

    }
}

#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
@end
