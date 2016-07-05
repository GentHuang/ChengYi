//
//  TTCLockViewSetNumView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCLockViewSetNumView.h"
//Tool
#import "AudioToolbox/AudioToolbox.h"
//Macro
#define kButtonTag 55000
#define kPointTag 56000
@interface TTCLockViewSetNumView()<UIAlertViewDelegate>
@property (assign, nonatomic) int pressCount;
@property (assign, nonatomic) BOOL isFirstInput;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIImageView *backGroundImageView;
@property (strong, nonatomic) UILabel *inputLabel;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSString *inputPSW;
@property (strong, nonatomic) NSString *firstInputPSW;
@property (strong, nonatomic) UIButton *resetButton;
@property (strong, nonatomic) UIButton *backButton;
//取消按钮
@property (strong, nonatomic) UIButton *cancelButton;
//是否是修改密码
@property (assign, nonatomic) BOOL  isChangePassWord;
//用户信息
@property (strong, nonatomic) LockInfo *lockInfo;
@end
@implementation TTCLockViewSetNumView
#pragma mark - Init methods
- (void)initData{
    //首次输入密码
    _firstInputPSW = [[NSString alloc] init];
    //输入的密码
    _inputPSW = [[NSString alloc] init];
    //点击的次数
    _pressCount = 0;
    //是否修改密码
    _isChangePassWord = NO;
    //用户信息
    _lockInfo = [LockInfo sharedInstace];
}
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
    
    //用户信息
    _lockInfo = [LockInfo sharedInstace];
    //是否修改密码
    _isChangePassWord = YES;
    
    _isFirstInput = YES;
    //背景
    _backGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unlock_img_bg"]];
    [self addSubview:_backGroundImageView];
    //头像
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_avatar"]];
    [self addSubview:_avatarImageView];
    //请输入密码
    _inputLabel = [[UILabel alloc] init];
    _inputLabel.textColor = WHITE;
   
    if ([_lockInfo.isChangePSW isEqualToString:@"YES"]) {
        _inputLabel.text = @"请先输入旧密码";
    }else {
         _inputLabel.text = @"请先设置密码";
    }
    
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
            make.left.mas_equalTo(628/2+i*(82/2));
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
    //重置
    _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetButton.backgroundColor = CLEAR;
    [_resetButton addTarget:self action:@selector(resetButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_resetButton setTitle:@"重置密码" forState:UIControlStateNormal];
    [_resetButton setTitleColor:WHITE forState:UIControlStateNormal];
    _resetButton.titleLabel.font = FONTSIZESBOLD(40/2);
    //    _resetButton.layer.borderColor = [UIColor colorWithRed:179/256.0 green:194/256.0 blue:205/256.0 alpha:1].CGColor;
    //    _resetButton.layer.borderWidth = 2;
    //    _resetButton.layer.masksToBounds = YES;
    //    _resetButton.layer.cornerRadius = 2;
    [self addSubview:_resetButton];
    //后退按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.backgroundColor = CLEAR;
    [_backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(-40, -40, 0, 0)];
    [_backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    
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
    //重置
    [_resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left).offset(200);
        make.bottom.mas_equalTo(-150);
        make.width.mas_equalTo(300/2);//462/2
        make.height.mas_equalTo(125/2);
    }];
    //后退按钮
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.height.mas_equalTo(100);
    }];
    
    //数字输入取消按钮
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_resetButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-230);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
    }];
}
#pragma mark - Event response
//第一次密码输入
- (void)firstTimeToInputPSW{
        //重置小圆点
    for (int i = 0; i < 4; i ++) {
        UIView *pointView = (UIView *)[self viewWithTag:(i+kPointTag)];
        pointView.backgroundColor = CLEAR;
    }
    //重置输入次数
    _pressCount = 0;
    //进行第二次输入
    _isFirstInput = NO;
    //
    _inputLabel.text = @"请确认密码";
}
//重置所有
- (void)resetButtonPressed{
    //重置小圆点
    for (int i = 0; i < 4; i ++) {
        UIView *pointView = (UIView *)[self viewWithTag:(i+kPointTag)];
        pointView.backgroundColor = CLEAR;
    }
    //重置输入次数
    _pressCount = 0;
    //进行第一次输入
    _isFirstInput = YES;
    //
    _firstInputPSW = nil;
    //
    _inputPSW = nil;
//    _inputLabel.text = @"请先设置密码";
    if (_isChangePassWord) {
        _inputLabel.text = @"请输入旧密码";
    }
}
//取消按钮
- (void)cancelButtonPressed {
    if (_pressCount>0) {
        
        if ([_lockInfo.isChangePSW isEqualToString:@"YES"]&&_isChangePassWord) {
            _pressCount --;
            UIView *pointView = (UIView *)[self viewWithTag:(_pressCount+kPointTag)];
            pointView.backgroundColor = CLEAR;
            NSString *string = [_inputPSW substringToIndex:_pressCount];
            _inputPSW = [NSString stringWithFormat:@"%@",string];
            
        }else{
            if (_isFirstInput) {
                _pressCount --;
                UIView *pointView = (UIView *)[self viewWithTag:(_pressCount+kPointTag)];
                pointView.backgroundColor = CLEAR;
                NSString *string = [_firstInputPSW substringToIndex:_pressCount];
                _firstInputPSW = [NSString stringWithFormat:@"%@",string];
            }else {
                _pressCount --;
                UIView *pointView = (UIView *)[self viewWithTag:(_pressCount+kPointTag)];
                pointView.backgroundColor = CLEAR;
                NSString *string = [_inputPSW substringToIndex:_pressCount];
                _inputPSW = [NSString stringWithFormat:@"%@",string];
            }
        }
    }
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
    //修改密码
    if ([_lockInfo.isChangePSW isEqualToString:@"YES"]&&_isChangePassWord) {
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
        
     //首次输入密码
    } else {
    
    if (_isFirstInput) {
        //第一次输入
        if (_firstInputPSW == nil) {
            _firstInputPSW = [NSString stringWithFormat:@"%d",inputNum];
        }else if(_firstInputPSW.length < 3){
            //输入途中
            _firstInputPSW = [_firstInputPSW stringByAppendingString:[NSString stringWithFormat:@"%d",inputNum]];
        }else if(_firstInputPSW.length == 3){
            //输入终结
            _firstInputPSW = [_firstInputPSW stringByAppendingString:[NSString stringWithFormat:@"%d",inputNum]];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请再次输入密码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
            [self performSelector:@selector(firstTimeToInputPSW) withObject:self afterDelay:0.25];
        }
    }else{
        //第二次输入
        if (_inputPSW == nil) {
            _inputPSW = [NSString stringWithFormat:@"%d",inputNum];
        }else if(_inputPSW.length < 3){
            //输入途中
            _inputPSW = [_inputPSW stringByAppendingString:[NSString stringWithFormat:@"%d",inputNum]];
        }else if(_inputPSW.length == 3){
            //输入终结
            _inputPSW = [_inputPSW stringByAppendingString:[NSString stringWithFormat:@"%d",inputNum]];
            if ([_inputPSW isEqualToString:_firstInputPSW]) {
                //若两次输入密码相同，则设置成功
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功设置密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alView show];
            }else{
                //输入密码不同
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入密码不一致，请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alView show];
                [self performSelector:@selector(resetButtonPressed) withObject:self afterDelay:0.25];
            }
        }
    }
        
    }
}
//-------------------------
- (void)correctPSW{
    //重置小圆点
    for (int i = 0; i < 4; i ++) {
        UIView *pointView = (UIView *)[self viewWithTag:(i+kPointTag)];
        pointView.backgroundColor = CLEAR;
    }
    //密码修改
    _inputLabel.text = @"请确认密码";
    //重新置空
    _inputPSW = nil;
    _isChangePassWord=NO;
    
}
//密码错误
- (void)wrongPSW{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //重置小圆点
    for (int i = 0; i < 4; i ++) {
        UIView *pointView = (UIView *)[self viewWithTag:(i+kPointTag)];
        pointView.backgroundColor = CLEAR;
    }
    //重新置空
    _inputPSW = nil;
    //抖动
    [self shakeAnimationForView:_inputLabel];
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
    _inputLabel.text = @"请先输入旧密码";
}

#pragma mark - Data request
#pragma mark - Protocol methods
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //密码设置成功
        self.stringBlock(_inputPSW);
        _isChangePassWord = YES;
        [self performSelector:@selector(resetButtonPressed) withObject:self afterDelay:0.25];
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
