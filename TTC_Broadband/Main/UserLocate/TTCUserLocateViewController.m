//
//  TTCUserLocateViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCUserLocateViewController.h"
#import "TTCNavigationController.h"
#import "TTCUserDetailViewController.h"
#import "TTCProductLibViewController.h"
#import "TTCOrderRecordViewController.h"
#import "TTCDebtViewController.h"
#import "TTCShoppingCarViewController.h"
#import "TTCPrintViewController.h"
#import "TTCScanViewController.h"
//View
#import "TTCUserLocateScrollView.h"
#import "TTCUserLocateDragView.h"
//ViewModel
#import "TTCUserLocateViewControllerViewModel.h"
@interface TTCUserLocateViewController ()<UIAlertViewDelegate>
@property (assign, nonatomic) int type;
@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) NSString *icno;
@property (strong, nonatomic) TTCUserLocateScrollView *scrollView;
@property (strong, nonatomic) TTCUserLocateViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCUserLocateDragView *dragView;
@property (strong, nonatomic) MBProgressHUD *progressHud;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) NSString *keyno;
@end
@implementation TTCUserLocateViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCUserLocateViewControllerViewModel alloc] init];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self addObserver];
    [self setSubViewLayout];
    [self notificationRecvie];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
//    //隐藏tab
//    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
//    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
//    [tab hideBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - Getters and setters
- (void)createUI{
    _type = 2;
    _isSelected = NO;
    self.view.backgroundColor = LIGHTGRAY;
//    //手势(收键盘)
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
//    [self.view addGestureRecognizer:tap];
    //scrollView
    _scrollView = [[TTCUserLocateScrollView alloc] init];
    _scrollView.backgroundColor = LIGHTGRAY;
    __block TTCUserLocateViewController *selfVC = self;
    _scrollView.stringBlock = ^(NSString *clientID){
        [selfVC buttonPressed:clientID];
    };
    _scrollView.tapBlock = ^(UIButton *button){
        [selfVC tapPressed:nil];
    };
    [self.view addSubview:_scrollView];
    NSArray *memoryArray = [_userDefault objectForKey:@"客户ID"];
    if (memoryArray.count > 0) {
        [_scrollView loadMemoryRecordWithArray:memoryArray];
    }
    //下拉列表
    _dragView = [[TTCUserLocateDragView alloc] init];
    _dragView.stringBlock = ^(NSString *type){
        [selfVC selectType:type];
    };
    [_scrollView addSubview:_dragView];
    //加载进度
    _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHud.hidden = YES;
    [_progressHud show:NO];
    [self.view addSubview:_progressHud];
}
- (void)setSubViewLayout{
    //scrollView
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_FIRST); //原来的高度NAV_HEIGHT_USERLOCATE

        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.mas_width);
        make.bottom.mas_equalTo(0);
    }];
    //下拉列表
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo(280/2);
        make.height.mas_equalTo(160);
        make.width.mas_equalTo(130);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nav = (TTCNavigationController *)self.navigationController;
    [nav selectNavigationType:kUserLocateType];
    if (_isUserDetail) {
        [nav loadHeaderTitle:@"客户定位"];
    }else if(_isProductOrder){
        [nav loadHeaderTitle:@"产品订购"];
    }else if (_isSetOrder){
        [nav loadHeaderTitle:@"套餐订购"];
    }else if(_isPayDebt){
        [nav loadHeaderTitle:@"缴费充值"];
    }else if (_isCheckOrder){
        [nav loadHeaderTitle:@"订单查询"];
    }else if (_isProductDetail){
        [nav loadHeaderTitle:@"产品详情"];
    }else if (_isShoppingCar){
        [nav loadHeaderTitle:@"购物车"];
    }else if (_isPrint){
        [nav loadHeaderTitle:@"打印发票"];
    }
    [nav canGoBack:_canGoBack];
}
#pragma mark - Event response
- (void)notificationRecvie{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificatRespose:) name:@"扫一扫" object:nil];
}
- (void)notificatRespose:(NSNotification*)notifcation{
    if([notifcation.name isEqualToString:@"扫一扫"]){
        //扫一扫
        TTCScanViewController *scanVC = [[TTCScanViewController alloc] init];
        scanVC.postName = @"客户定位";
        [self.navigationController pushViewController:scanVC animated:YES];
    }
}
//点击按钮
- (void)buttonPressed:(NSString *)buttonString{
    if ([buttonString isEqualToString:@"清空"]) {
        //点击清空按钮
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清空记录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alView show];
    }else if([buttonString isEqualToString:@"客户定位类型"]){
        //选择定位类型
        if (_isSelected) {
            //收起
            [_dragView hideDragView];
        }else{
            //展开
            [_dragView showDragView];
        }
        _isSelected = !_isSelected;
    }else if([buttonString isEqualToString:@"扫一扫"]){
        //扫一扫
        TTCScanViewController *scanVC = [[TTCScanViewController alloc] init];
        scanVC.postName = @"客户定位";
        [self.navigationController pushViewController:scanVC animated:YES];
    }else{
        //点击搜索按钮
        _keyno = buttonString;
        [self searchAction:buttonString];
    }
}
//选择类型
- (void)selectType:(NSString *)type{
    [_dragView hideDragView];
    _isSelected = NO;
    [_scrollView loadTypeWithType:type];
//    _typeName = @[@"客户编码",@"智能卡号",@"身份证号",@"电话号码",@"姓名+地址"];
    if ([type isEqualToString:@"姓名+地址"]) {
        _type = 1;
    }else if ([type isEqualToString:@"客户证号"]) {
        _type = 2;
    }else if ([type isEqualToString:@"智能卡号"]) {
        _type = 3;
    }else if ([type isEqualToString:@"客户编码"]) {
        _type = 4;
    }else if ([type isEqualToString:@"身份证号"]) {
        _type = 5;
    }else if ([type isEqualToString:@"电话号码"]) {
        _type = 6;
    }else if ([type isEqualToString:@"地址"]) {
        _type = 7;
    }
    [_scrollView changeHintWithType:_type];
}
//收起键盘
- (void)tapPressed:(UITapGestureRecognizer *)tap{
    for (UIView *allView in _scrollView.subviews) {
        for (UIView *tmpView in allView.subviews) {
            for (UIView *textView in tmpView.subviews) {
                if([textView isKindOfClass:[UITextField class]]){
                    [textView resignFirstResponder];
                }
            }
        }
    }
    _isSelected = NO;
    [_dragView hideDragView];
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //点击清空按钮
        NSArray *dataArray = [NSArray array];
        [_scrollView loadMemoryRecordWithArray:dataArray];
        [_userDefault setObject:dataArray forKey:@"客户ID"];
        [_userDefault synchronize];
    }
}
#pragma mark - Other methods
//搜索动作
- (void)searchAction:(NSString *)icno{
    //请求客户数据
    __weak TTCUserLocateViewController *selfVC = self;
    [self startProgress];
    [_vcViewModel getCustomerInfoWithIcno:icno type:[NSString stringWithFormat:@"%d",_type] success:^(NSMutableArray *resultArray) {
        //请求成功
        __block BOOL balanceOK = NO;
        __block BOOL arrearOK = NO;
        __block BOOL productOK = NO;
        __block BOOL printOK = NO;
        //请求余额信息
        _vcViewModel.balanceSuccessBlock = ^(NSMutableArray *resultArray){
            balanceOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                [selfVC stopProgress];
                [selfVC pushToAction:icno];
            }
        };
        [_vcViewModel getBalanceInfo];
        //请求欠费信息
        _vcViewModel.arrearSuccessBlock = ^(NSMutableArray *resultArray){
            arrearOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                [selfVC stopProgress];
                [selfVC pushToAction:icno];
            }
        };
        [_vcViewModel getArrearsListWithServsArray:_vcViewModel.dataServsArray];
        //请求所有业务信息
        _vcViewModel.userProductSuccessBlock = ^(NSMutableArray *resultArray){
            productOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                [selfVC stopProgress];
                [selfVC pushToAction:icno];
            }
        };
        [_vcViewModel getUseProductWithServsArray:_vcViewModel.dataServsArray];
        //请求所有未打印单信息
        _vcViewModel.noPrintInfoSuccessBlock = ^(NSMutableArray *resultArray){
            printOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                [selfVC stopProgress];
                [selfVC pushToAction:icno];
            }
        };
        _vcViewModel.noPrintInfoFailBlock = ^(NSError *erroe){
            //请求失败
            [selfVC stopProgress];
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"客户定位失败，请重新定位" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [al show];
        };
        [_vcViewModel getNoInvoiceInfo];
    } fail:^(NSError *error) {
        //请求失败
        [self stopProgress];
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:_vcViewModel.failMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
    }];
}
//判断跳转动作
- (void)pushToAction:(NSString *)icno{
    //缓存客户ID
    NSArray *memoryArray = [_userDefault objectForKey:@"客户ID"];
    if (memoryArray.count > 0) {
        //添加新的客户ID
        NSMutableArray *dataArray = [NSMutableArray array];
        BOOL isExit = NO;
        for (int i = 0; i < memoryArray.count; i ++) {
            [dataArray addObject:memoryArray[i]];
            if ([icno isEqualToString:memoryArray[i]]) {
                isExit = YES;
            }
            if (i == memoryArray.count -1 && !isExit) {
                [dataArray addObject:icno];
            }
        }
        [_userDefault setObject:dataArray forKey:@"客户ID"];
    }else{
        //若本为空，创建客户ID数组
        memoryArray = [NSArray arrayWithObjects:icno, nil];
        [_userDefault setObject:memoryArray forKey:@"客户ID"];
    }
    [_userDefault synchronize];
    //记录客户登录状态
    [_userDefault setValue:@"YES" forKey:@"客户登录状态"];
    [_userDefault synchronize];
    if (_isShoppingCar) {
        //购物车
        _appDelegate = [UIApplication sharedApplication].delegate;
        [_appDelegate.tabbarVC selectedControllerIndex:2];
        [self.navigationController popViewControllerAnimated:NO];
    }else if (_isUserDetail) {
        //客户详情
        TTCUserDetailViewController *detailVC = [[TTCUserDetailViewController alloc] init];
        detailVC.addressListArray = _vcViewModel.dataAddrsArray;
        detailVC.allProductArray = _vcViewModel.dataProductArray;
        detailVC.allAccountInfoArray = _vcViewModel.dataBalanceArray;
        detailVC.allServsArray = _vcViewModel.dataServsArray;
        detailVC.allPrintArray = _vcViewModel.dataPrintInfoArray;
        //定位成功，去掉定位页面
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        if(navigationArray.count > 0){
            [navigationArray removeObject:self];
            [navigationArray addObject:detailVC];
            [self.navigationController setViewControllers:navigationArray animated:YES];
        }
    }else if(_isProductOrder){
        //产品订购
        TTCProductLibViewController *productLibVC = [[TTCProductLibViewController alloc] init];
        productLibVC.canGoBack = _canGoBack;
        //定位成功，去掉定位页面
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        if(navigationArray.count > 0){
            [navigationArray removeObject:self];
            [navigationArray addObject:productLibVC];
            [self.navigationController setViewControllers:navigationArray animated:YES];
        }
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCProductLibViewController" object:self userInfo:@{@"type":@"0"}];
    }else if (_isSetOrder){
        //套餐订购
        TTCProductLibViewController *productLibVC = [[TTCProductLibViewController alloc] init];
        productLibVC.canGoBack = _canGoBack;
        //定位成功，去掉定位页面
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        if(navigationArray.count > 0){
            [navigationArray removeObject:self];
            [navigationArray addObject:productLibVC];
            [self.navigationController setViewControllers:navigationArray animated:YES];
        }
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCProductLibViewController" object:self userInfo:@{@"type":@"1"}];
    }else if(_isPayDebt){
        //缴费充值
        TTCDebtViewController *debtVC = [[TTCDebtViewController alloc] init];
        debtVC.allServsArray = _vcViewModel.dataServsArray;
        //定位成功，去掉定位页面
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        if(navigationArray.count > 0){
            [navigationArray removeObject:self];
            [navigationArray addObject:debtVC];
            [self.navigationController setViewControllers:navigationArray animated:YES];
        }
    }else if (_isCheckOrder){
        //订单查询
        TTCOrderRecordViewController *orderRecordVC = [[TTCOrderRecordViewController alloc] init];
        orderRecordVC.isDetail = NO;
        orderRecordVC.canLeave = YES;
        //定位成功，去掉定位页面
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        if(navigationArray.count > 0){
            [navigationArray removeObject:self];
            [navigationArray addObject:orderRecordVC];
            [self.navigationController setViewControllers:navigationArray animated:YES];
        }
    }else if(_isProductDetail){
        //产品详情
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_isPrint){
        //打印发票
        if (_vcViewModel.dataPrintInfoArray.count > 0) {
            TTCPrintViewController *printVC = [[TTCPrintViewController alloc] init];
            //定位成功，去掉定位页面
            NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
            if(navigationArray.count > 0){
                [navigationArray removeObject:self];
                [navigationArray addObject:printVC];
                [self.navigationController setViewControllers:navigationArray animated:YES];
            }
        }else{
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前客户没有需要打印的发票哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
            [self.navigationController popToRootViewControllerAnimated:YES];
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

#pragma mark add-----
//观察者
- (void)addObserver{
    //扫一扫
    [self addObserver:self forKeyPath:@"scanString" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"scanString"]) {
        //扫一扫
        NSString *scanString = [change valueForKey:@"new"];
    
        [_scrollView loadScanStringWithScanString:scanString];
        
    }
    //搜索返回，自动跳转到下个界面
    [self searchAction:_scrollView.textField.text];
}

@end
