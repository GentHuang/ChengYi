//
//  TTCSellCountViewCellGoalView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellCountViewCellGoalView.h"
#import "SDPieLoopProgressView.h"
@interface TTCSellCountViewCellGoalView()<UITextFieldDelegate>
@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) SDPieLoopProgressView *goalView;
@property (strong, nonatomic) UITapGestureRecognizer *goalTap;
@property (strong, nonatomic) UITapGestureRecognizer *packUpTap;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIView *goalBackView;
@property (strong, nonatomic) UITextField *goalTextField;
@property (strong, nonatomic) UIButton *goalSetButton;
@end
@implementation TTCSellCountViewCellGoalView
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
    _isSelected = NO;
    //全局手势
    _packUpTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    [self addGestureRecognizer:_packUpTap];
    //goalView
    _goalView = [[SDPieLoopProgressView alloc] init];
    _goalView.userInteractionEnabled = YES;
    _goalView.progress = 0;
    [self addSubview:_goalView];
    //点击展开本月目标
    _goalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    [_goalView addGestureRecognizer:_goalTap];
    //外圆
    _lineView = [[UIView alloc] init];
    _lineView.userInteractionEnabled = NO;
    _lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _lineView.layer.borderWidth = 0.5;
    _lineView.layer.cornerRadius = 110;
    _lineView.layer.masksToBounds = YES;
    [self addSubview:_lineView];
    //已完成
    UILabel *finishLabel = [[UILabel alloc] init];
    finishLabel.userInteractionEnabled = NO;
    finishLabel.text = @"已完成:";
    finishLabel.textColor = [UIColor colorWithRed:252/256.0 green:121/256.0 blue:37/256.0 alpha:1];
    finishLabel.textAlignment = NSTextAlignmentCenter;
    finishLabel.font = FONTSIZESBOLD(32/2);
    [_goalView addSubview:finishLabel];
    [finishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_goalView.mas_centerX);
        make.centerY.mas_equalTo(_goalView.mas_centerY).with.offset(-30);
        make.top.mas_equalTo(20);
    }];
    //设置本月目标背景
    _goalBackView = [[UIView alloc] init];
    _goalBackView.alpha = 0;
    _goalBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _goalBackView.layer.borderWidth = 0.5;
    _goalBackView.layer.masksToBounds = YES;
    _goalBackView.layer.cornerRadius = 4;
    [self addSubview:_goalBackView];
    //设置本月目标文本框
    _goalTextField = [[UITextField alloc] init];
    _goalTextField.font = FONTSIZESBOLD(15);
    _goalTextField.borderStyle = UITextBorderStyleNone;
    _goalTextField.placeholder = @"请输入本月目标";
    _goalTextField.text = @"";
    [_goalBackView addSubview:_goalTextField];
    //本月目标确定按钮
    _goalSetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goalSetButton setTitle:@"确  定" forState:UIControlStateNormal];
    [_goalSetButton setTitleColor:WHITE forState:UIControlStateNormal];
    [_goalSetButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_goalSetButton setBackgroundColor:DARKBLUE];
    _goalSetButton.titleLabel.font = FONTSIZESBOLD(15);
    _goalSetButton.layer.masksToBounds = YES;
    _goalSetButton.layer.cornerRadius = 4;
    [_goalBackView addSubview:_goalSetButton];
}
- (void)setSubViewLayout{
    //本月目标圆环
    [_goalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(200);
    }];
    //外圆
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_goalView);
        make.width.height.mas_equalTo(220);
    }];
    //设置本月目标背景
    [_goalBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_lineView.mas_right).with.offset(20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
    }];
    //设置本月目标文本框
    [_goalTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(150);
    }];
    //本月目标确定按钮
    [_goalSetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(70);
    }];
}
#pragma mark - Event response
//点击本月目标和收起键盘
- (void)tapPressed:(UITapGestureRecognizer *)tap{
    if (tap == _goalTap) {
        //收起键盘，显示和隐藏设置框
        if (_isSelected) {
            [UIView animateWithDuration:0.5 animations:^{
                _goalBackView.alpha = 0;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                _goalBackView.alpha = 1;
            }];
        }
        [_goalTextField resignFirstResponder];
        _isSelected = !_isSelected;
    }else if (tap == _packUpTap){
        //收起键盘，隐藏设置框
        [_goalTextField resignFirstResponder];
        _isSelected = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _goalBackView.alpha = 0;
        }];
    }
}
//点击确定按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _goalSetButton) {
        //点击确定
        //检测输入框是否为空
        if ([_goalTextField.text isEqualToString:@""]) {
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没设置目标哟" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else{
            //将本月目标存进数据库
            Goal *goal = [Goal sharedInstace];
            [goal loadName:[SellManInfo sharedInstace].name psw:[SellManInfo sharedInstace].password];
            goal.goal = _goalTextField.text;
            [[FMDBManager sharedInstace] creatTable:goal];
            [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:goal withCheckNum:2];
            //发出通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"设置本月目标" object:self];
            //收起键盘，隐藏设置框
            [_goalTextField resignFirstResponder];
            _isSelected = NO;
            [UIView animateWithDuration:0.5 animations:^{
                _goalBackView.alpha = 0;
            }];
        }
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载本月已完成百分比
- (void)loadFinishPercentWithPercent:(float)percent{
    _goalView.progress = percent;
    _goalTextField.text = @"";
}
@end
