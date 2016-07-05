//
//  TTCRechargeViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCRechargeViewController.h"
#import "TTCNavigationController.h"
#import "TTCPayFinishViewController.h"
//View
#import "TTCRechargeViewControllerCell.h"
//ViewModel
#import "TTCRechargeViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
@interface TTCRechargeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSString *fees;
@property (strong, nonatomic) NSString *payString;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *payWayString;
@property (strong, nonatomic) TTCRechargeViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) SellManInfo *sellManInfo;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@property (strong, nonatomic) MBProgressHUD *progressHud;
@property (strong, nonatomic) UIAlertView *sureAlView;
@end
@implementation TTCRechargeViewController
#pragma mark - Init methods
- (void)initData{
    _sellManInfo = [SellManInfo sharedInstace];
    _customerInfo = [CustomerInfo shareInstance];
    //vcViewModel
    _vcViewModel = [[TTCRechargeViewControllerViewModel alloc] init];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
    [self notificationRecieve];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    [_tableView.mj_header beginRefreshing];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    _payString = @"现金支付";
    _payWayString = @"C";
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCRechargeViewControllerCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //加载等待
    _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHud.hidden = YES;
    [_progressHud show:NO];
    [self.view addSubview:_progressHud];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
    //加载等待
    [_progressHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc canGoBack:YES];
    [nvc loadHeaderTitle:@"支付"];
}
#pragma mark - Event response
//接收通知
- (void)notificationRecieve{
    //监察充值金额
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"输入充值金额" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"输入充值金额"]) {
        _fees = [notification.userInfo valueForKey:@"rechargePrice"];
//        NSScanner* scan = [NSScanner scannerWithString:_fees];
//        int val;
//        if(!([scan scanInt:&val] && [scan isAtEnd])){
//            //判断是否数字
//            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确金额" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alView show];
//        }else{
//            //判断是否大于0
//            int orderCount = [_fees intValue];
//            if (orderCount < 0) {
//                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"充值金额必须大于0哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alView show];
//            }
//        }
    }
}
//点击按钮,确定支付
- (void)buttonPressed{
    TTCRechargeViewControllerCell *rechargeCell = (TTCRechargeViewControllerCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [rechargeCell hideKeyBoard];
    NSScanner* scan = [NSScanner scannerWithString:_fees];
    int val;
    if(!([scan scanInt:&val] && [scan isAtEnd])){
        //判断是否数字
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确金额" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }else{
        //判断是否大于0
        int orderCount = [_fees intValue];
        if (orderCount < 0) {
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"充值金额必须大于0哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }else{
            if (_fees.length > 0) {
                _sureAlView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否支付订单" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
                [_sureAlView show];
            }else{
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入充值金额" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alView show];
            }
        }
    }
}
//改变支付方式
- (void)changePayWay:(NSString *)payWay{
    _payWayString = payWay;
    if ([_payWayString isEqualToString:@"C"]) {
        _payString = @"现金支付";
    }else if ([_payWayString isEqualToString:@"C"]) {
        _payString = @"刷卡支付";
    }else if ([_payWayString isEqualToString:@"99"]) {
        _payString = @"微信支付";
    }
    [_tableView reloadData];
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCRechargeViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.stringBlock = ^(NSString *payWayString){
        [self changePayWay:payWayString];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadRechargeNameWithName:_rechargeName];
    if (indexPath.section == 0) {
        //客户信息
        [cell selectCellType:kInformationType];
        [cell loadUserName:_customerInfo.custname sellManName:_sellManInfo.name sellManDepName:_sellManInfo.depName];
    }else{
        //支付方式
        [cell selectCellType:kChoseType];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 90;
            break;
        case 1:
            return 496/2;
            break;
        default:
            return 0;
            break;
    }
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *footBackView = [[UIView alloc] init];
        //确定支付
        UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        payButton.layer.masksToBounds = YES;
        payButton.layer.cornerRadius = 3;
        payButton.backgroundColor = DARKBLUE;
        [payButton setTitle:_payString forState:UIControlStateNormal];
        [payButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        payButton.titleLabel.font = FONTSIZESBOLD(51/2);
        [footBackView addSubview:payButton];
        [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(136/2);
            make.centerX.mas_equalTo(footBackView.mas_centerX);
            make.width.mas_equalTo(628/2);
            make.height.mas_equalTo(110/2);
        }];
        return footBackView;
    }else{
        return [UIView new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 500/2;
    }else{
        return 30/2;
    }
}
// UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == _sureAlView) {
        if (buttonIndex == 0) {
            [self startLoading];
            __block TTCRechargeViewController *selfVC = self;
            [self startLoading];
            TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel = [[CustomerInfo shareInstance].allServsArray firstObject];
            [_vcViewModel rechargeWithKeyno:servsModel.keyno Fees:_fees fbid:_fbid payway:_payWayString bankaccno:@"" payreqid:@"" success:^(NSMutableArray *resultArray) {
                //支付成功
                [selfVC stopLoading];
                TTCPayFinishViewController *finishVC = [[TTCPayFinishViewController alloc] init];
                finishVC.price = [NSString stringWithFormat:@"%.02f",[_fees floatValue]];
                [self.navigationController pushViewController:finishVC animated:YES];
            } fail:^(NSError *error) {
                //支付失败
                [selfVC stopLoading];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alView show];
            }];
        }
    }
}
#pragma mark - Other methods
//加载等待
- (void)startLoading{
    _progressHud.hidden = NO;
    [_progressHud show:YES];
}
//停止加载
- (void)stopLoading{
    _progressHud.hidden = YES;
    [_progressHud show:NO];
}
@end
