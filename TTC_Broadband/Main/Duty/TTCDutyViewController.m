//
//  TTCDutyViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCDutyViewController.h"
#import "TTCNavigationController.h"
#import "AppDelegate.h"
//Macro
#define kButtonTag 16000
@interface TTCDutyViewController ()
@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UIView *backView;
//临时
@property (strong, nonatomic) NSArray *dutyArray;
@end
@implementation TTCDutyViewController
#pragma mark - Init methods
- (void)initData{
    _dutyArray = @[@"销售部",@"客服部",@"管理部",@"高清电视业务部",@"销售部",@"客服部",@"管理部",@"高清电视业务部"];
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
    //创建按钮列表
    UIView *lastView;
    for (int i = 0; i < _dutyArray.count; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i + kButtonTag;
        [allButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.layer.masksToBounds = YES;
        allButton.layer.cornerRadius = 4;
        allButton.layer.borderWidth = 0.5;
        allButton.layer.borderColor = [UIColor colorWithRed:232/256.0 green:232/256.0 blue:232/256.0 alpha:1].CGColor;
        if (i == 0) {
            allButton.selected = YES;
            allButton.backgroundColor = DARKBLUE;
            allButton.layer.borderWidth = 0;
        }else{
            allButton.selected = NO;
            allButton.backgroundColor = WHITE;
            allButton.layer.borderWidth = 0.5;
        }
        [allButton setTitle:_dutyArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor colorWithRed:188/256.0 green:188/256.0 blue:188/256.0 alpha:1] forState:UIControlStateNormal];
        [allButton setTitleColor:WHITE forState:UIControlStateSelected];
        allButton.titleLabel.font = FONTSIZESBOLD(26/2);
        [_backView addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(85/2+(i/5)*(116/2));
            make.left.mas_equalTo(60/2+(i%5)*(304/2));
            make.width.mas_equalTo(222/2);
            make.height.mas_equalTo(70/2);
        }];
        lastView = allButton;
    }
    //开始按钮
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _startButton.backgroundColor = DARKBLUE;
    _startButton.layer.masksToBounds = YES;
    _startButton.layer.cornerRadius = 4;
    [_startButton setTitle:@"选好了，马上开始掌上营销" forState:UIControlStateNormal];
    [_startButton setTitleColor:WHITE forState:UIControlStateNormal];
    _startButton.titleLabel.font = FONTSIZESBOLD(51/2);
    [_backView addSubview:_startButton];
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backView.mas_centerX);
        make.top.mas_equalTo(lastView.mas_bottom).with.offset(168/2);
        make.width.mas_equalTo(787/2);
        make.height.mas_equalTo(116/2);
    }];
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_startButton.mas_bottom).with.offset(200/2);
    }];
}
- (void)setSubViewLayout{
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL);
        make.left.right.mas_equalTo(0);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"请选择所属部门"];
}
#pragma mark - Event response
//带Tag按钮点击
- (void)tagButtonPressed:(UIButton *)button{
    for (int i = 0; i < _dutyArray.count; i ++) {
        UIButton *allButton = (UIButton *)[self.view viewWithTag:(i+kButtonTag)];
        allButton.selected = NO;
        allButton.backgroundColor = WHITE;
        allButton.layer.borderWidth = 0.5;
    }
    button.selected = YES;
    button.backgroundColor = DARKBLUE;
    button.layer.borderWidth = 0;
}
//点击开始按钮
- (void)buttonPressed{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate.window.rootViewController == appDelegate.tabbarVC) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self presentViewController:appDelegate.tabbarVC animated:YES completion:nil];
    }
    [self performSelector:@selector(backToRootPage) withObject:self afterDelay:1];
    //发送登录成功通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"营销人员登录成功" object:self userInfo:nil];
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//返回初始页
- (void)backToRootPage{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
@end
