//
//  TTCSellDetailDayViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCSellDetailDayViewController.h"
#import "TTCNavigationController.h"
#import "TTCOrderRecordViewController.h"
//View
#import "TTCSellDetailDayViewCell.h"
#import "TTCSellDetailDayChartView.h"
//ViewModel
#import "TTCSellDetailDayViewControllerViewModel.h"
//Model
#import "TTCSellDetailDayViewControllerModel.h"
#import "TTCSellDetailDayViewControllerOdsModel.h"
@interface TTCSellDetailDayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) int page;
@property (assign, nonatomic) int arrayCount;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TTCSellDetailDayChartView *chartView;
@property (strong, nonatomic) TTCSellDetailDayViewControllerViewModel *vcViewModel;
@end
@implementation TTCSellDetailDayViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCSellDetailDayViewControllerViewModel alloc] init];
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
    [_tableView registerClass:[TTCSellDetailDayViewCell class] forCellReuseIdentifier:@"cell"];
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
    _chartView = [[TTCSellDetailDayChartView alloc] init];
    _chartView.hidden = YES;
    [self.view addSubview:_chartView];
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
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kSellDetailDayType];
    [nvc loadHeaderTitle:@"销售明细"];
    [nvc loadDaySellCount:[SellManInfo sharedInstace].dSales];
}
#pragma mark - Event response
//接收通知
- (void)notificationRecieve{
    //明细
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"TTCSellDetailDayBarDetail" object:nil];
    //报表
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"TTCSellDetailDayBarChart" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"TTCSellDetailDayBarDetail"]) {
        //明细
        _tableView.hidden = NO;
        _chartView.hidden = YES;
    }else if ([notification.name isEqualToString:@"TTCSellDetailDayBarChart"]){
        //报表
        _tableView.hidden = YES;
        _chartView.hidden = NO;
        //加载圆形图的百分比(模拟,数字，宽带，互动，智能)
        if (_vcViewModel.dataChartArray.count > 0) {
            [self.chartView loadPiePercentWithArray:_vcViewModel.dataChartArray];
        }
    }
}
#pragma mark - Network request
//下拉刷新
- (void)getHeaderData{
    _page = 1;
    _arrayCount = 0;
    [_tableView.mj_footer resetNoMoreData];
    __block TTCSellDetailDayViewController *selfVC = self;
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
    __block TTCSellDetailDayViewController *selfVC = self;
    __block TTCSellDetailDayViewControllerViewModel *selfViewModel = _vcViewModel;
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
    TTCSellDetailDayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //加载信息
    if (_vcViewModel.dataOrderArray.count > 0) {
        TTCSellDetailDayViewControllerModel *orderModel = _vcViewModel.dataOrderArray[indexPath.row];
//        TTCSellDetailDayViewControllerOdsModel *odsModel = [orderModel.ods firstObject];
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
@end
