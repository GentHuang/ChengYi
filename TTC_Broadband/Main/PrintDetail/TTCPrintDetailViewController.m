//
//  TTCPrintDetailViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPrintDetailViewController.h"
#import "TTCNavigationController.h"
//add
#import "TTCTabbarController.h"

//View
#import "TTCPrintDetailViewCell.h"
#import "TTCPrintDetailViewDragView.h"
//ViewModel
#import "TTCPrintDetailViewControllerViewModel.h"
//add
#import "TTCPrintDetailViewConfirmButtonView.h"

@interface TTCPrintDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
@property (assign, nonatomic) BOOL isDrag;
@property (strong, nonatomic) NSString *payWayString;
@property (strong, nonatomic) NSString *payString;
@property (strong, nonatomic) NSString *invnoString;
@property (strong, nonatomic) NSString *booknoString;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TTCPrintDetailViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCPrintDetailViewDragView *dragView;
//确认打印发票 view
@property (strong, nonatomic) TTCPrintDetailViewConfirmButtonView *confirmButtonView;
@end

@implementation TTCPrintDetailViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCPrintDetailViewControllerViewModel alloc] init];
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
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_vcViewModel closePrinter];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self ClreanData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    _payString = @"现金支付";
    _payWayString = @"0";
    _isDrag = NO;
    //是否返回根视图
    __block TTCPrintDetailViewController *selfVC = self;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCPrintDetailViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfVC getHeaderData];
    }];
    [_tableView.mj_header beginRefreshing];
    //下拉列表         
    _dragView = [[TTCPrintDetailViewDragView alloc] init];
    _dragView.stringBlock = ^(NSString *buttonString){
        [selfVC choseBooknoWithBookno:buttonString];
    };
    [self.view addSubview:_dragView];
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packUpList)];
    tap.delegate = self;
    [_tableView addGestureRecognizer:tap];
    //add
    //确认打印按钮
    _confirmButtonView = [[TTCPrintDetailViewConfirmButtonView alloc]init];
    [self.view addSubview:_confirmButtonView];
    _confirmButtonView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _confirmButtonView.layer.borderWidth = 0.5;
    _confirmButtonView.backgroundColor = WHITE;
    _confirmButtonView.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
    //下拉列表
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(318/2);
        make.left.mas_equalTo(256/2);
        make.width.mas_equalTo(820/2);
    }];
    //add
    //确认打印
    [_confirmButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(112/2);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc loadHeaderTitle:@"打印发票"];
}
#pragma mark - Event response
//改变支付方式
- (void)changePayWay:(NSString *)payWay{
    //   0  是现金，2是刷卡支付  W是微信支付
    _payWayString = payWay;
    if ([_payWayString isEqualToString:@"0"]) {
        _payString = @"现金支付";
    }else if([_payWayString isEqualToString:@"2"]){
        _payString = @"刷卡支付";
    }else if([_payWayString isEqualToString:@"W"]){
        _payString = @"微信支付";
    }
    [_tableView reloadData];
}
//点击按钮
- (void)buttonPressed:(NSString *)buttonString{
    if ([buttonString isEqualToString:@"确认打印"]) {
        __block TTCPrintDetailViewControllerViewModel *selfViewModel = _vcViewModel;
        __block TTCPrintDetailViewController *selfVC = self;
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *invno = [userDefault valueForKey:@"发票编号"];
        if (invno.length > 0) {
            _invnoString = invno;
        }
        if (_invnoString == nil) {
            //若发票编号为空
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入发票编号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }else if(_booknoString==nil){
            //若发票本号为空
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择发票本号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
            
        }else{
            //若已经连接打印机
            if (selfViewModel.isConnect) {
                //本号请求成功
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [selfViewModel printInvoiceWithArray:selfVC.allPrintInfoArray invno:selfVC.invnoString bookno:_booknoString payway:_payWayString success:^(NSMutableArray *resultArray) {
                    //打印请求成功
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    //打印字符串(若已经连接打印机)
                    [selfViewModel printStringWithInfoArray:selfViewModel.dataInfoArray success:^(NSMutableArray *resultArray) {
                        //打印成功
                        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打印成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alView show];
                    } fail:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        //打印失败
                        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        //状态为“0”不提示
                        if (![selfViewModel.status isEqualToString:@"0"]) {
                            [alView show];
                        }
                    }];
                } fail:^(NSError *error) {
                    //打印请求失败
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alView show];
                }];
            }else{
                //若未连接打印机，则连接打印机
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [self getHeaderData];
            }
        }
    }else if([buttonString isEqualToString:@"刷新打印机"]){
        //链接打印机
        [_tableView.mj_header beginRefreshing];
    }
    [_dragView packUpList];
}
//点击Tap
- (void)tapPressed:(UITapGestureRecognizer *)tap{
    _isDrag = YES;
    [_dragView dragDownList];
}
//收起下拉菜单
- (void)packUpList{
    if (_isDrag) {
        _isDrag = !_isDrag;
        [_dragView packUpList];
    }
}
//选择本号
- (void)choseBooknoWithBookno:(NSString *)bookno{
    _booknoString = bookno;
    [_tableView reloadData];
}
//接收通知
- (void)notificationRecieve{
    //请求发票本号
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"请求发票本号" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"请求发票本号"]) {
        //请求发票本号
        __block TTCPrintDetailViewControllerViewModel *selfViewModel = _vcViewModel;
        __block TTCPrintDetailViewController *selfVC = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *invno = [userDefault valueForKey:@"发票编号"];
        if (invno.length > 0) {
            _invnoString = invno;
        }
        if (_invnoString.length > 0) {
            //存在发票号
            [_vcViewModel getbooknoByInvno:_invnoString success:^(NSMutableArray *resultArray) {
                //请求成功
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [selfVC.dragView loadBooknoListWithArray:selfViewModel.dataBooknoArray];
                [selfVC.tableView reloadData];
                [selfVC.tableView.mj_header endRefreshing];
            } fail:^(NSError *error) {
                //本号请求失败
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alView show];
                selfVC.booknoString = @"";
                [selfVC.tableView reloadData];
                [selfVC.tableView.mj_header endRefreshing];
            }];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            //若发票编号为空
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入发票编号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }
    }
}
#pragma mark - Network request
//连接打印机和请求发票编号
- (void)getHeaderData{
    __block TTCPrintDetailViewController *selfVC = self;
    __block TTCPrintDetailViewControllerViewModel *selfViewModel = _vcViewModel;
    //获取发票编号
    [_vcViewModel getopernextinvoWithDepID:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password operid:@"0" loginname:@"" name:@"" areaid:[CustomerInfo shareInstance].areaid city:[CustomerInfo shareInstance].city success:^(NSMutableArray *resultArray) {
        //获取成功
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        selfVC.invnoString = selfViewModel.invoString;
        if (selfVC.invnoString.length > 0) {
            //存在发票号
            //发出通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"请求发票本号" object:self];
        }
        //连接打印机
        [selfViewModel connectToPrinterSuccess:^(NSMutableArray *resultArray) {
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打印机连接成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            //连接测试打印机add
            if (selfViewModel.connectTestprintStaus ==YES) {
                alView.message =@"连接测试打印接口成功";
            }
            [alView show];
        } fail:^(NSError *error) {
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打印机连接失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - Protocol methods
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if(_isPopRootViewControl==YES){
            //当打印完所有订单后直接返回根视图
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCPrintDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __block TTCPrintDetailViewController *selfVC = self;
    cell.stringBlock = ^(NSString *string){
        [selfVC buttonPressed:string];
    };
    cell.changeBlock = ^(NSString *payWayString){
        [selfVC changePayWay:payWayString];
    };
    cell.tapBlock = ^(UITapGestureRecognizer *tap){
        [selfVC tapPressed:tap];
    };
    if (indexPath.section == 0) {
        [cell selectCellType:kFillInType];
        [cell loadPrice:[NSString stringWithFormat:@"%.02f",_allPrice]];
        [cell loadBooknoLabelWithBookno:_booknoString];
        [cell loadInvoNumWithInvoNum:_invnoString];
    }else{
        [cell selectCellType:kPrinterType];
        //暂时
        [cell loadPrinterWithNumber:1];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self packUpList];
    TTCPrintDetailViewCell *cell = (TTCPrintDetailViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell packUpKeyBoard];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 650/2;
    }else{
        return 450/2;
    }
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 25/2;
}
//UIGestureRecognizerDelegate Method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 输出点击的view的类名
    //        NSLog(@"%@", NSStringFromClass([touch.view class]));
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return YES;
    }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableView"]) {
        return YES;
    }
    return  NO;
}
//清除缓存数据
- (void)ClreanData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"" forKey:@"发票编号"];
    [userDefault synchronize];
}

#pragma mark - Other methods
@end
