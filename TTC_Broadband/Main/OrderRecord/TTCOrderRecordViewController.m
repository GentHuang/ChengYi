//
//  TTCOrderRecordViewController.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCOrderRecordViewController.h"
#import "TTCNavigationController.h"
#import "TTCUserDetailViewController.h"
#import "TTCProductDetailViewController.h"
#import "TTCPayViewController.h"
//View
#import "TTCOrderRecordViewCell.h"
//ViewModel
#import "TTCOrderRecordViewControllerViewModel.h"
//Model
#import "TTCOrderRecordViewControllerOutputOrderModel.h"
#import "TTCSellDetailMonthViewControllerModel.h"
#import "TTCSellDetailMonthViewControllerOdsModel.h"
#import "TTCProductDetailViewControllerModel.h"

@interface TTCOrderRecordViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchResultsUpdating,UISearchBarDelegate>
@property (strong, nonatomic) TTCOrderRecordViewControllerOutputOrderModel *orderModel;
@property (strong, nonatomic) TTCOrderRecordViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@property (strong, nonatomic) SellManInfo *sellManInfo;
@property (strong, nonatomic) MBProgressHUD *progressHud;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchVC;
@property (strong, nonatomic) NSMutableArray *searchArray;
@property (assign, nonatomic) int arrayCount;
@property (assign, nonatomic) int page;
@property (assign, nonatomic) BOOL isALL;
@end
@implementation TTCOrderRecordViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCOrderRecordViewControllerViewModel alloc] init];
    //Customer
    _customerInfo = [CustomerInfo shareInstance];
    //SellManInfo
    _sellManInfo = [SellManInfo sharedInstace];
    //searchArray
    _searchArray = [NSMutableArray array];
    //userDefaults
    _userDefault = [NSUserDefaults standardUserDefaults];
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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchVC dismissViewControllerAnimated:NO completion:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    _isALL = YES;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCOrderRecordViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHeaderData];
    }];
    //客户订单
    [_tableView.mj_header beginRefreshing];
    //上拉刷新
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getFooterData];
    }];
    //搜索栏
    _searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchVC.hidesNavigationBarDuringPresentation = NO;
    _searchVC.dimsBackgroundDuringPresentation = NO;
    _searchVC.searchResultsUpdater = self;
    _searchVC.searchBar.delegate = self;
    _searchVC.searchBar.barTintColor = WHITE;
    for (UIView *subView in _searchVC.searchBar.subviews) {
        for (UIView *a in subView.subviews) {
            if ([a isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                UITextField *searchField = (UITextField *)a;
                searchField.layer.borderWidth = 0.5;
                searchField.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
                searchField.layer.masksToBounds = YES;
                searchField.layer.cornerRadius = 3;
                searchField.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH-2*(57/2), 50/2);
            }
        }
    }
    _searchVC.searchBar.placeholder = @"搜索流水号";
    _searchVC.searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    _searchVC.searchBar.layer.borderWidth = 0.5;
    _searchVC.searchBar.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
    _searchVC.searchBar.layer.masksToBounds = YES;
    _searchVC.searchBar.layer.cornerRadius = 0;
    _searchVC.searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    _tableView.tableHeaderView = _searchVC.searchBar;
    //加载进度
    _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHud.hidden = YES;
    [_progressHud show:NO];
    [self.view addSubview:_progressHud];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ORDERRECORD-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc loadHeaderTitle:@"订单记录"];
    [nvc selectNavigationType:kOrderRecordType];
    [nvc loadOrderRecordCustNameLabelWith:[CustomerInfo shareInstance].custname];
    [nvc reloadSelectedButtonWithIsAll:_isALL];
}
#pragma mark - Event response
//接收通知
- (void)notificationRecieve{
    //全部订单
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"全部订单" object:nil];
    //未支付订单
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"未支付订单" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"全部订单"]) {
        _isALL = YES;
        [_tableView.mj_header beginRefreshing];
    }else if ([notification.name isEqualToString:@"未支付订单"]) {
        _isALL = NO;
        [_tableView.mj_header beginRefreshing];
    }
}
//打印受理单
- (void)buyButtonPressed:(NSInteger)index{
    if (_searchVC.active) {
        _orderModel = _searchArray[index];
    }else{
        _orderModel = _vcViewModel.dataOrderArray[index];
    }
    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认打印" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alView show];
}
//前往支付
- (void)payButtonPressed:(NSInteger)index{
    if (_searchVC.active) {
        _orderModel = _searchArray[index];
    }else{
        _orderModel = _vcViewModel.dataOrderArray[index];
    }
    TTCProductDetailViewControllerModel *orderModel = [[TTCProductDetailViewControllerModel alloc] init];
    orderModel.id_conflict = _orderModel.orderid;
    orderModel.title = _orderModel.pname;
    orderModel.price = _orderModel.fees;
    orderModel.smallimg = @"";
    TTCPayViewController *payVC = [[TTCPayViewController alloc] init];
    payVC.priceCount = _orderModel.counts;
    payVC.isOrderPay = YES;
    payVC.vcModel = orderModel;
    NSArray *orderIDArray = [NSArray arrayWithObjects:orderModel.id_conflict, nil];
    payVC.orderDataArray = orderIDArray;
    [self.navigationController pushViewController:payVC animated:YES];
}
#pragma mark - Network request
//下拉刷新
- (void)getHeaderData{
    _page = 1;
    _arrayCount = 0;
    [_tableView.mj_footer resetNoMoreData];
    if (!_isDetail) {
        if (_customerInfo.icno != nil) {
            __block TTCOrderRecordViewController *selfVC = self;
            //获取订单信息
            [_vcViewModel getOrdersListPage:_page isAll:_isALL success:^(NSMutableArray *resultArray) {
                //获取成功
                [selfVC.tableView reloadData];
                [selfVC.tableView.mj_header endRefreshing];
                [selfVC updateSearchResultsForSearchController:selfVC.searchVC];
            } fail:^(NSError *error) {
                //获取失败
                [selfVC.tableView reloadData];
                [selfVC.tableView.mj_header endRefreshing];
                [selfVC updateSearchResultsForSearchController:selfVC.searchVC];
            }];
        }
    }
}
//上拉刷新
- (void)getFooterData{
    _page ++;
    if (!_isDetail) {
        if (_customerInfo.icno != nil) {
            __block TTCOrderRecordViewController *selfVC = self;
            __block TTCOrderRecordViewControllerViewModel *selfViewModel = _vcViewModel;
            //获取订单信息
            [_vcViewModel getOrdersListPage:_page isAll:_isALL success:^(NSMutableArray *resultArray) {
                //获取成功
                [selfVC.tableView reloadData];
                //尾部判断是否全部数据请求完成
                if (selfVC.arrayCount != _vcViewModel.dataOrderArray.count) {
                    _arrayCount = (int)selfViewModel.dataOrderArray.count;
                    [selfVC.tableView.mj_footer endRefreshing];
                }else{
                    [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                [selfVC updateSearchResultsForSearchController:selfVC.searchVC];
            } fail:^(NSError *error) {
                //获取失败
                [selfVC.tableView reloadData];
                //尾部判断是否全部数据请求完成
                if (selfVC.arrayCount != _vcViewModel.dataOrderArray.count) {
                    _arrayCount = (int)selfViewModel.dataOrderArray.count;
                    [selfVC.tableView.mj_footer endRefreshing];
                }else{
                    [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                [selfVC updateSearchResultsForSearchController:selfVC.searchVC];
            }];
        }
    }
}
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //客户订单记录
    if (_searchVC.active) {
        if (_searchArray.count > 0) {
            return _searchArray.count;
        }else{
            return 0;
        }
    }else{
        if (_vcViewModel.dataOrderArray.count > 0) {
            return _vcViewModel.dataOrderArray.count;
        }else{
            return 0;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCOrderRecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexBlock = ^(NSInteger index){
        if (index == 0) {
            //前往支付
            [self payButtonPressed:indexPath.section];
        }else if(index == 1){
            //打印受理单
            [self buyButtonPressed:indexPath.section];
        }
    };
    //客户订单记录
    //套餐详情
    TTCOrderRecordViewControllerOutputOrderModel *orderModel;
    if (_searchVC.active) {
        //搜索结果
        if (_searchArray.count > 0) {
            orderModel = _searchArray[indexPath.section];
        }
    }else if (_vcViewModel.dataOrderArray.count > 0) {
        //非搜索结果
        orderModel = _vcViewModel.dataOrderArray[indexPath.section];
    }
    if (indexPath.row == 0) {
        //业务流水号 业务受理时间
        [cell selectCellType:kSetHeaderType];
        [cell loadOrderID:orderModel.serialno];
        [cell loadDateWithDateString:orderModel.createtime];
    }else if(indexPath.row == 2){
        //总金额 营销人员信息
        [cell selectCellType:kSetFooterType];
        [cell loadPrice:orderModel.fees sellManDepName:_sellManInfo.depName name:_sellManInfo.name];
        //支付状态
        if (orderModel.commitmsg.length > 0) {
            [cell loadTypeLabelWithTypeString:orderModel.commitmsg];
        }else{
            [cell loadTypeLabelWithTypeString:@""];
        }
    }else{
        //套餐详情
        [cell selectCellType:kSetDetailType];
        //前往支付
        [cell goToPay:_isALL];
        //计算单价
        float singlePrice = [orderModel.fees floatValue]/[orderModel.counts floatValue];
        [cell loadWithPname:orderModel.pname createtime:orderModel.createtime fees:[NSString stringWithFormat:@"%.02f",singlePrice] count:orderModel.counts];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 2) {
        return 90/2;
    }else{
        return 188/2;
    }
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 12;
    }else{
        return 0.001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    __block TTCOrderRecordViewControllerViewModel *selfViewModel = _vcViewModel;
    __block TTCOrderRecordViewController *selfVC = self;
    if (buttonIndex == 0) {
        //链接打印机
        [_vcViewModel connectToPrinterSuccess:^(NSMutableArray *resultArray) {
            //请求打印受理单
            [selfViewModel printAcceptWithOrderID:_orderModel.orderid success:^(NSMutableArray *resultArray) {
                //打印字符串
                [selfViewModel printStringWithInfoArray:selfViewModel.dataInfoArray success:^(NSMutableArray *resultArray) {
                    [selfVC.tableView.mj_header beginRefreshing];
                    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打印成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alView show];
                } fail:^(NSError *error) {
                    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打印失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alView show];
                }];
            } fail:^(NSError *error) {
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"受理单请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alView show];
            }];
        } fail:^(NSError *error) {
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"连接打印机失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }];
    }
}
//UISearchResultsUpdating Method
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [_searchArray removeAllObjects];
    //客户订单
    for (TTCOrderRecordViewControllerOutputOrderModel *orderModel in _vcViewModel.dataOrderArray) {
        NSRange rang = [orderModel.serialno rangeOfString:searchController.searchBar.text];
        if (rang.location != NSNotFound) {
            [_searchArray addObject:orderModel];
        }
    }
    [_tableView reloadData];
}
//UISearchBarDelegate Method
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    // 修改UISearchBar右侧的取消按钮
    for (UIView *searchbuttons in [searchBar subviews]){
        for (UIView *a in searchbuttons.subviews) {
            if ([a isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                UIButton *cancelButton = (UIButton*)a;
                // 修改文字颜色
                [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
}
#pragma mark - Other methods
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
@end
