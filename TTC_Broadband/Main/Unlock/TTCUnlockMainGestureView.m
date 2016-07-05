//
//  TTCUnlockMainGestureView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
#import "TTCUnlockMainGestureView.h"
//Tool
#import "YLSwipeLockView.h"
@interface TTCUnlockMainGestureView()<YLSwipeLockViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSString *gesturePSW;
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *inputLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIButton *changeButton;
@property (strong, nonatomic) UIButton *forgetButton;
@property (strong, nonatomic) YLSwipeLockView *lockView;
@property (strong, nonatomic) LockInfo *lockInfo;
@end
@implementation TTCUnlockMainGestureView
#pragma mark - Init methods
- (void)initData{
    //lockInfo
    _lockInfo = [LockInfo sharedInstace];
}
- (instancetype)init{
    if (self = [super init]) {
        [self initData];
        [self creatUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)creatUI{
    _gesturePSW = nil;
    self.backgroundColor = CLEAR;
    //背景图
    _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unlock_img_bg"]];
    [self addSubview:_backImageView];
    //头像
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_avatar"]];
    [self addSubview:_avatarImageView];
    //请输入密码
    _inputLabel = [[UILabel alloc] init];
    _inputLabel.alpha = 1;
    _inputLabel.textColor = WHITE;
    _inputLabel.text = @"请输入手势";
    _inputLabel.textColor = WHITE;
    _inputLabel.font = FONTSIZESBOLD(40/2);
    _inputLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_inputLabel];
    //手势提醒
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.alpha = 0;
    _statusLabel.textColor = WHITE;
    _statusLabel.text = @"";
    _statusLabel.textColor = WHITE;
    _statusLabel.font = FONTSIZESBOLD(40/2);
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_statusLabel];
    //手势解锁
    _lockView = [[YLSwipeLockView alloc] init];
    _lockView.delegate = self;
    [self addSubview:_lockView];
    //改变登录方式
    _changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _changeButton.backgroundColor = CLEAR;
    [_changeButton addTarget:self action:@selector(allButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_changeButton setTitle:@"改变登录方式" forState:UIControlStateNormal];
    [_changeButton setTitleColor:WHITE forState:UIControlStateNormal];
    [self addSubview:_changeButton];
    //忘记密码
    _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetButton.backgroundColor = CLEAR;
    [_forgetButton addTarget:self action:@selector(allButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_forgetButton setTitle:@"忘记手势密码?" forState:UIControlStateNormal];
    [_forgetButton setTitleColor:WHITE forState:UIControlStateNormal];
    [self addSubview:_forgetButton];
}
- (void)setSubViewLayout{
    //背景图
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //头像
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(185/2);
        make.width.height.mas_equalTo(300/2);
    }];
    //请输入密码
    [_inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(_avatarImageView.mas_bottom).with.offset(70/2);
    }];
    //手势提醒
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(_avatarImageView.mas_bottom).with.offset(70/2);
    }];
    //手势解锁
    [_lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //改变登录方式
    [_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-200);
        make.right.mas_equalTo(-355/2);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(80);
    }];
    //忘记密码
    [_forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-200);
        make.left.mas_equalTo(400/2);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(80);
    }];
}
#pragma mark - Event response
//忘记密码和改变登录方式
- (void)allButtonPressed:(UIButton *)button{
    if (button == _changeButton) {
        self.stringBlock(@"改变登录方式");
    }else if(button == _forgetButton){
        self.stringBlock(@"忘记密码");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
//YLSwipeLockViewDelegate Method
-(YLSwipeLockViewState)swipeView:(YLSwipeLockView *)swipeView didEndSwipeWithPassword:(NSString *)password{
    if ([[password MD5Digest] isEqualToString:_lockInfo.gesturePSW]) {
        //密码通过
        self.stringBlock(@"手势密码登录成功");
        [_lockView cleanNodes];
        return YLSwipeLockViewStateSelected;
    }else{
        //密码不通过
        [self shakeAnimationForView:_inputLabel];
        return YLSwipeLockViewStateWarning;
    }
}
#pragma mark - Other methods
//抖动
- (void)shakeAnimationForView:(UIView *) view{
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:3];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}
@end
