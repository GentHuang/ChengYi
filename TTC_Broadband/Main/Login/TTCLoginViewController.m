//
//  TTCLoginViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCDepartmentViewController.h"
#import "TTCLoginViewController.h"
#import "TTCFirstPageViewController.h"
#import "TTCNavigationController.h"
//View
#import "TTCLoginMainView.h"
//ViewModel
#import "TTCLoginViewControllerViewModel.h"
@interface TTCLoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) TTCLoginMainView *mainView;
@property (strong, nonatomic) TTCLoginViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) MBProgressHUD *progressHud;
@property (strong, nonatomic) UIImageView *logInformationImageView;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *pswTextField;
@property (strong, nonatomic) UIButton *logButton;
@property (strong, nonatomic) UIButton *fogetPSWButton;
@property (strong, nonatomic) UIButton *descButton;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) UIScrollView *startView;
@end
@implementation TTCLoginViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCLoginViewControllerViewModel alloc] init];
    //缓存用户名
    _userDefault = [NSUserDefaults standardUserDefaults];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
    //判断是否第一次登陆
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (![[userDefault valueForKey:@"第一次使用APP"] isEqualToString:@"NO"]) {
        [self useStartPage];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    _mainView = [[TTCLoginMainView alloc] init];
    [self.view addSubview:_mainView];
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    [_mainView addGestureRecognizer:tap];
    //输入框背景
    _logInformationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_img_textField"]];
    _logInformationImageView.userInteractionEnabled = YES;
    [_mainView addSubview:_logInformationImageView];
    //输入用户名框
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.backgroundColor = CLEAR;
    _nameTextField.text = [_userDefault valueForKey:@"营销人员姓名"];
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
    [_logButton setTitle:@"登 录" forState:UIControlStateNormal];
    [_logButton setTitleColor:BLUE forState:UIControlStateNormal];
    _logButton.titleLabel.font = FONTSIZESBOLD(51/2);
    [_logButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_logButton];
    //忘记密码
    _fogetPSWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _fogetPSWButton.backgroundColor = CLEAR;
    [_fogetPSWButton setTitleColor:WHITE forState:UIControlStateNormal];
    [_fogetPSWButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_fogetPSWButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 140/2, 15, 0)];
    _fogetPSWButton.titleLabel.font = FONTSIZESBOLD(36/2);
    [_fogetPSWButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_fogetPSWButton];
    //登录说明
    _descButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _descButton.backgroundColor  = CLEAR;
    [_descButton setImage:[UIImage imageNamed:@"login_img_desc"] forState:UIControlStateNormal];
    [_descButton setTitle:@"登录说明" forState:UIControlStateNormal];
    [_descButton setTitleColor:WHITE forState:UIControlStateNormal];
    _descButton.titleLabel.font = FONTSIZESBOLD(36/2);
    [_descButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_descButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -155/2, 15, 0)];
    [_descButton setImageEdgeInsets:UIEdgeInsetsMake(0, -155/2, 15, 0)];
    [_mainView addSubview:_descButton];
    //加载进度
    _progressHud = [[MBProgressHUD alloc] initWithView:_mainView];
    _progressHud.hidden = YES;
    [_progressHud show:NO];
    [_mainView addSubview:_progressHud];
}
- (void)setSubViewLayout{
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //输入框背景
    [_logInformationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
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
    //忘记密码
    [_fogetPSWButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_logButton.mas_bottom).with.offset(97/2);
        make.left.mas_equalTo(_logButton.mas_left);
        make.height.mas_equalTo(36);
        make.right.mas_equalTo(_logButton.mas_centerX).with.offset(-48/2);
    }];
    //登录说明
    [_descButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(_fogetPSWButton);
        make.left.equalTo(_fogetPSWButton.mas_right).with.offset(68/2);
        make.right.equalTo(_logButton.mas_right);
    }];
    //加载进度
    [_progressHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kNoneType];
    [nvc loadHeaderTitle:@""];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _logButton) {
        //登录
        [self saleManLoginOperation];
        //        TTCDepartmentViewController *departmentVC = [[TTCDepartmentViewController alloc] init];
        //        departmentVC.depinfoIDArray = _vcViewModel.dataDepinfoIDArray;
        //        departmentVC.depinfoNameArray = _vcViewModel.dataDepinfoNameArray;
        //        [self.navigationController pushViewController:departmentVC animated:YES];
    }else if(button == _fogetPSWButton){
        //忘记密码
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"忘记密码请联系技术中心" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }else if(button == _descButton){
        //登录说明
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入您在大连天途的工号和和对应的密码进行登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }
}
//点击收起键盘
- (void)tapPressed{
    [self packUpKeyBoard];
}
//第一次登陆按钮
- (void)startButtonPressed{
    [UIView animateWithDuration:0.5 animations:^{
        _startView.frame = CGRectMake(0, SCREEN_MAX_Height, SCREEN_MAX_WIDTH, SCREEN_MAX_Height);
    } completion:^(BOOL finished) {
        [_startView removeFromSuperview];
    }];
    [UIView commitAnimations];
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UIScrollViewDelegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //滚动结束
    if (scrollView.contentOffset.x > 2400) {
        [UIView animateWithDuration:0.5 animations:^{
            scrollView.frame = CGRectMake(-SCREEN_MAX_WIDTH, 0, SCREEN_MAX_WIDTH, SCREEN_MAX_Height);
        } completion:^(BOOL finished) {
            [scrollView removeFromSuperview];
        }];
        [UIView commitAnimations];
    }
}
#pragma mark - Other methods
//销售人员登录操作
- (void)saleManLoginOperation{
    //收起键盘
    [self packUpKeyBoard];
    //输入框判断
    if ([_nameTextField.text isEqualToString:@""]) {
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alView show];
    }else if([_pswTextField.text isEqualToString:@""]){
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alView show];
    }else{
        //加载动画
        [self startProgress];
        //缓存用户名
        [_userDefault setObject:_nameTextField.text forKey:@"营销人员姓名"];
        [_userDefault synchronize];
        //输入的账号和密码
        NSString *sellManNameString = _nameTextField.text;
        NSString *sellManPSWString = [_pswTextField.text MD5Digest];
        //核对当前用户密码是否对应
        if ([[_userDefault valueForKey:@"营销人员登录状态"] isEqualToString:@"NO"]) {
            //退出登录后的状态
            //获取数据
            [_vcViewModel saleManLoginWithName:_nameTextField.text pwd:_pswTextField.text successs:^(NSMutableArray *resultArray) {
                //数据获取成功
                //密码输入框清空
                _pswTextField.text = @"";
                //停止动画
                [self stopProgress];
                TTCDepartmentViewController *departmentVC = [[TTCDepartmentViewController alloc] init];
                departmentVC.depinfoIDArray = _vcViewModel.dataDepinfoIDArray;
                departmentVC.depinfoNameArray = _vcViewModel.dataDepinfoNameArray;
                [self.navigationController pushViewController:departmentVC animated:YES];
            }fail:^(NSError *error) {
                //数据获取失败
                //密码输入框清空
                _pswTextField.text = @"";
                //停止动画
                [self stopProgress];
                //账号或者密码错误
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败,请确认账号密码或网络连接状况" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alView show];
            }];
        }else{
            if([sellManNameString isEqualToString:[SellManInfo sharedInstace].loginname] && [sellManPSWString isEqualToString:[SellManInfo sharedInstace].md5PSW]){
                //上一任登录人员登录
                //停止动画
                [self stopProgress];
                AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
                appDelegate.window.rootViewController = appDelegate.tabbarVC;
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
                //密码输入框清空
                _pswTextField.text = @"";
            }else{
                //新一任登录人员登录
                //获取数据
                [_vcViewModel saleManLoginWithName:_nameTextField.text pwd:_pswTextField.text successs:^(NSMutableArray *resultArray) {
                    //数据获取成功
                    //密码输入框清空
                    _pswTextField.text = @"";
                    //停止动画
                    [self stopProgress];
                    TTCDepartmentViewController *departmentVC = [[TTCDepartmentViewController alloc] init];
                    departmentVC.depinfoIDArray = _vcViewModel.dataDepinfoIDArray;
                    departmentVC.depinfoNameArray = _vcViewModel.dataDepinfoNameArray;
                    [self.navigationController pushViewController:departmentVC animated:YES];
                }fail:^(NSError *error) {
                    //数据获取失败
                    //密码输入框清空
                    _pswTextField.text = @"";
                    //停止动画
                    [self stopProgress];
                    //账号或者密码错误
                    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败,请确认账号密码或网络连接状况" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alView show];
                }];
            }
        }
    }
}
//开始加载动画
- (void)startProgress{
    _progressHud.hidden = NO;
    [_progressHud show:YES];
}
//停止加载动画
- (void)stopProgress{
    _progressHud.hidden = YES;
    [_progressHud show:NO];
}
//收起键盘
- (void)packUpKeyBoard{
    [_nameTextField resignFirstResponder];
    [_pswTextField resignFirstResponder];
}
//启动画面
- (void)useStartPage{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _startView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_MAX_WIDTH, SCREEN_MAX_Height)];
    _startView.delegate = self;
    _startView.showsHorizontalScrollIndicator = NO;
    _startView.pagingEnabled = YES;
    _startView.contentSize = CGSizeMake(SCREEN_MAX_WIDTH*4, SCREEN_MAX_Height);
    NSArray *imageArray = @[[UIImage imageNamed:@"start_img1"],[UIImage imageNamed:@"start_img2"],[UIImage imageNamed:@"start_img3"],[UIImage imageNamed:@"start_img4"]];
    for (int i = 0; i < imageArray.count; i ++) {
        UIImageView *allImageView = [[UIImageView alloc] initWithImage:imageArray[i]];
        allImageView.userInteractionEnabled = YES;
        allImageView.frame = CGRectMake(i*SCREEN_MAX_WIDTH, 0, SCREEN_MAX_WIDTH, SCREEN_MAX_Height);
        [_startView addSubview:allImageView];
        if (i == imageArray.count - 1) {
            UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
            startButton.center = CGPointMake(SCREEN_MAX_WIDTH/2, 870);
            startButton.bounds = CGRectMake(0, 0, 200, 50);
            startButton.backgroundColor = CLEAR;
            [startButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [allImageView addSubview:startButton];
        }
    }
    [self.view addSubview:_startView];
    [self.view bringSubviewToFront:_startView];
    [_userDefault setValue:@"NO" forKey:@"第一次使用APP"];
    [_userDefault synchronize];
}
@end
