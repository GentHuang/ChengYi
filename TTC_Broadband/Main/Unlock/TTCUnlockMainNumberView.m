//
//  TTCUnlockMainNumberView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUnlockMainNumberView.h"
//Tool
#import "AudioToolbox/AudioToolbox.h"
//Macro
#define kButtonTag 45000
#define kPointTag 46000
@interface TTCUnlockMainNumberView()
@property (assign, nonatomic) int pressCount;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIImageView *backGroundImageView;
@property (strong, nonatomic) UILabel *inputLabel;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIButton *changeButton;
@property (strong, nonatomic) UIButton *forgetButton;
@property (strong, nonatomic) NSString *inputPSW;
@property (strong, nonatomic) LockInfo *lockInfo;
//取消按钮
@property (strong, nonatomic) UIButton *cancelButton;
@end
@implementation TTCUnlockMainNumberView
#pragma mark - Init methods
- (void)initData{
    //输入的密码
    _inputPSW = [[NSString alloc] init];
    //点击的次数
    _pressCount = 0;
    //lockInfo
    _lockInfo = [LockInfo sharedInstace];
}
- (instancetype)init{
    if (self = [super init]) {
        [self initData];
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    //背景
    _backGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unlock_img_bg"]];
    [self addSubview:_backGroundImageView];
    //头像
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_avatar"]];
    [self addSubview:_avatarImageView];
    //请输入密码
    _inputLabel = [[UILabel alloc] init];
    _inputLabel.textColor = WHITE;
    _inputLabel.text = @"请输入密码";
    _inputLabel.textColor = WHITE;
    _inputLabel.font = FONTSIZESBOLD(40/2);
    _inputLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_inputLabel];
    //密码确认点
    for (int i = 0; i < 4; i ++) {
        UIView *pointView = [[UIView alloc] init];
        pointView.tag = i + kPointTag;
        pointView.layer.borderWidth = 0.5;
        pointView.layer.borderColor = WHITE.CGColor;
        pointView.layer.cornerRadius = 30/4;
        [self addSubview:pointView];
        [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_inputLabel.mas_bottom).with.offset(34/2);
            make.left.mas_equalTo(_inputLabel.mas_left).with.offset(i*(82/2)-12.5);
            make.width.height.mas_equalTo(30/2);
        }];
    }
    //密码盘
    for (int i = 0; i < 10; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i + kButtonTag;
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [allButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"unlock_img%d",i]] forState:UIControlStateNormal];
        [self addSubview:allButton];
        if (i == 0) {
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(740/2+(9/3)*(214/2));
                make.left.mas_equalTo((1%3)*(214/2)+475/2);
                make.width.height.mas_equalTo(163/2);
            }];
        }else{
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(740/2+((i-1)/3)*(214/2));
                make.left.mas_equalTo(((i-1)%3)*(214/2)+475/2);
                make.width.height.mas_equalTo(163/2);
            }];
        }
    }
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
    [_forgetButton setTitle:@"忘记数字密码?" forState:UIControlStateNormal];
    [_forgetButton setTitleColor:WHITE forState:UIControlStateNormal];
    [self addSubview:_forgetButton];
    
    //取消按钮
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_cancelButton];
    _cancelButton.backgroundColor = CLEAR;
    [_cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:WHITE forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = FONTSIZESBOLD(40/2);
    //    _cancelButton.layer.borderColor = [UIColor colorWithRed:179/256.0 green:194/256.0 blue:205/256.0 alpha:1].CGColor;
    //    _cancelButton.layer.borderWidth = 2;
    //    _cancelButton.layer.masksToBounds = YES;
    //    _cancelButton.layer.cornerRadius = 2;
}
- (void)setSubViewLayout{
    //背景
    [_backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    //改变登录方式
    [_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-150);
        make.right.mas_equalTo(-355/2);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(80);
    }];
    //忘记密码
    [_forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-150);
        make.left.mas_equalTo(400/2);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(80);
    }];
    
    //数字输入取消按钮
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_changeButton.mas_centerX);
        make.bottom.mas_equalTo(_changeButton.mas_top).offset(-20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
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
//密码正确
- (void)correctPSW{
    self.stringBlock(@"数字密码登录成功");
    //重置小圆点
    for (int i = 0; i < 4; i ++) {
        UIView *pointView = (UIView *)[self viewWithTag:(i+kPointTag)];
        pointView.backgroundColor = CLEAR;
    }
}
//取消按钮
- (void)cancelButtonPressed {
    //    NSLog(@"111===首次输入= %d  输入个数=%d  %@   %@", _isFirstInput,_pressCount,_firstInputPSW,_inputPSW);
    if (_pressCount>0) {
        _pressCount --;
        UIView *pointView = (UIView *)[self viewWithTag:(_pressCount+kPointTag)];
        pointView.backgroundColor = CLEAR;
        NSString *string = [_inputPSW substringToIndex:_pressCount];
        _inputPSW = [NSString stringWithFormat:@"%@",string];
        NSLog(@"111=== 输入个数=%d   %@",_pressCount,_inputPSW);
    }
}
//密码错误
- (void)wrongPSW{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //重置小圆点
    for (int i = 0; i < 4; i ++) {
        UIView *pointView = (UIView *)[self viewWithTag:(i+kPointTag)];
        pointView.backgroundColor = CLEAR;
    }
    //抖动
    [self shakeAnimationForView:_inputLabel];
}
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    //小圆点
    _pressCount ++;
    for (int i = 0; i < _pressCount; i ++) {
        UIView *pointView = (UIView *)[self viewWithTag:(i+kPointTag)];
        pointView.backgroundColor = WHITE;
    }
    //输入密码盘操作
    int inputNum = (int)(button.tag - kButtonTag);
    if (_inputPSW == nil) {
        //输入初始化
        _inputPSW = [NSString stringWithFormat:@"%d",inputNum];
    }else if(_inputPSW.length < 3){
        //输入途中
        _inputPSW = [_inputPSW stringByAppendingString:[NSString stringWithFormat:@"%d",inputNum]];
    }else if(_inputPSW.length == 3){
        //输入终结
        _inputPSW = [_inputPSW stringByAppendingString:[NSString stringWithFormat:@"%d",inputNum]];
        //检测密码是否正确
        if ([[_inputPSW MD5Digest] isEqualToString:_lockInfo.numPSW]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self correctPSW];
            });
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self wrongPSW];
            });
        }
        //重置输入的密码
        _inputPSW = nil;
        //重置点击次数
        _pressCount = 0;
    }
}
#pragma mark - Data request
#pragma mark - Protocol methods
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
