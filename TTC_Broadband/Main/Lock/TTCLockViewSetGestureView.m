//
//  TTCLockViewSetGestureView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCLockViewSetGestureView.h"
//Tool
#import "YLSwipeLockView.h"
@interface TTCLockViewSetGestureView()<YLSwipeLockViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSString *gesturePSW;
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *inputLabel;
@property (strong, nonatomic) UIButton *resetButton;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) YLSwipeLockView *lockView;
@property (strong, nonatomic) UIButton *backButton;
//是否是修改密码
@property (assign, nonatomic) BOOL  isChangePassWord;
//用户信息
@property (strong, nonatomic) LockInfo *lockInfo;
@end
@implementation TTCLockViewSetGestureView
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
    _gesturePSW = nil;
    _isChangePassWord = YES;
    //用户信息
    _lockInfo = [LockInfo sharedInstace];
    
    self.backgroundColor = CLEAR;
    //背景图
    _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unlock_img_bg"]];
    [self addSubview:_backImageView];
    //头像
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unlock_img_gesture"]];
    [self addSubview:_avatarImageView];
    //请输入密码
    _inputLabel = [[UILabel alloc] init];
    _inputLabel.alpha = 1;
    _inputLabel.textColor = WHITE;
    
    if ([_lockInfo.isChangePSW isEqualToString:@"YES"]) {
        _inputLabel.text = @"请先输入旧手势密码";
    }else {
        _inputLabel.text = @"第一次使用手势密码，请先绘制解锁密码";
    }
    
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
    //重置
    _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetButton.backgroundColor = CLEAR;
    [_resetButton addTarget:self action:@selector(resetButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_resetButton setTitle:@"重置密码" forState:UIControlStateNormal];
    [_resetButton setTitleColor:WHITE forState:UIControlStateNormal];
    _resetButton.titleLabel.font = FONTSIZESBOLD(40/2);
    _resetButton.layer.borderColor = [UIColor colorWithRed:179/256.0 green:194/256.0 blue:205/256.0 alpha:1].CGColor;
    _resetButton.layer.borderWidth = 2;
    _resetButton.layer.masksToBounds = YES;
    _resetButton.layer.cornerRadius = 2;
    [self addSubview:_resetButton];
    //后退按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.backgroundColor = CLEAR;
    [_backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(-40, -40, 0, 0)];
    [_backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
}
- (void)setSubViewLayout{
    //背景图
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //头像
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(185);
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
    //重置
    [_resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(-200);
        make.width.mas_equalTo(462/2);
        make.height.mas_equalTo(125/2);
    }];
    //后退按钮
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.height.mas_equalTo(100);
    }];
}
#pragma mark - Event response
//重置
- (void)resetButtonPressed{
    _gesturePSW = nil;
    [UIView animateWithDuration:0.5 animations:^{
        _inputLabel.alpha = 1;
        _statusLabel.alpha = 0;
    }];
}
//后退
- (void)backButtonPressed:(UIButton *)button{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
    self.backBlock(nil);
    //退出则清空之前的输入
    [self resetButtonPressed];
    _isChangePassWord = YES;
    _inputLabel.text = @"请先输入旧手势密码";
}
#pragma mark - Network request
#pragma mark - Protocol methods
//YLSwipeLockViewDelegate Method
-(YLSwipeLockViewState)swipeView:(YLSwipeLockView *)swipeView didEndSwipeWithPassword:(NSString *)password{
    if ([_lockInfo.isChangeGesture isEqualToString:@"YES"]&&_isChangePassWord) {
        if ([[password MD5Digest] isEqualToString:_lockInfo.gesturePSW]) {
            //密码通过
            _isChangePassWord = NO;
            _gesturePSW = nil;
            [_lockView cleanNodes];
            [UIView animateWithDuration:0.5 animations:^{
                _inputLabel.alpha = 0;
                _statusLabel.alpha = 1;
            }];
            _statusLabel.text = @"请输入手势";
            return YLSwipeLockViewStateSelected;
        }else{
            //密码不通过
            [self shakeAnimationForView:_inputLabel];
            _isChangePassWord = YES;
            _gesturePSW = nil;
            return YLSwipeLockViewStateWarning;
        }
        
    }else {
        if (_gesturePSW == nil) {
            [UIView animateWithDuration:0.5 animations:^{
                _inputLabel.alpha = 0;
                _statusLabel.alpha = 1;
            }];
            _gesturePSW = password;
            _statusLabel.text = @"请再次输入手势";
            return YLSwipeLockViewStateNormal;
        }else if ([_gesturePSW isEqualToString:password]){
            _statusLabel.text = @"手势设置成功";
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手势密码设置成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
            //
            _isChangePassWord = YES;
            return YLSwipeLockViewStateSelected;
        }else{
            _statusLabel.text = @"两次输入的手势不一致";
            _gesturePSW = nil;
            return YLSwipeLockViewStateWarning;
        }
    }

}
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.stringBlock(_gesturePSW);
        //重置输入的密码
        _gesturePSW = nil;
        //清空手势
        [_lockView cleanNodes];
        _statusLabel.text = @"请再次输入手势";
        [UIView animateWithDuration:0.5 animations:^{
            _inputLabel.alpha = 1;
            _statusLabel.alpha = 0;
        }];
    }
}

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
#pragma mark - Other methods

@end
