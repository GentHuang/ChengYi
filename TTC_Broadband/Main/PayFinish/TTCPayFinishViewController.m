//
//  TTCPayFinishViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPayFinishViewController.h"
#import "TTCNavigationController.h"
#import "TTCTabbarController.h"
//add
#import "TTCPrintViewController.h"
@interface TTCPayFinishViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *finishImageView;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *printButton;
@property (strong, nonatomic) NSTimer *timer;
//是否返回跟视图
@property (assign, nonatomic) BOOL iSbackRootView;
@property (strong, nonatomic)  UIAlertView *alertView;
@end

@implementation TTCPayFinishViewController
#pragma mark - Init methods
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self setSubViewLayout];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    if (_iSbackRootView) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
    [_backButton removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    //backView
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = WHITE;
    [self.view addSubview:_backView];
    //支付成功
    _finishImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pay_img_finish"]];
    [_backView addSubview:_finishImageView];
    //支付金额
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = _price;
    _priceLabel.font = FONTSIZESBOLD(60/2);
    _priceLabel.textColor = ORANGE;
    [_backView addSubview:_priceLabel];
    //5秒后弹出提示框
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(buttonPressed:) userInfo:nil repeats:NO];
    
}
- (void)setSubViewLayout{
    //backView
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL);
        make.left.right.mas_equalTo(0);
    }];
    //支付金额
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(490);
        make.left.mas_equalTo(405);
    }];
    //支付成功
    [_finishImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_backView);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"支付成功"];
    //返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.backgroundColor = CLEAR;
    [_backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(-4, -40, 0, 0)];
    [_backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [nvc.view addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(NAV_HEIGHT_PRODEL-STA_HEIGHT);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    TTCTabbarController *tabVC = (TTCTabbarController *)self.tabBarController;
    if (tabVC.selectedIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
//        CustomerInfo *customerInfo = [CustomerInfo shareInstance];
        _iSbackRootView = YES;
        //打印发票
//        if (customerInfo.allPrintInfoArray.count > 0) {
            TTCPrintViewController *printVC = [[TTCPrintViewController alloc] init];
            TTCNavigationController *nav =(TTCNavigationController*)self.navigationController;
            [nav pushViewController:printVC animated:YES];
//        }else{
//            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前客户没有需要打印的发票哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alView show];
//            //没有发票则直接返回跟视图
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
    }
}
//跳转打印界面
//- (void)showGoPrintView{
//    _iSbackRootView = YES;
//    //弹窗
//    _alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否跳转到打印列表页面" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"跳转", nil];
//    [self.view addSubview:_alertView];
//    [_alertView show];
//
//    _timer= [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(buttonPressed:) userInfo:nil repeats:NO];
//
//}
//跳转打印界面
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex==1) {
//        //销毁时间
//        [_timer invalidate];
//        //获取单例信息
//        CustomerInfo *customerInfo = [CustomerInfo shareInstance];
//        //打印发票
//        if (customerInfo.allPrintInfoArray.count > 0) {
//            TTCPrintViewController *printVC = [[TTCPrintViewController alloc] init];
//            TTCNavigationController *nav =(TTCNavigationController*)self.navigationController;
//            
//            [nav pushViewController:printVC animated:YES];
//        }else{
//            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前客户没有需要打印的发票哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alView show];
//        }
//    }
//}

#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
@end
