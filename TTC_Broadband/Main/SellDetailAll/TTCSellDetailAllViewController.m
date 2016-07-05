//
//  TTCSellDetailAllViewController.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/12/14.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailAllViewController.h"
#import "TTCNavigationController.h"
#import "TTCOrderRecordViewController.h"
//View
#import "TTCSellDetailAllViewCell.h"
//ViewModel
#import "TTCSellDetailMonthViewControllerViewModel.h"
#import "TTCSellDetailDayViewControllerViewModel.h"
#import "TTCSellCountViewControllerViewModel.h"
//Model
#import "TTCSellDetailMonthViewControllerModel.h"
#import "TTCSellDetailMonthViewControllerOdsModel.h"
@interface TTCSellDetailAllViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) int page;
@property (assign, nonatomic) int arrayCount;
@property (assign, nonatomic) BOOL isMonth;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataOrderArray;
@property (strong, nonatomic) TTCSellDetailMonthViewControllerViewModel *monthViewModel;
@property (strong, nonatomic) TTCSellDetailDayViewControllerViewModel *dayViewModel;
@property (strong, nonatomic) TTCSellCountViewControllerViewModel *countViewModel;
@end
@implementation TTCSellDetailAllViewController
#pragma mark - Init methods
- (void)initData{
    //monthViewModel
    _monthViewModel = [[TTCSellDetailMonthViewControllerViewModel alloc] init];
    //dayViewModel
    _dayViewModel = [[TTCSellDetailDayViewControllerViewModel alloc] init];
    //countViewModel
    _countViewModel = [[TTCSellCountViewControllerViewModel alloc] init];
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
    _isMonth = YES;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.hidden = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[TTCSellDetailAllViewCell class] forCellReuseIdentifier:@"cell"];
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
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_SELLDETAIL-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-STA_HEIGHT);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kSellDetailMonthType];
    [nvc hideMonthAndDaySell:NO];
    [nvc loadHeaderTitle:@"销售明细"];
}
#pragma mark - Event response
//接收通知
- (void)notificationRecieve{
    //本月销售
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"TTCSellDetailMonthBarDetail" object:nil];
    //今日销售
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"TTCSellDetailMonthBarChart" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"TTCSellDetailMonthBarDetail"]) {
        //本月销售
        _isMonth = YES;
        [_tableView.mj_header beginRefreshing];
    }else if ([notification.name isEqualToString:@"TTCSellDetailMonthBarChart"]){
        //今日销售
        _isMonth = NO;
        [_tableView.mj_header beginRefreshing];
    }
}
#pragma mark - Network request
//下拉刷新
- (void)getHeaderData{
    _page = 1;
    _arrayCount = 0;
    [_tableView.mj_footer resetNoMoreData];
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    __block TTCSellDetailAllViewController *selfVC = self;
    //更新销售统计
    [_countViewModel getSalesStatisticsSuccess:^(NSMutableArray *resultArray) {
        if (_isMonth) {
            [nvc loadMonthSellCount:[SellManInfo sharedInstace].mSales];
        }else{
            [nvc loadMonthSellCount:[SellManInfo sharedInstace].dSales];
        }
    } fail:^(NSError *error) {
    }];
    
    if (_isMonth) {
        __block TTCSellDetailMonthViewControllerViewModel *selfViewModel = _monthViewModel;
        //获取月销售
        [_monthViewModel getMyOrdersWithPage:[NSString stringWithFormat:@"%d",_page] success:^(NSMutableArray *resultArray) {
            //获取成功
            selfVC.dataOrderArray = selfViewModel.dataOrderArray;
            [selfVC.tableView.mj_header endRefreshing];
            [selfVC.tableView reloadData];
        } fail:^(NSError *error) {
            //获取失败
            [selfVC.tableView reloadData];
            [selfVC.tableView.mj_header endRefreshing];
        }];
    }else{
        //获取日销售
        __block TTCSellDetailDayViewControllerViewModel *selfViewModel = _dayViewModel;
        //获取月销售
        [_dayViewModel getMyOrdersWithPage:[NSString stringWithFormat:@"%d",_page] success:^(NSMutableArray *resultArray) {
            //获取成功
            selfVC.dataOrderArray = selfViewModel.dataOrderArray;
            [selfVC.tableView.mj_header endRefreshing];
            [selfVC.tableView reloadData];
        } fail:^(NSError *error) {
            //获取失败
            [selfVC.tableView reloadData];
            [selfVC.tableView.mj_header endRefreshing];
        }];
    }
}
//上拉刷新
- (void)getFooterData{
    _page ++;
    __block TTCSellDetailAllViewController *selfVC = self;
    if (_isMonth) {
        //获取月销售
        __block TTCSellDetailMonthViewControllerViewModel *selfViewModel = _monthViewModel;
        [_monthViewModel getMyOrdersWithPage:[NSString stringWithFormat:@"%d",_page] success:^(NSMutableArray *resultArray) {
            //获取成功
            [selfVC.tableView reloadData];
            //尾部判断是否全部数据请求完成
            if (selfVC.arrayCount != _monthViewModel.dataOrderArray.count) {
                _arrayCount = (int)selfViewModel.dataOrderArray.count;
                [selfVC.tableView.mj_footer endRefreshing];
            }else{
                [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        } fail:^(NSError *error) {
            //获取失败
            [selfVC.tableView reloadData];
            //尾部判断是否全部数据请求完成
            if (selfVC.arrayCount != _monthViewModel.dataOrderArray.count) {
                _arrayCount = (int)selfViewModel.dataOrderArray.count;
                [selfVC.tableView.mj_footer endRefreshing];
            }else{
                [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }];
    }else{
        //获取日销售
        __block TTCSellDetailDayViewControllerViewModel *selfViewModel = _dayViewModel;
        [_dayViewModel getMyOrdersWithPage:[NSString stringWithFormat:@"%d",_page] success:^(NSMutableArray *resultArray) {
            //获取成功
            [selfVC.tableView reloadData];
            //尾部判断是否全部数据请求完成
            if (selfVC.arrayCount != _dayViewModel.dataOrderArray.count) {
                _arrayCount = (int)selfViewModel.dataOrderArray.count;
                [selfVC.tableView.mj_footer endRefreshing];
            }else{
                [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        } fail:^(NSError *error) {
            //获取失败
            [selfVC.tableView reloadData];
            //尾部判断是否全部数据请求完成
            if (selfVC.arrayCount != _dayViewModel.dataOrderArray.count) {
                _arrayCount = (int)selfViewModel.dataOrderArray.count;
                [selfVC.tableView.mj_footer endRefreshing];
            }else{
                [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }];
        
    }
}
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataOrderArray.count > 0) {
        return _dataOrderArray.count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCSellDetailAllViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //加载信息
    if (_dataOrderArray.count > 0) {
        TTCSellDetailMonthViewControllerModel *orderModel = _dataOrderArray[indexPath.row];
//        TTCSellDetailMonthViewControllerOdsModel *odsModel = [orderModel.ods firstObject];
        [cell loadWithOrdertype:orderModel.ordertype factprice:[NSString stringWithFormat:@"%.02f",[orderModel.factprice floatValue]] adddate:orderModel.adddate uname:orderModel.uname numerical:orderModel.numerical];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240/2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataOrderArray.count > 0) {
        TTCOrderRecordViewController *orderRecordVC = [[TTCOrderRecordViewController alloc] init];
        orderRecordVC.isDetail = YES;
        orderRecordVC.canLeave = NO;
        orderRecordVC.dataModel = _dataOrderArray[indexPath.row];
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