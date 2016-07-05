//
//  TTCUserNewAccountSearchResultController.m
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCUserNewAccountSearchResultController.h"
#import "TTCUserNewAccoutResultSearchViewCell.h"
#import "TTCNavigationController.h"
//viewModel
#import "TTCUserNewAccoutResultSearchViewModel.h"
//model
#import "TTCUserNewAccountResultSearchOutputModel.h"
@interface TTCUserNewAccountSearchResultController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) int page;
@property (assign, nonatomic) int arrayCount;
@property (assign, nonatomic) BOOL isMonth;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataOrderArray;
@property (strong, nonatomic) TTCUserNewAccoutResultSearchViewModel *viewModel;

@end

@implementation TTCUserNewAccountSearchResultController
- (NSMutableArray*)dataOrderArray{
    if (!_dataOrderArray) {
        _dataOrderArray = [NSMutableArray array];
    }
    return _dataOrderArray;
}
- (void)initData{
    //resultViewModel
    _viewModel = [[TTCUserNewAccoutResultSearchViewModel alloc] init];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
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
    [_tableView registerClass:[TTCUserNewAccoutResultSearchViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHeaderData];
    }];
    [_tableView.mj_header beginRefreshing];
    
    //上拉刷新
//    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self getFooterData];
//    }];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_SELLDETAIL+10);//NAV_HEIGHT_USERLOCATE NAV_HEIGHT_SELLDETAIL
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-STA_HEIGHT);
    }];
}
- (void)setNavigationBar{
//    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
//    [nvc selectNavigationType:kSellCountType];
//    [nvc loadHeaderTitle:@"开户结果查询"];
//    [nvc loadWithMname:[SellManInfo sharedInstace].name mcode:[SellManInfo sharedInstace].loginname deptname:[SellManInfo sharedInstace].depName commission:[SellManInfo sharedInstace].commission];
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kUserDetailType];
    [nvc loadHeaderTitle:@"开户结果查询"];
    //加载数据
    CustomerInfo *customer = [CustomerInfo shareInstance];
    [nvc loadClientInformationWithCustid:customer.custid markno:customer.markno phone:customer.mobile addr:customer.addr name:customer.custname];
}
#pragma mark - Network request
//下拉刷新
- (void)getHeaderData{
    _page = 1;
    _arrayCount = 0;
    [_tableView.mj_footer resetNoMoreData];
    __block TTCUserNewAccountSearchResultController *selfVC = self;
    [_viewModel getUserOpenAccountResultSearchsuccess:^(NSMutableArray *resultArray) {
        selfVC.dataOrderArray = _viewModel.dataAccountResultArray;
        
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    }];
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
    TTCUserNewAccoutResultSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //加载信息
    if (_dataOrderArray.count > 0) {
        
        TTCUserAccountResultSearchMessageModel *messgeModel = _dataOrderArray[indexPath.row];
        [cell loadWithOrderID:messgeModel.orderid Opentime:messgeModel.optime Orderstatus:messgeModel.orderstatus Bossserialno:messgeModel.bossserialno failmemo:messgeModel.failmemo];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250/2;//240/2
}
//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

@end
