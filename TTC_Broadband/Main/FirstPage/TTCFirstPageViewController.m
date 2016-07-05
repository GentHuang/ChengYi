//
//  TTCFirstPageViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCMessageDetailViewController.h"
#import "TTCFirstPageViewController.h"
#import "TTCUserLocateViewController.h"
#import "TTCNavigationController.h"
#import "TTCSellCountViewController.h"
#import "TTCDebtViewController.h"
#import "TTCOrderRecordViewController.h"
#import "TTCRankViewController.h"
#import "TTCPrintViewController.h"
#import "TTCProductLibViewController.h"
#import "TTCUserDetailViewController.h"
#import "TTCSellDetailAllViewController.h"
#import "TTCNewCustomViewController.h"
//View
#import "TTCFirstPageButton.h"
#import "TTCFirstPageBannerView.h"
//ViewModel
#import "TTCFirstPageViewControllerViewModel.h"
#import "TTCUserLocateViewControllerViewModel.h"
//Model
#import "TTCFirstPageViewControllerBannerModel.h"
//Macro
#define kButtonWidth (386/2)
#define kButtonHeight (356/2)
#define kButtonTag 3000
#define kBannerHeight (358/2)
@interface TTCFirstPageViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSArray *buttonImageArray;
@property (strong, nonatomic) NSArray *buttonTitleArray;
@property (strong, nonatomic) TTCFirstPageBannerView *bannerScrollView;

@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@property (strong, nonatomic) NSString *locateType;
@property (strong, nonatomic) TTCFirstPageViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCUserLocateViewControllerViewModel *locateViewModel;

//add  小菊花
@property (strong, nonatomic) UIActivityIndicatorView *activity;
@end
@implementation TTCFirstPageViewController
#pragma mark - Init methods
- (void)initData{
    _buttonImageArray = @[[UIImage imageNamed:@"first_btn_1"],[UIImage imageNamed:@"first_btn_2"],[UIImage imageNamed:@"first_btn_4"],[UIImage imageNamed:@"first_btn_5"],[UIImage imageNamed:@"first_btn_6"],[UIImage imageNamed:@"first_btn_7"],[UIImage imageNamed:@"first_btn_10"],[UIImage imageNamed:@"first_btn_9"],[UIImage imageNamed:@"first_btn_11"],[UIImage new],[UIImage new],[UIImage new]];
//    _buttonImageArray = @[[UIImage imageNamed:@"first_btn_1"],[UIImage imageNamed:@"first_btn_2"],[UIImage imageNamed:@"first_btn_4"],[UIImage imageNamed:@"first_btn_5"],[UIImage imageNamed:@"first_btn_6"],[UIImage imageNamed:@"first_btn_7"],[UIImage imageNamed:@"first_btn_10"],[UIImage imageNamed:@"first_btn_9"],[UIImage new],[UIImage new],[UIImage new],[UIImage new]];

    _buttonTitleArray = @[@"客户定位",@"产品订购",@"套餐订购",@"充值缴费",@"订单查询",@"销售明细",@"排行榜",@"打印发票",@"新建客户",@"",@"",@""];
//    _buttonTitleArray = @[@"客户定位",@"产品订购",@"套餐订购",@"充值缴费",@"订单查询",@"销售明细",@"排行榜",@"打印发票",@"",@"",@"",@""];
    //vcViewModel
    _vcViewModel = [[TTCFirstPageViewControllerViewModel alloc] init];
    //locateViewModel
    _locateViewModel = [[TTCUserLocateViewControllerViewModel alloc] init];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
    //客户信息
    _customerInfo = [CustomerInfo shareInstance];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubviewLayout];
    [self setNavigationBar];
    [self addNotification];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    //    [_scrollView.mj_header beginRefreshing];
    //重新加载数据
    [self reloadScrollViewData];
    //显示tab
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
    [tab showBar];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_scrollView.mj_header endRefreshing];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    __block TTCFirstPageViewController *selfVC = self;
    self.view.userInteractionEnabled = YES;
    //ScrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.backgroundColor = LIGHTGRAY;
    [self.view addSubview:_scrollView];
    //ContentView
    _contentView = [[UIView alloc] init];
    _contentView.userInteractionEnabled = YES;
    _contentView.backgroundColor = CLEAR;
    [_scrollView addSubview:_contentView];
    //BannerScrollView
    _bannerScrollView = [[TTCFirstPageBannerView alloc] init];
    _bannerScrollView.stringBlock = ^(NSString *indexString){
        [selfVC bannerPressed:indexString];
    };
    [_contentView addSubview:_bannerScrollView];
    //下拉刷新
    _scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfVC getData];
    }];
    [_scrollView.mj_header beginRefreshing];
    //----add-----
    //创建小菊花
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activity.transform = CGAffineTransformMakeScale(1, 1);
    [self.view addSubview:_activity];
    _activity.color = [UIColor grayColor];
    //设置菊花转动的位置
    _activity.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*4/5);
}
- (void)setSubviewLayout{
    //ScrollView
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-TAB_HEIGHT);
        make.top.mas_equalTo(NAV_HEIGHT_FIRST-20);
        make.width.mas_equalTo(self.view.mas_width);
    }];
    //ContentView
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_top).with.offset(0);
        make.left.mas_equalTo(_scrollView);
        make.width.mas_equalTo(_scrollView.mas_width);
    }];
    //创建Button列表和底部滚动Banner
    UIView *lastView;
    for (int i = 0; i < _buttonTitleArray.count; i ++) {
        TTCFirstPageButton *allButton = [[TTCFirstPageButton alloc] init];
//        if (i == 8) {
//            allButton.userInteractionEnabled = NO;
//        }
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.backgroundColor = WHITE;
        [allButton loadButtonImage:_buttonImageArray[i]];
        [allButton loadButtonTitle:_buttonTitleArray[i]];
        [_contentView addSubview:allButton];
        if (i == 0) {
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kButtonWidth);
                make.height.mas_equalTo(kButtonHeight);
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
            }];
        }else{
            if (i%4==0) {
                [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(kButtonWidth);
                    make.height.mas_equalTo(kButtonHeight);
                    make.top.mas_equalTo(lastView.mas_bottom).with.offset(0);
                    make.left.mas_equalTo(0);
                }];
            }else{
                [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(kButtonWidth);
                    make.height.mas_equalTo(kButtonHeight);
                    make.top.mas_equalTo(lastView.mas_top);
                    make.left.mas_equalTo(lastView.mas_right).with.offset(0);
                }];
            }
        }
        lastView = allButton;
    }
    //下划线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.25);
    }];
    //创建Banner
    [_bannerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_contentView);
        make.height.mas_equalTo(kBannerHeight);
        make.top.mas_equalTo(lastView.mas_bottom).with.offset(48/2);
    }];
    lastView = _bannerScrollView;
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView.mas_bottom);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nav = (TTCNavigationController *)self.navigationController;
    [nav selectNavigationType:kFirstPageType];
    [nav loadHeaderTitle:@"首页"];
    //从本地获取营销人员数据
    [[FMDBManager sharedInstace] selectModelArrayInDatabase:[SellManInfo sharedInstace] success:^(NSMutableArray *resultArray) {
        SellManInfo *sellInfo = [resultArray firstObject];
        [SellManInfo sharedInstace].md5PSW = sellInfo.md5PSW;
        [SellManInfo sharedInstace].mSales = sellInfo.mSales;
        [SellManInfo sharedInstace].commission = sellInfo.commission;
        [SellManInfo sharedInstace].dSales = sellInfo.dSales;
        [SellManInfo sharedInstace].ranking = sellInfo.ranking;
        [[SellManInfo sharedInstace] loadDepInfoName:sellInfo.depName ID:sellInfo.depID];
        [[SellManInfo sharedInstace] loadSellManInfoWithRequestid:sellInfo.requestid loginname:sellInfo.loginname message:sellInfo.message name:sellInfo.name password:sellInfo.password returnCode:sellInfo.returnCode];
        NSArray *infoArray = @[sellInfo.name,[NSString stringWithFormat:@"工号:%@",sellInfo.loginname],sellInfo.depName];
        [nav loadSellManInfoWithArray:infoArray];
    }];
}
#pragma mark - Event response
//接收通知
- (void)addNotification{
    //首页刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"首页刷新" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"首页刷新"]) {
//        [_scrollView.mj_header beginRefreshing];
        //重新加载数据
        [self reloadScrollViewData];
    }
}
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    int selectedIndex = (int)(button.tag - kButtonTag);
    switch (selectedIndex) {
        case 0:{
            //若客户已经登录，直接跳到客户详情
            if ([[_userDefault valueForKey:@"客户登录状态"] isEqualToString:@"YES"]) {
                //客户详情
                TTCUserDetailViewController *detailVC = [[TTCUserDetailViewController alloc] init];
                //                detailVC.addressListArray = _customerInfo.allAddrsArray;
                //                detailVC.allProductArray = _customerInfo.allProductArray;
                //                detailVC.allAccountInfoArray = _customerInfo.allBalanceArray;
                //                detailVC.allServsArray = _customerInfo.allServsArray;
                //                detailVC.allPrintArray = _customerInfo.allPrintInfoArray;
                [self.navigationController pushViewController:detailVC animated:YES];
            }else{
                //客户定位
                TTCUserLocateViewController *userLocateVC = [[TTCUserLocateViewController alloc] init];
                userLocateVC.appDelegate = self.appDelegate;
                userLocateVC.isUserDetail = YES;
                userLocateVC.canGoBack = YES;
                [self.navigationController pushViewController:userLocateVC animated:YES];
            }
        }
            break;
        case 1:{
            //若客户未定位，提醒
            //            if ([[_userDefault valueForKey:@"客户登录状态"] isEqualToString:@"NO"]) {
            //                _locateType = @"isProductOrder";
            //                [self userIsNotLocate];
            //            }else{
            //产品订购
            TTCProductLibViewController *productLibVC = [[TTCProductLibViewController alloc] init];
            productLibVC.canGoBack = YES;
            [self.navigationController pushViewController:productLibVC animated:YES];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCProductLibViewController" object:self userInfo:@{@"type":@"1"}];
            //            }
        }
            break;
        case 2:{
            //            //若客户未定位，提醒
            //            if ([[_userDefault valueForKey:@"客户登录状态"] isEqualToString:@"NO"]) {
            //                [self userIsNotLocate];
            //                _locateType = @"isSetOrder";
            //            }else{
            //套餐订购
            TTCProductLibViewController *productLibVC = [[TTCProductLibViewController alloc] init];
            productLibVC.canGoBack = YES;
            [self.navigationController pushViewController:productLibVC animated:YES];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCProductLibViewController" object:self userInfo:@{@"type":@"3"}];
            //            }
        }
            break;
        case 3:{
            //若客户未定位，提醒
            if ([[_userDefault valueForKey:@"客户登录状态"] isEqualToString:@"NO"]) {
                [self userIsNotLocate];
                _locateType = @"isPayDebt";
            }else{
                //缴费充值
                TTCDebtViewController *debtVC = [[TTCDebtViewController alloc] init];
                debtVC.allServsArray = _customerInfo.allServsArray;
                [self.navigationController pushViewController:debtVC animated:YES];
            }
        }
            break;
        case 4:{
            //若客户未定位，提醒
            if ([[_userDefault valueForKey:@"客户登录状态"] isEqualToString:@"NO"]) {
                [self userIsNotLocate];
                _locateType = @"isCheckOrder";
            }else{
                //订单查询
                TTCOrderRecordViewController *orderRecordVC = [[TTCOrderRecordViewController alloc] init];
                orderRecordVC.isDetail = NO;
                orderRecordVC.canLeave = YES;
                [self.navigationController pushViewController:orderRecordVC animated:YES];
            }
        }
            break;
        case 5:{
            //销售明细
            TTCSellDetailAllViewController *sellDetailMonthVC = [[TTCSellDetailAllViewController alloc] init];
            [self.navigationController pushViewController:sellDetailMonthVC animated:YES];
        }
            break;
        case 6:{
            //排行榜
            TTCRankViewController *rankVC = [[TTCRankViewController alloc] init];
            [self.navigationController pushViewController:rankVC animated:YES];
        }
            break;
        case 7:{
            //若客户未定位，提醒
            if ([[_userDefault valueForKey:@"客户登录状态"] isEqualToString:@"NO"]) {
                [self userIsNotLocate];
                _locateType = @"isPrint";
            }else{
                //打印发票
                if (_customerInfo.allPrintInfoArray.count > 0) {
                    TTCPrintViewController *printVC = [[TTCPrintViewController alloc] init];
                    [self.navigationController pushViewController:printVC animated:YES];
                }else{
                    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前客户没有需要打印的发票哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alView show];
                }
                
            }
        }
            break;
        case 8:{
            //新建客户
            TTCNewCustomViewController *newCustomVC = [[TTCNewCustomViewController alloc] init];
            [self.navigationController pushViewController:newCustomVC animated:YES];
        }
            break;
        default:
            break;
    }
}
//点击Banner
- (void)bannerPressed:(NSString *)indexString{
    if(_vcViewModel.dataBannerArray.count > [indexString integerValue]){
        TTCMessageDetailViewController *msgDetailVC = [[TTCMessageDetailViewController alloc] init];
        TTCFirstPageViewControllerBannerModel *bannerModel = _vcViewModel.dataBannerArray[[indexString intValue]];
        msgDetailVC.mid = bannerModel.messageid;
        msgDetailVC.content = bannerModel.content;
        [self.navigationController pushViewController:msgDetailVC animated:YES];
    }
}
#pragma mark - Network request
//获取信息
- (void)getData{
    __block TTCFirstPageViewController *selfVC = self;
    __block TTCFirstPageViewControllerViewModel *selfViewModel = _vcViewModel;
    __block BOOL isBanner = NO;
    __block BOOL isPrint = NO;
    //若客户已经登录，显示为客户详情
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    TTCFirstPageButton *locateButton = (TTCFirstPageButton *)[self.view viewWithTag:kButtonTag];
    if ([[_userDefault valueForKey:@"客户登录状态"] isEqualToString:@"YES"]) {
        [locateButton loadButtonTitle:@"客户详情"];
        [nvc loadCustomerFirstPageInformation:YES];
    }else{
        [locateButton loadButtonTitle:@"客户定位"];
        [nvc loadCustomerFirstPageInformation:NO];
    }
    if (_customerInfo.custid.length > 0) {
        //已经登录，需要刷新未开票数据
        //请求所有未打印单信息
        _locateViewModel.noPrintInfoSuccessBlock = ^(NSMutableArray *resultArray){
            isPrint = YES;
            if (isBanner && isPrint) {
                //成功
                [selfVC.scrollView.mj_header endRefreshing];
            }
        };
        _locateViewModel.noPrintInfoFailBlock = ^(NSError *error){
            isPrint = YES;
            if (isBanner && isPrint) {
                //成功
                [selfVC.scrollView.mj_header endRefreshing];
            }
        };
        [_locateViewModel getNoInvoiceInfo];
    }else{
        //还没登陆,不需要刷新未开票数据
        isPrint = YES;
    }
    //获取banner
    [_vcViewModel getBannerSuccess:^(NSMutableArray *resultArray) {
        isBanner = YES;
        if (isBanner && isPrint) {
            //成功
            [selfVC.scrollView.mj_header endRefreshing];
            [selfVC.bannerScrollView loadBannerWithImageArray:selfViewModel.dataImageArray];
        }
    } fail:^(NSError *error) {
        isBanner = YES;
        if (isBanner && isPrint) {
            //失败
            [selfVC.scrollView.mj_header endRefreshing];
        }
    }];
    //获取是否有新消息
    __block TTCNavigationController *nav = (TTCNavigationController *)self.navigationController;
    [_vcViewModel getAllMessageWithPage:1 success:^(NSMutableArray *resultArray) {
        [nav newsHint:selfViewModel.hasNew];
    } fail:^(NSError *error) {
        [nav newsHint:selfViewModel.hasNew];
    }];
}
#pragma mark - Protocol methods
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //客户定位
        TTCUserLocateViewController *userLocateVC = [[TTCUserLocateViewController alloc] init];
        userLocateVC.appDelegate = self.appDelegate;
        userLocateVC.canGoBack = YES;
        if ([_locateType isEqualToString:@"isProductOrder"]) {
            //产品订购
            userLocateVC.isProductOrder = YES;
            userLocateVC.canGoBack = YES;
        }else if([_locateType isEqualToString:@"isUserDetail"]){
            //客户详情
            userLocateVC.isUserDetail = YES;
        }else if([_locateType isEqualToString:@"isProductLib"]){
            //产品库
            //            userLocateVC.isProductLib = YES;
        }else if([_locateType isEqualToString:@"isSetOrder"]){
            //套餐订购
            userLocateVC.isSetOrder = YES;
            userLocateVC.canGoBack = YES;
        }else if([_locateType isEqualToString:@"isPayDebt"]){
            //缴费充值
            userLocateVC.isPayDebt = YES;
        }else if([_locateType isEqualToString:@"isCheckOrder"]){
            //订单查询
            userLocateVC.isCheckOrder = YES;
        }else if([_locateType isEqualToString:@"isShoppingCar"]){
            //购物车
            userLocateVC.isShoppingCar = YES;
        }else if([_locateType isEqualToString:@"isPrint"]){
            //打印发票
            userLocateVC.isPrint = YES;
        }
        [self.navigationController pushViewController:userLocateVC animated:YES];
    }
}
#pragma mark - Other methods
//客户未定位
- (void)userIsNotLocate{
    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先定位客户" delegate:self cancelButtonTitle:@"定位" otherButtonTitles:@"取消", nil];
    [alView show];
}  
- (void)reloadScrollViewData{
    //3.开启动画
    [_activity startAnimating];
    //加载数据
    [self getData];
   [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideActivityView:) userInfo:_activity repeats:NO];
}
-(void)hideActivityView:(NSTimer *)timer{
        UIActivityIndicatorView *activity = timer.userInfo;
        //关闭动画(在某个点触发)
        [activity stopAnimating];
}
@end
