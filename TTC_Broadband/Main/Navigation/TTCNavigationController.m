//
//  TTCNavigationController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCNavigationController.h"
#import "TTCOrderRecordViewController.h"
#import "TTCTabbarController.h"
#import "TTCUserLocateViewController.h"
#import "TTCMessageViewController.h"
#import "TTCModifiedDataViewController.h"
#import "TTCSellCountViewController.h"
#import "TTCRankViewController.h"
#import "AppDelegate.h"
//View
#import "TTCFirstPageTypeBar.h"
#import "TTCUserLocateBar.h"
#import "TTCProductLibBar.h"
#import "TTCProductDetailBar.h"
#import "TTCUserDetailBar.h"
#import "TTCShoppingCarBar.h"
#import "TTCMeBar.h"
#import "TTCAccountInfoBar.h"
#import "TTCSellCountBar.h"
#import "TTCSellDetailMonthBar.h"
#import "TTCSellDetailDayBar.h"
#import "TTCOrderRecordBar.h"
//add
#import "TTCAccuntResultBar.h"

@interface TTCNavigationController ()<UIAlertViewDelegate>
//首页
@property (strong, nonatomic) TTCFirstPageTypeBar *firstPageTypeBar;
//客户定位
@property (strong, nonatomic) TTCUserLocateBar *userLocateBar;
//产品库
@property (strong, nonatomic) TTCProductLibBar *productLibBar;
//产品详情
@property (strong, nonatomic) TTCProductDetailBar *productDetailBar;
//客户详情
@property (strong, nonatomic) TTCUserDetailBar *userDetailBar;
//购物车
@property (strong, nonatomic) TTCShoppingCarBar *shoppingCarBar;
//我
@property (strong, nonatomic) TTCMeBar *meBar;
//账本信息
@property (strong, nonatomic) TTCAccountInfoBar *accountInfoBar;
//销售统计
@property (strong, nonatomic) TTCSellCountBar *sellCountBar;
//销售明细（月）
@property (strong, nonatomic) TTCSellDetailMonthBar *sellDetailMonthBar;
//销售明细（日）
@property (strong, nonatomic) TTCSellDetailDayBar *sellDetailDayBar;
//订单记录
@property (strong, nonatomic) TTCOrderRecordBar *orderRecordBar;
//开户结果查询模式
@property (strong, nonatomic) TTCAccuntResultBar *AccuntResultBar;
@end
@implementation TTCNavigationController
#pragma mark - Init methods
- (void)initData{
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubviewLayout];
    [self notificationRecieve];
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Getters and setters
- (void)createUI{
    self.navigationBar.hidden = YES;
    __block TTCNavigationController *selfVC = self;
    //首页模式
    //背景Bar
    _firstPageTypeBar = [[TTCFirstPageTypeBar alloc] init];
    _firstPageTypeBar.hidden = YES;
    _firstPageTypeBar.backgroundColor = WHITE;
    _firstPageTypeBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_firstPageTypeBar];
    //客户定位
    _userLocateBar = [[TTCUserLocateBar alloc] init];
    _userLocateBar.hidden = YES;
    _userLocateBar.barTintColor = CLEAR;
    _userLocateBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_userLocateBar];
    //产品库
    _productLibBar = [[TTCProductLibBar alloc] init];
    _productLibBar.hidden = YES;
    _productLibBar.barTintColor = CLEAR;
    _productLibBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_productLibBar];
    //产品详情
    _productDetailBar = [[TTCProductDetailBar alloc] init];
    _productDetailBar.hidden = YES;
    _productDetailBar.barTintColor = CLEAR;
    _productDetailBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_productDetailBar];
    //客户详情
    _userDetailBar = [[TTCUserDetailBar alloc] init];
    _userDetailBar.hidden = YES;
    _userDetailBar.barTintColor = CLEAR;
    _userDetailBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_userDetailBar];
    //购物车
    _shoppingCarBar = [[TTCShoppingCarBar alloc] init];
    _shoppingCarBar.hidden = YES;
    _shoppingCarBar.barTintColor = CLEAR;
    _shoppingCarBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_shoppingCarBar];
    //我
    _meBar = [[TTCMeBar alloc] init];
    _meBar.hidden = YES;
    _meBar.barTintColor = CLEAR;
    _meBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_meBar];
    //账本信息
    _accountInfoBar = [[TTCAccountInfoBar alloc] init];
    _accountInfoBar.hidden = YES;
    _accountInfoBar.barTintColor = CLEAR;
    _accountInfoBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_accountInfoBar];
    //销售统计
    _sellCountBar = [[TTCSellCountBar alloc] init];
    _sellCountBar.hidden = YES;
    _sellCountBar.barTintColor = CLEAR;
    _sellCountBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_sellCountBar];
    //销售明细（月）
    _sellDetailMonthBar = [[TTCSellDetailMonthBar alloc] init];
    _sellDetailMonthBar.hidden = YES;
    _sellDetailMonthBar.barTintColor = CLEAR;
    _sellDetailMonthBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_sellDetailMonthBar];
    //销售明细（日）
    _sellDetailDayBar = [[TTCSellDetailDayBar alloc] init];
    _sellDetailDayBar.hidden = YES;
    _sellDetailDayBar.barTintColor = CLEAR;
    _sellDetailDayBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_sellDetailDayBar];
    //客户详情
    _orderRecordBar = [[TTCOrderRecordBar alloc] init];
    _orderRecordBar.hidden = YES;
    _orderRecordBar.barTintColor = CLEAR;
    _orderRecordBar.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_orderRecordBar];
    
//    //开户结果查询模式
//    _AccuntResultBar = [[TTCAccuntResultBar alloc]init];
//    _AccuntResultBar.hidden = YES;
//    _AccuntResultBar.barTintColor = CLEAR;
//    _AccuntResultBar.stringBlock = ^(NSString *buttonString){
//        [selfVC buttonPressed:buttonString];
//    };
    
    
}
- (void)setSubviewLayout{
    //首页模式
    [_firstPageTypeBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_FIRST);
    }];
    //客户定位模式
    [_userLocateBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(NAV_HEIGHT_USERLOCATE);
        make.height.mas_equalTo(NAV_HEIGHT_FIRST);

    }];
    //产品库
    [_productLibBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_PROLIB);
    }];
    //产品详情
    [_productDetailBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_PRODEL);
    }];
    //客户详情
    [_userDetailBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_USERDEL);
    }];
    //购物车
    [_shoppingCarBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_SHOPPINGCAR);
    }];
    //我
    [_meBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_ME);
    }];
    //账本信息
    [_accountInfoBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO);
    }];
    //销售统计
    [_sellCountBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_SELLCOUNT);
    }];
    //销售明细（月）
    [_sellDetailMonthBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_SELLDETAIL);
    }];
    //销售明细（日）
    [_sellDetailDayBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_SELLDETAIL);
    }];
    //订单记录模式
    [_orderRecordBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT_ORDERRECORD);
    }];
    //开户状态结果查询模式
//    [_AccuntResultBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.mas_equalTo(NAV_HEIGHT_USERLOCATE);
//    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(NSString *)buttonString{
    if ([buttonString isEqualToString:@"扫一扫"] || [buttonString isEqualToString:@"扫一扫"]) {
        NSLog(@"扫一扫");
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"扫一扫" object:nil];
    }else if([buttonString isEqualToString:@"信息"]){
        TTCMessageViewController *messageVC = [[TTCMessageViewController alloc] init];
        [self pushViewController:messageVC animated:YES];
    }else if([buttonString isEqualToString:@"后退"]){
        [self popViewControllerAnimated:YES];
    }else if ([buttonString isEqualToString:@"预约列表"]){
        NSLog(@"预约列表");
    }else if ([buttonString isEqualToString:@"搜索"]){
        NSLog(@"搜索");
    }else if ([buttonString isEqualToString:@"客户离开"]){
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if([[userDefault valueForKey:@"客户登录状态"] isEqualToString:@"NO"]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前没有定位任何客户" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alView show];
            
        }else{
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定客户离开吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alView show];
        }
    }else if ([buttonString isEqualToString:@"产品订购"]){
        TTCTabbarController *tabbarVC = (TTCTabbarController *)self.tabBarController;
        [tabbarVC selectedControllerIndex:1];
    }else if ([buttonString isEqualToString:@"客户分析"]){
        NSLog(@"客户分析");
    }else if ([buttonString isEqualToString:@"修改资料"]){
        TTCModifiedDataViewController *modifiedDataVC = [[TTCModifiedDataViewController alloc] init];
        [self pushViewController:modifiedDataVC animated:YES];
    }else if ([buttonString isEqualToString:@"订单记录"]){
        TTCOrderRecordViewController *orderRecordVC = [[TTCOrderRecordViewController alloc] init];
        orderRecordVC.isDetail = NO;
        orderRecordVC.canLeave = YES;
        [self pushViewController:orderRecordVC animated:YES];
    }else if ([buttonString isEqualToString:@"销售统计"]){
        TTCSellCountViewController *sellCountVC = [[TTCSellCountViewController alloc] init];
        [self pushViewController:sellCountVC animated:YES];
    }else if ([buttonString isEqualToString:@"排行榜"]){
        TTCRankViewController *rankVC = [[TTCRankViewController alloc] init];
        [self pushViewController:rankVC animated:YES];
    }else if ([buttonString isEqualToString:@"隐藏数字"]){
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"隐藏数字" object:nil];
    }else if ([buttonString isEqualToString:@"选择月份"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"选择月份" object:self userInfo:nil];
    }
}
//接收通知
- (void)notificationRecieve{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"选择年月" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"选择年月"]) {
        NSString *year = [notification.userInfo valueForKey:@"年"];
        NSString *month = [notification.userInfo valueForKey:@"月"];
        [_sellDetailMonthBar loadYearTitle:year monthTitle:month];
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //客户离开
        //客户登录状态退出
        [_firstPageTypeBar loadCustomerFirstPageInformation:NO];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setValue:@"NO" forKey:@"客户登录状态"];
        [userDefault synchronize];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.tabbarVC selectedControllerIndex:0];
    }
}
#pragma mark - Other methods
//选择导航栏样式
- (void)selectNavigationType:(NavigationType)type{
    switch (type) {
        case 0:
            [self useNoneType];
            break;
        case 1:
            [self useFirstPageType];
            break;
        case 2:
            [self userUserLocateType];
            break;
        case 3:
            [self useProductLibType];
            break;
        case 4:
            [self useProductDetailType];
            break;
        case 5:
            [self useUserDetailType];
            break;
        case 6:
            [self useShoppingCarType];
            break;
        case 7:
            [self useMeType];
            break;
        case 8:
            [self useAccountInfoType];
            break;
        case 9:
            [self useSellCountType];
            break;
        case 10:
            [self useSellDetailMonthType];
            break;
        case 11:
            [self useSellDetailDayType];
            break;
        case 12:
            [self useOrderRecordType];
            break;
//        case 13:
//            [self useAccountInfoType];
//            break;
        default:
            break;
    }
}
//空模式
- (void)useNoneType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
    
//     _AccuntResultBar.hidden = YES;
}
//首页模式
- (void)useFirstPageType{
    _firstPageTypeBar.hidden = NO;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
    
//     _AccuntResultBar.hidden = YES;
}
//客户定位
- (void)userUserLocateType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = NO;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
    
//     _AccuntResultBar.hidden = YES;
}
//产品库
- (void)useProductLibType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = NO;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
    
//     _AccuntResultBar.hidden = YES;
}
//产品详情
- (void)useProductDetailType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = NO;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
    
//     _AccuntResultBar.hidden = YES;
}
//客户详情
- (void)useUserDetailType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = NO;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
    
//     _AccuntResultBar.hidden = YES;
}
//购物车
- (void)useShoppingCarType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = NO;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
//     _AccuntResultBar.hidden = YES;
}
//我
- (void)useMeType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = NO;
    _meBar.hidden = NO;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
//     _AccuntResultBar.hidden = YES;
}
//账本信息
- (void)useAccountInfoType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = NO;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
//     _AccuntResultBar.hidden = YES;
}
//销售统计
- (void)useSellCountType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = NO;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
//     _AccuntResultBar.hidden = YES;
}
//销售明细（月）
- (void)useSellDetailMonthType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = NO;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = YES;
//     _AccuntResultBar.hidden = YES;
    [_sellDetailMonthBar reloadSelectedButton];
}
//销售明细（日）
- (void)useSellDetailDayType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = NO;
    _orderRecordBar.hidden = YES;
//     _AccuntResultBar.hidden = YES;
    [_sellDetailDayBar reloadSelectedButton];
}
//订单记录
- (void)useOrderRecordType{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
    _orderRecordBar.hidden = NO;
//    _AccuntResultBar.hidden = YES;
}
//开户结果查询
//- (void)useAccuntResultType{
//    _firstPageTypeBar.hidden = YES;
//    _userLocateBar.hidden = YES;
//    _productLibBar.hidden = YES;
//    _productDetailBar.hidden = YES;
//    _userDetailBar.hidden = YES;
//    _shoppingCarBar.hidden = YES;
//    _meBar.hidden = YES;
//    _accountInfoBar.hidden = YES;
//    _sellCountBar.hidden = YES;
//    _sellDetailMonthBar.hidden = YES;
//    _sellDetailDayBar.hidden = YES;
//    _orderRecordBar.hidden = YES;
//    _AccuntResultBar.hidden = NO;
//}
//填入首页信息(姓名,ID,部门,营业厅,片区)
- (void)loadFirstPageInformation:(NSArray *)dataArray{
    [_firstPageTypeBar loadFirstPageInformation:dataArray];
}
//客户是否已登录(姓名,地区)
- (void)loadCustomerFirstPageInformation:(BOOL)isLog{
    [_firstPageTypeBar loadCustomerFirstPageInformation:isLog];
}
//填入我信息(姓名,ID,部门,营业厅,片区)
- (void)loadMeInformation:(NSArray *)dataArray{
    [_meBar loadMeInformation:dataArray];
}
//设置标题
- (void)loadHeaderTitle:(NSString *)title{
    [_firstPageTypeBar loadFirstPageHeaderLabel:title];
    [_userLocateBar loadUserLocateHeaderLabel:title];
    [_productLibBar loadProductLibHeaderLabel:title];
    [_productDetailBar loadproductDetailHeaderLabel:title];
    [_userDetailBar loadUserDetailHeaderLabel:title];
    [_meBar loadMeHeaderLabel:title];
    [_accountInfoBar loadAccountInfoHeaderLabel:title];
    [_sellCountBar loadSellCountHeaderLabel:title];
    [_sellDetailMonthBar loadSellDetailMonthHeaderLabel:title];
    [_sellDetailDayBar loadSellDetailDayHeaderLabel:title];
    [_orderRecordBar loadOrderRecordLabel:title];
}
//加载营销人员信息
- (void)loadSellManInfoWithArray:(NSArray *)dataArray{
    [_firstPageTypeBar loadFirstPageInformation:dataArray];
}
//加载客户信息
- (void)loadClientInformationWithCustid:(NSString *)custid markno:(NSString *)markno phone:(NSString *)phone addr:(NSString *)addr name:(NSString *)name{
    [_userDetailBar loadClientInformationWithCustid:custid markno:markno phone:phone addr:addr name:name];
}
//加载销售统计信息
- (void)loadWithMname:(NSString *)mname mcode:(NSString *)mcode deptname:(NSString *)deptname commission:(NSString *)commission{
    [_sellCountBar loadWithMname:mname mcode:mcode deptname:deptname commission:commission];
}
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack{
    [_accountInfoBar canGoBack:canGoBack];
    [_productDetailBar canGoBack:canGoBack];
}
//是否显示客户离开选项按钮
- (void)ClientLeaveButton:(BOOL)isHidden {
    [_accountInfoBar accountInfoLeaveButton:isHidden];
}
//更新销售额(月)
- (void)loadMonthSellCount:(NSString *)count{
    [_sellDetailMonthBar loadMonthSellCount:count];
}
//更新销售额(日)
- (void)loadDaySellCount:(NSString *)count{
    [_sellDetailDayBar loadDaySellCount:count];
}
//设置营销人员姓名，客户姓名
- (void)loadWithSellManName:(NSString *)sName customerName:(NSString *)cName{
    [_shoppingCarBar loadWithSellManName:sName customerName:cName];
}
//隐藏Bar
- (void)hideBar{
    _firstPageTypeBar.hidden = YES;
    _userLocateBar.hidden = YES;
    _productLibBar.hidden = YES;
    _productDetailBar.hidden = YES;
    _userDetailBar.hidden = YES;
    _shoppingCarBar.hidden = YES;
    _meBar.hidden = YES;
    _accountInfoBar.hidden = YES;
    _sellCountBar.hidden = YES;
    _sellDetailMonthBar.hidden = YES;
    _sellDetailDayBar.hidden = YES;
}
//显示Bar
- (void)showBar{
    _firstPageTypeBar.hidden = NO;
    _userLocateBar.hidden = NO;
    _productLibBar.hidden = NO;
    _productDetailBar.hidden = NO;
    _userDetailBar.hidden = NO;
    _shoppingCarBar.hidden = NO;
    _meBar.hidden = NO;
    _accountInfoBar.hidden = NO;
    _sellCountBar.hidden = NO;
    _sellDetailMonthBar.hidden = NO;
    _sellDetailDayBar.hidden = NO;
}
//新消息提示
- (void)newsHint:(BOOL)hasNew{
    [_firstPageTypeBar newsHint:hasNew];
}
//是否隐藏本月销售和今日销售
- (void)hideMonthAndDaySell:(BOOL)isHide{
    [_sellDetailMonthBar hideMonthAndDaySell:isHide];
}
//加载订单记录客户名称
- (void)loadOrderRecordCustNameLabelWith:(NSString *)custNameString{
    [_orderRecordBar loadOrderRecordCustNameLabelWith:custNameString];
}
//更新点选按钮
- (void)reloadSelectedButtonWithIsAll:(BOOL)isAll{
    [_orderRecordBar reloadSelectedButtonWithIsAll:isAll];
}
@end
