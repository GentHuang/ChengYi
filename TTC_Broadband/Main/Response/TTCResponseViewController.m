//
//  TTCResponseViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCResponseViewController.h"
#import "TTCNavigationController.h"
//ViewModel
#import "TTCResponseViewControllerViewModel.h"
@interface TTCResponseViewController ()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) TTCResponseViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) MBProgressHUD *progressHud;
@end
@implementation TTCResponseViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCResponseViewControllerViewModel alloc] init];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    //背景
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = WHITE;
    [self.view addSubview:_backView];
    //反馈标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"有什么问题，可以反馈：";
    _titleLabel.font = FONTSIZESBOLD(30/2);
    _titleLabel.textColor = LIGHTDARK;
    [_backView addSubview:_titleLabel];
    //textView
    _textView = [[UITextView alloc] init];
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.font = FONTSIZESBOLD(30/2);
    _textView.textColor = [UIColor lightGrayColor];
    [_backView addSubview:_textView];
    //发送
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.backgroundColor = DARKBLUE;
    _sendButton.layer.masksToBounds = YES;
    _sendButton.layer.cornerRadius = 4;
    [_sendButton setTitle:@"发 送" forState:UIControlStateNormal];
    [_sendButton setTitleColor:WHITE forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _sendButton.titleLabel.font = FONTSIZESBOLD(51/2);
    [_backView addSubview:_sendButton];
    //等待
    _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    [_progressHud show:NO];
//    [self.view addSubview:_progressHud];
}
- (void)setSubViewLayout{
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1122/2);
    }];
    //反馈标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50/2);
        make.left.mas_equalTo(60/2);
    }];
    //textView
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(110/2);
        make.left.mas_equalTo(60/2);
        make.right.mas_equalTo(-60/2);
        make.height.mas_equalTo(718/2);
    }];
    //发送
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backView.mas_centerX);
        make.top.mas_equalTo(_textView.mas_bottom).with.offset(90/2);
        make.width.mas_equalTo(630/2);
        make.height.mas_equalTo(120/2);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"反馈"];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed{
    __block TTCResponseViewController *selfVC = self;
    [_progressHud show:YES];
    //先检测反馈是否为空
    if ([_textView.text isEqualToString:@""]) {
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入反馈内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alView show];
    }else{
        [_vcViewModel sendResponseWithContent:_textView.text success:^(NSMutableArray *resultArray) {
            //反馈成功
            [selfVC.progressHud show:NO];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"反馈发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(NSError *error) {
            //反馈失败
            [selfVC.progressHud show:NO];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"反馈发送失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }];
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
@end
