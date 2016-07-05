//
//  TTCTabbarController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCTabbarController.h"
#import "TTCNavigationController.h"
#import "TTCUserLocateViewController.h"
//Macro
#define kTabbarButtonTag 2000
@interface TTCTabbarController ()
@property (assign, nonatomic) int lastIndex;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) NSString *locateType;
@property (strong, nonatomic) UIView *redPointView;
@end
@implementation TTCTabbarController
#pragma mark - Init methods
#pragma mark - Life circle
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self notificationRecieve];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Getters and setters
- (void)createUI{
    _lastIndex = 0;
    NSArray *imageNolArray = @[[UIImage imageNamed:@"tab_btn_first_nol"],[UIImage imageNamed:@"tab_btn_product_nol"],[UIImage imageNamed:@"tab_btn_car_nol"],[UIImage imageNamed:@"tab_btn_me_nol"]];
    NSArray *imageSelArray = @[[UIImage imageNamed:@"tab_btn_first_sel"],[UIImage imageNamed:@"tab_btn_product_sel"],[UIImage imageNamed:@"tab_btn_car_sel"],[UIImage imageNamed:@"tab_btn_me_sel"]];
    //隐藏系统TabBar
    self.tabBar.hidden = YES;
    self.selectedIndex = 0;
    //背景
    _backView = [[UIView alloc] init];
    _backView.layer.borderWidth = 0.5;
    _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _backView.backgroundColor = [UIColor colorWithRed:246/256.0 green:246/256.0 blue:246/256.0 alpha:1];
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(TAB_HEIGHT);
    }];
    //按钮
    for (int i = 0;  i < imageNolArray.count; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setTag:(i+kTabbarButtonTag)];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [allButton setImage:imageNolArray[i] forState:UIControlStateNormal];
        [allButton setImage:imageSelArray[i] forState:UIControlStateSelected];
        [allButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -5, 0)];
        if (i == 0) {
            allButton.selected = YES;
        }else{
            allButton.selected = NO;
        }
        [_backView addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i*(210/2)+170);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(210/2);
        }];
        if (i == 2) {
            //购物车提示红点
            _redPointView = [[UIView alloc] init];
            _redPointView.hidden = YES;
            _redPointView.backgroundColor = RED;
            _redPointView.layer.masksToBounds = YES;
            _redPointView.layer.cornerRadius = 2.5;
            [_backView addSubview:_redPointView];
            [_redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(allButton.mas_top).with.offset(10);
                make.left.mas_equalTo(allButton.mas_right).with.offset(-30);
                make.height.mas_equalTo(5);
                make.width.mas_equalTo(5);
            }];
        }
    }
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ((button.tag-kTabbarButtonTag)==1) {
        //        //若点击产品库，需要先判断是否已经定位客户
        //        //若客户未定位，提醒
        //        if ([[userDefault valueForKey:@"客户登录状态"] isEqualToString:@"NO"]) {
        //            [self userIsNotLocate];
        //            _locateType = @"isProductLib";
        //        }else{
        for (int i = 0; i < 4; i ++) {
            UIButton *allButton = (UIButton *)[self.view viewWithTag:(i+kTabbarButtonTag)];
            allButton.selected = NO;
        }
        button.selected = YES;
        self.selectedIndex = (int)(button.tag - kTabbarButtonTag);
        //        }
        //发送通知(默认读取频道信息)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCProductLibViewController" object:self userInfo:@{@"type":@"1.1"}];
    }else if((button.tag-kTabbarButtonTag)==2){
        //若点击购物车，需要先判断是否已经定位客户
        //若客户未定位，提醒
        if ([[userDefault valueForKey:@"客户登录状态"] isEqualToString:@"NO"]) {
            [self userIsNotLocate];
            _locateType = @"isShoppingCar";
        }else{
            for (int i = 0; i < 4; i ++) {
                UIButton *allButton = (UIButton *)[self.view viewWithTag:(i+kTabbarButtonTag)];
                allButton.selected = NO;
            }
            button.selected = YES;
            _redPointView.hidden = YES;
            self.selectedIndex = (int)(button.tag - kTabbarButtonTag);
        }
    }else if ((button.tag-kTabbarButtonTag)==0){
        //首页点击刷新
        //发送通知(默认读取频道信息)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"首页刷新" object:self userInfo:nil];
        for (int i = 0; i < 4; i ++) {
            UIButton *allButton = (UIButton *)[self.view viewWithTag:(i+kTabbarButtonTag)];
            allButton.selected = NO;
        }
        button.selected = YES;
        self.selectedIndex = (int)(button.tag - kTabbarButtonTag);
    }else{
        //其他栏目不需要进行客户定位的判断
        for (int i = 0; i < 4; i ++) {
            UIButton *allButton = (UIButton *)[self.view viewWithTag:(i+kTabbarButtonTag)];
            allButton.selected = NO;
        }
        button.selected = YES;
        self.selectedIndex = (int)(button.tag - kTabbarButtonTag);
    }
    //判断是否双击回rootVC
    if(_lastIndex == button.tag - kTabbarButtonTag){
        TTCNavigationController *nvc = (TTCNavigationController *)self.selectedViewController;
        [nvc popToRootViewControllerAnimated:YES];
    }else{
        _lastIndex = (int)(button.tag - kTabbarButtonTag);
    }
}
//接收通知
- (void)notificationRecieve{
    //购物车提示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"加入购物车" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    //购物车提示
    if ([notification.name isEqualToString:@"加入购物车"]) {
        _redPointView.hidden = NO;
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //客户定位
        TTCUserLocateViewController *userLocateVC = [[TTCUserLocateViewController alloc] init];
        userLocateVC.canGoBack = YES;
        if([_locateType isEqualToString:@"isProductLib"]){
            //产品库
            //            userLocateVC.isProductLib = YES;
        }else if([_locateType isEqualToString:@"isShoppingCar"]){
            //购物车
            userLocateVC.isShoppingCar = YES;
        }
        [self selectedControllerIndex:0];
        [self.viewControllers[0] pushViewController:userLocateVC animated:YES];
    }
}

#pragma mark - Other methods
//设置跳转页面
- (void)selectedControllerIndex:(int)selectedIndex{
    for (int i = 0; i < 4; i ++) {
        UIButton *allButton = (UIButton *)[self.view viewWithTag:(i+kTabbarButtonTag)];
        if (i == selectedIndex) {
            allButton.selected = YES;
        }else{
            allButton.selected = NO;
        }
    }
    self.selectedIndex = selectedIndex;
    TTCNavigationController *nvc = (TTCNavigationController *)self.selectedViewController;
    [nvc popToRootViewControllerAnimated:YES];
}
//页面初始化
- (void)pageInit{
    for (UINavigationController *subNVC in self.viewControllers) {
        [subNVC popToRootViewControllerAnimated:NO];
    }
}
//隐藏Bar
- (void)hideBar{
    _backView.hidden = YES;
}
//显示Bar
- (void)showBar{
    _backView.hidden = NO;
}
//客户未定位
- (void)userIsNotLocate{
    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先定位客户" delegate:self cancelButtonTitle:@"定位" otherButtonTitles:@"取消", nil];
    [alView show];
}
@end
