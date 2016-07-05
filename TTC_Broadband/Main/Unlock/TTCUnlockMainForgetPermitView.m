//
//  TTCUnlockMainForgetPermitView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUnlockMainForgetPermitView.h"
@interface TTCUnlockMainForgetPermitView()<UITextFieldDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *logInformationImageView;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *pswTextField;
@property (strong, nonatomic) UIButton *logButton;
@property (strong, nonatomic) UIButton *backButton;
@end
@implementation TTCUnlockMainForgetPermitView
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
    _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unlock_img_bg"]];
    [self addSubview:_backImageView];
    //输入框背景
    _logInformationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_img_textField"]];
    _logInformationImageView.userInteractionEnabled = YES;
    [self addSubview:_logInformationImageView];
    //输入用户名框
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.backgroundColor = CLEAR;
    _nameTextField.delegate = self;
    _nameTextField.textColor = WHITE;
    _nameTextField.font = FONTSIZES(54/2);
    [_logInformationImageView addSubview:_nameTextField];
    //输入密码框
    _pswTextField = [[UITextField alloc] init];
    _pswTextField.delegate = self;
    _pswTextField.backgroundColor =CLEAR;
    _pswTextField.textColor = WHITE;
    _pswTextField.font = FONTSIZES(54/2);
    _pswTextField.secureTextEntry = YES;
    [_logInformationImageView addSubview:_pswTextField];
    //登录按钮
    _logButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logButton.layer.masksToBounds = YES;
    _logButton.layer.cornerRadius = 7;
    _logButton.backgroundColor = WHITE;
    [_logButton setTitle:@"验证账号密码" forState:UIControlStateNormal];
    [_logButton setTitleColor:BLUE forState:UIControlStateNormal];
    _logButton.titleLabel.font = FONTSIZESBOLD(51/2);
    [_logButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_logButton];
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
    //输入框背景
    [_logInformationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(806/2);
        make.width.mas_equalTo(742/2);
        make.height.mas_equalTo(306/2);
    }];
    //输入用户名框
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2);
        make.left.mas_equalTo((44+130)/2);
        make.right.mas_equalTo(-2);
        make.height.mas_equalTo(150/2);
    }];
    //输入密码框
    [_pswTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameTextField.mas_bottom).with.offset(2);
        make.left.mas_equalTo(_nameTextField.mas_left);
        make.right.mas_equalTo(_nameTextField.mas_right);
        make.height.mas_equalTo(_nameTextField.mas_height);
    }];
    //登录按钮
    [_logButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_logInformationImageView.mas_bottom).with.offset(54/2);
        make.centerX.mas_equalTo(_logInformationImageView.mas_centerX);
        make.height.mas_equalTo(110/2);
        make.right.left.equalTo(_logInformationImageView);
    }];
    //后退按钮
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.height.mas_equalTo(100);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    //验证账号和密码是否正确
    LockInfo *info = [LockInfo sharedInstace];
    //收起键盘
    [self packUpKeyBoard];
    //输入框判断
    if ([_nameTextField.text isEqualToString:@""]) {
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入账号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alView show];
    }else if([_pswTextField.text isEqualToString:@""]){
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alView show];
    }else{
        if ([_nameTextField.text isEqualToString:info.name] && [[_pswTextField.text MD5Digest] isEqualToString:info.psw]) {
            //验证成功
            self.stringBlock(@"验证成功");
            _nameTextField.text = @"";
            _pswTextField.text = @"";
        }else{
            //验证失败
            self.stringBlock(@"验证失败");
        }
    }
}
//后退
- (void)backButtonPressed:(UIButton *)button{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
    [self packUpKeyBoard];
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//收起键盘
- (void)packUpKeyBoard{
    [_nameTextField resignFirstResponder];
    [_pswTextField resignFirstResponder];
}
@end
