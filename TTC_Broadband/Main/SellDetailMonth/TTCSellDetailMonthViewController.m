//
//  TTCSellDetailMonthViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCSellDetailMonthViewController.h"
#import "TTCNavigationController.h"
#import "TTCOrderRecordViewController.h"
//View
#import "TTCSellDetailMonthViewCell.h"
#import "TTCSellDetailMonthChartView.h"
#import "TTCSellDetailMonthPickView.h"
//ViewModel
#import "TTCSellDetailMonthViewControllerViewModel.h"
//Model
#import "TTCSellDetailMonthViewControllerModel.h"
#import "TTCSellDetailMonthViewControllerOdsModel.h"
@interface TTCSellDetailMonthViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) int page;
@property (assign, nonatomic) int arrayCount;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TTCSellDetailMonthChartView *chartView;
@property (strong, nonatomic) TTCSellDetailMonthPickView *pickView;
@property (strong, nonatomic) TTCSellDetailMonthViewControllerViewModel *vcViewModel;
@end
@implementation TTCSellDetailMonthViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCSellDetailMonthViewControllerViewModel alloc] init];
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
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    //明细
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.hidden = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[TTCSellDetailMonthViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHeaderData];
    }];
    [_tableView.mj_header beginRefreshing];
    //上拉刷新
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getFooterData];
    }];
    //报表
    //chartView
    _chartView = [[TTCSellDetailMonthChartView alloc] init];
    _chartView.hidden = YES;
    [self.view addSubview:_chartView];
    //选择月份
    _pickView = [[TTCSellDetailMonthPickView alloc] init];
    _pickView.hidden = YES;
    _pickView.alpha = 0;
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    [_pickView addGestureRecognizer:tap];
    [self.view addSubview:_pickView];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_SELLDETAIL-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-STA_HEIGHT);
    }];
    //报表
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_SELLDETAIL);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(730/2);
    }];
    //选择月份
    [_pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_SELLDETAIL);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-STA_HEIGHT);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kSellDetailMonthType];
    [nvc hideMonthAndDaySell:YES];
    [nvc loadHeaderTitle:@"销售明细"];
    [nvc loadMonthSellCount:[SellManInfo sharedInstace].mSales];
}
#pragma mark - Event response
//接收通知
- (void)notificationRecieve{
    //明细
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"TTCSellDetailMonthBarDetail" object:nil];
    //报表
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"TTCSellDetailMonthBarChart" object:nil];
    //选择月份
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"选择月份" object:nil];
    
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"TTCSellDetailMonthBarDetail"]) {
        //明细
        _tableView.hidden = NO;
        _chartView.hidden = YES;
    }else if ([notification.name isEqualToString:@"TTCSellDetailMonthBarChart"]){
        //报表
        _tableView.hidden = YES;
        _chartView.hidden = NO;
        //加载圆形图的百分比(模拟,数字，宽带，互动，智能)
        if (_vcViewModel.dataChartArray.count > 0) {
            [self.chartView loadPiePercentWithArray:_vcViewModel.dataChartArray];
        }
    }else if ([notification.name isEqualToString:@"选择月份"]){
        //选择月份
        if (_pickView.isPackUp) {
            [self showPickView];
        }else{
            [self packUpPickView];
        }
    }
}
//点击
- (void)tapPressed:(UITapGestureRecognizer *)tap{
    [self packUpPickView];
}
#pragma mark - Network request
//下拉刷新
- (void)getHeaderData{
    _page = 1;
    _arrayCount = 0;
    [_tableView.mj_footer resetNoMoreData];
    __block TTCSellDetailMonthViewController *selfVC = self;
    [_vcViewModel getMyOrdersWithPage:[NSString stringWithFormat:@"%d",_page] success:^(NSMutableArray *resultArray) {
        //获取成功
        [selfVC.tableView.mj_header endRefreshing];
        [selfVC.tableView reloadData];
    } fail:^(NSError *error) {
        //获取失败
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    }];
}
//上拉刷新
- (void)getFooterData{
    _page ++;
    __block TTCSellDetailMonthViewController *selfVC = self;
    __block TTCSellDetailMonthViewControllerViewModel *selfViewModel = _vcViewModel;
    [_vcViewModel getMyOrdersWithPage:[NSString stringWithFormat:@"%d",_page] success:^(NSMutableArray *resultArray) {
        //获取成功
        [selfVC.tableView reloadData];
        //尾部判断是否全部数据请求完成
        if (selfVC.arrayCount != _vcViewModel.dataOrderArray.count) {
            _arrayCount = (int)selfViewModel.dataOrderArray.count;
            [selfVC.tableView.mj_footer endRefreshing];
        }else{
            [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
        }
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
    }];
}
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_vcViewModel.dataOrderArray.count > 0) {
        return _vcViewModel.dataOrderArray.count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCSellDetailMonthViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //加载信息
    if (_vcViewModel.dataOrderArray.count > 0) {
        TTCSellDetailMonthViewControllerModel *orderModel = _vcViewModel.dataOrderArray[indexPath.row];
//        TTCSellDetailMonthViewControllerOdsModel *odsModel = [orderModel.ods firstObject];
        [cell loadWithOrdertype:orderModel.ordertype factprice:[NSString stringWithFormat:@"%.02f",[orderModel.factprice floatValue]] adddate:orderModel.adddate uname:orderModel.uname numerical:orderModel.numerical];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240/2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_vcViewModel.dataOrderArray.count > 0) {
        TTCOrderRecordViewController *orderRecordVC = [[TTCOrderRecordViewController alloc] init];
        orderRecordVC.isDetail = YES;
        orderRecordVC.canLeave = NO;
        orderRecordVC.dataModel = _vcViewModel.dataOrderArray[indexPath.row];
        [self.navigationController pushViewController:orderRecordVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
#pragma mark - Other methods
//显示选择器
- (void)showPickView{
    _pickView.hidden = NO;
    _pickView.isPackUp = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _pickView.alpha = 1;
    } completion:^(BOOL finished) {
        [_pickView showPickerView];
    }];
}
//收起选择器
- (void)packUpPickView{
    _pickView.isPackUp = YES;
    [_pickView packUpPickerView];
    [self performSelector:@selector(fadeOutPickView) withObject:self afterDelay:0.25];
}
//背景消散
- (void)fadeOutPickView{
    [UIView animateWithDuration:0.25 animations:^{
        _pickView.alpha = 0;
    } completion:^(BOOL finished) {
        _pickView.hidden = YES;
    }];
}


@end
