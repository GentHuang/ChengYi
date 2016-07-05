//
//  TTCDebtViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCDebtViewController.h"
#import "TTCNavigationController.h"
#import "TTCPayViewController.h"
#import "TTCRechargeViewController.h"
//View
#import "TTCDebtViewCell.h"
//ViewModel
#import "TTCDebtViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerArrearOutputModel.h"
#import "TTCUserLocateViewControllerArrearOutputArreardetsModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
//CellStatus
#import "TTCDebtViewCellStatus.h"
//Macro
#define kSmallHeight (82/2)
@interface TTCDebtViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate>
@property (assign, nonatomic) int arrayCount;
@property (assign, nonatomic) float selectedCount;
@property (strong, nonatomic) NSMutableArray *transServsArray;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchVC;
@property (strong, nonatomic) NSMutableArray *searchArray;
@property (strong, nonatomic) NSMutableArray *cellStatusArray;
@property (strong, nonatomic) TTCDebtViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) CustomerInfo *customer;
@property (strong, nonatomic) NSArray *debtNameArray;
@property (strong, nonatomic) NSArray *debtPriceArray;
@property (strong, nonatomic) NSArray *debtHideArray;
@property (strong, nonatomic) NSArray *debtButtonArray;
@end
@implementation TTCDebtViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCDebtViewControllerViewModel alloc] init];
    //客户信息
    _customer = [CustomerInfo shareInstance];
    //搜索数组
    _searchArray = [NSMutableArray array];
    //现金账本余额 增值账本余额 欠费总额
    _debtNameArray = [NSArray arrayWithObjects:@"现金账本余额：",@"增值账本余额：",@"欠费总额：",nil];
    //现金账本 增值账本 未开发票
    _debtPriceArray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:0],nil];
    //隐藏 隐藏 显示已选欠费
    _debtHideArray = [NSArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO],nil];
    //充值 充值 缴欠费
    _debtButtonArray = [NSArray arrayWithObjects:@"充值",@"充值",@"缴欠费",nil];
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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchVC dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCDebtViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    __block int page = 1;
    //下拉刷新动画
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHeaderData];
    }];
    [_tableView.mj_header beginRefreshing];
    //上拉刷新动画
    [_tableView.mj_footer beginRefreshing];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getFooterDataWithPage:(++page)];
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
    _searchVC.searchBar.placeholder = @"搜索用户";
    _searchVC.searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    _searchVC.searchBar.layer.borderWidth = 0.5;
    _searchVC.searchBar.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
    _searchVC.searchBar.layer.masksToBounds = YES;
    _searchVC.searchBar.layer.cornerRadius = 0;
    _searchVC.searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    _tableView.tableHeaderView = _searchVC.searchBar;
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc loadHeaderTitle:@"充值缴费"];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(NSInteger)section row:(NSInteger)row{
    if (!_tableView.mj_header.isRefreshing) {
        if (section > 0) {
            //欠费明细
            //判断是否选择
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            TTCDebtViewCellStatus *cellStatus = _cellStatusArray[section-1];
            TTCDebtViewCell *cell = (TTCDebtViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
            [cell isPackUp:cellStatus.isPackUp];
            cellStatus.isPackUp = !cellStatus.isPackUp;
            //刷新Cell
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            //充值和缴欠费
            if (row == 2) {
                //缴欠费
                if (_transServsArray.count <= 0) {
                    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择缴费的用户" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alView show];
                }else{
                    if([[CustomerInfo shareInstance].stoptype isEqualToString:@"管理停"] || [[CustomerInfo shareInstance].stoptype isEqualToString:@"管理联停"]){
                        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@请到柜台开机",[CustomerInfo shareInstance].stoptype] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alView show];
                    }else{
                        //缴欠费
                        TTCPayViewController *payVC = [[TTCPayViewController alloc] init];
                        payVC.selectedCount = self.selectedCount;
                        if(_searchVC.active){
                            payVC.allServsArray = _searchArray;
                        }else{
                            payVC.allServsArray = _transServsArray;
                        }
                        payVC.isDebtPay = YES;
                        [self.navigationController  pushViewController:payVC animated:YES];
                    }
                }
            }else{
                //充值
                TTCRechargeViewController *rechargeVC = [[TTCRechargeViewController alloc] init];
                if (row == 0) {
                    //现金账本充值
                    rechargeVC.fbid = @"0";
                    rechargeVC.rechargeName = @"现金账本充值";
                }else if(row == 1){
                    //增值账本充值
                    rechargeVC.fbid = @"200";
                    rechargeVC.rechargeName = @"增值账本充值";
                }
                [self.navigationController pushViewController:rechargeVC animated:YES];
            }
        }
    }
}
#pragma mark - Network request
//获取数据
- (void)getHeaderData{
    _arrayCount = 0;
    int page = 1;
    _selectedCount = 0;
    [_tableView.mj_footer resetNoMoreData];
    __block TTCDebtViewController *selfVC = self;
    __block TTCDebtViewControllerViewModel *selfViewModel = _vcViewModel;
    __block BOOL isDebt = NO;
    __block BOOL isBalance = NO;
    //获取欠费信息成功
    _vcViewModel.arrearSuccessBlock = ^(NSMutableArray *dataArray){
        //请求成功
        //用以传送的用户数组
        _transServsArray = [NSMutableArray arrayWithArray:selfViewModel.dataOutputArray];
        //Cell状态
        selfVC.cellStatusArray = [NSMutableArray array];
        for (int i = 0; i < _vcViewModel.dataOutputArray.count; i ++) {
            TTCDebtViewCellStatus *cellStatus = [[TTCDebtViewCellStatus alloc] init];
            //Cell展开状态
            cellStatus.isPackUp = NO;
            //Cell选择状态
            cellStatus.isSelected = YES;
            //存储Cell状态
            [selfVC.cellStatusArray addObject:cellStatus];
            //计算选择的总价
            NSArray *arrearArray = [selfViewModel getServsArrearsListWithIndex:i];
            NSMutableArray *permarkArray = [NSMutableArray array];
            for (TTCUserLocateViewControllerArrearOutputArreardetsModel *arrearModel in arrearArray) {
                [permarkArray addObject:arrearModel.permark];
                selfVC.selectedCount += [arrearModel.fees floatValue];
            }
        }
        isDebt = YES;
        if (isDebt && isBalance) {
            //更新
            [selfVC.tableView reloadData];
            [selfVC.tableView.mj_header endRefreshing];
            [selfVC updateSearchResultsForSearchController:selfVC.searchVC];
        }
    };
    //余额获取成功
    selfViewModel.balanceSuccessBlock = ^(NSMutableArray *dataArray){
        isBalance = YES;
        if (isDebt && isBalance) {
            //更新
            [selfVC.tableView reloadData];
            [selfVC.tableView.mj_header endRefreshing];
            [selfVC updateSearchResultsForSearchController:selfVC.searchVC];
        }
    };
    //获取欠费信息
    [_vcViewModel getArrearsListWithServsArray:_allServsArray withPage:page];
    //获取余额信息
    [_vcViewModel getBalanceInfo];
}
//上拉获取数据
- (void)getFooterDataWithPage:(int)page{
    _selectedCount = 0;
    __block TTCDebtViewController *selfVC = self;
    __block TTCDebtViewControllerViewModel *selfViewModel = _vcViewModel;
    _vcViewModel.arrearSuccessBlock = ^(NSMutableArray *dataArray){
        //请求成功
        //用以传送的用户数组
        _transServsArray = [NSMutableArray arrayWithArray:selfViewModel.dataOutputArray];
        //Cell状态
        selfVC.cellStatusArray = [NSMutableArray array];
        for (int i = 0; i < _vcViewModel.dataOutputArray.count; i ++) {
            TTCDebtViewCellStatus *cellStatus = [[TTCDebtViewCellStatus alloc] init];
            //Cell展开状态
            cellStatus.isPackUp = NO;
            //Cell选择状态
            cellStatus.isSelected = YES;
            //存储Cell状态
            [selfVC.cellStatusArray addObject:cellStatus];
            //计算选择的总价
            NSArray *arrearArray = [selfViewModel getServsArrearsListWithIndex:i];
            NSMutableArray *permarkArray = [NSMutableArray array];
            for (TTCUserLocateViewControllerArrearOutputArreardetsModel *arrearModel in arrearArray) {
                [permarkArray addObject:arrearModel.permark];
                selfVC.selectedCount += [arrearModel.fees intValue];
            }
        }
        //尾部判断是否全部数据请求完成
        if (selfVC.arrayCount != _vcViewModel.dataArrearArray.count) {
            _arrayCount = (int)selfViewModel.dataArrearArray.count;
            [selfVC.tableView.mj_footer endRefreshing];
        }else{
            [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        //更新
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
        [selfVC updateSearchResultsForSearchController:selfVC.searchVC];
    };
    [_vcViewModel getArrearsListWithServsArray:_allServsArray withPage:page];
}
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_searchVC.active) {
        return (1+_searchArray.count);
    }else{
        if (_vcViewModel.dataOutputArray.count > 0) {
            return (1+_vcViewModel.dataOutputArray.count);
        }else{
            return 1;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCDebtViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.buttonBlock = ^(NSInteger sectioni,NSInteger row){
        [self buttonPressed:indexPath.section row:indexPath.row];
    };
    if (indexPath.section == 0) {
        //总额
        [cell selectCellType:kAccountType];
        [cell loadPriceNameWithPriceName:_debtNameArray[indexPath.row] hide:[_debtHideArray[indexPath.row] boolValue] buttonTitle:_debtButtonArray[indexPath.row]];
        if (indexPath.row == 2) {
            //欠费总额
            [cell loadPrice:[NSString stringWithFormat:@"%.02f",_customer.arrearsun]];
            [cell loadTotalPrice:[NSString stringWithFormat:@"%.02f",self.selectedCount]];
        }else if(indexPath.row == 1){
            //增值余额
            [cell loadPrice:[NSString stringWithFormat:@"%.02f",_customer.incrementsums]];
        }else if(indexPath.row == 0){
            //现金余额
            [cell loadPrice:[NSString stringWithFormat:@"%.02f",_customer.cashsums]];
        }
    }else{
        //套餐详情
        [cell selectCellType:kSetDetailType];
        //判断是否是搜索界面
        TTCUserLocateViewControllerArrearOutputModel *outputModel;
        if (_searchVC.active) {
            if (_searchArray.count > 0) {
                outputModel = _searchArray[indexPath.section - 1];
            }
        }else{
            if (_vcViewModel.dataOutputArray.count > 0) {
                outputModel = _vcViewModel.dataOutputArray[indexPath.section - 1];
            }
        }
        //加载头部信息
        [cell loadUserID:outputModel.keyno arrearsun:outputModel.arrearsun];
        //加载欠费详情
        [cell loadDetailSetWithArray:[_vcViewModel getServsArrearsListWithIndex:(int)(indexPath.section - 1)]];
        //记录选择状态
        TTCDebtViewCellStatus *cellStatus = _cellStatusArray[indexPath.section-1];
        [cell isPackUp:cellStatus.isPackUp];
        [cell isSelected:cellStatus.isSelected];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 112/2;
    }else{
        if (_vcViewModel.dataOutputArray.count > 0) {
            //改变高度
            TTCDebtViewCellStatus *cellStatus = _cellStatusArray[indexPath.section-1];
            if (cellStatus.isPackUp) {
                return (133/2 + (int)[_vcViewModel getServsArrearsListWithIndex:(int)(indexPath.section - 1)].count*kSmallHeight);
            }else{
                return 133/2;
            }
        }else{
            return 133/2;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0) {
        if (!_tableView.mj_header.isRefreshing) {
            _transServsArray = [NSMutableArray arrayWithArray:_vcViewModel.dataOutputArray];
            //判断是否选择
            TTCDebtViewCellStatus *cellStatus = _cellStatusArray[indexPath.section-1];
            TTCDebtViewCell *cell = (TTCDebtViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell isSelected:cellStatus.isSelected];
            cellStatus.isSelected = !cellStatus.isSelected;
            //刷新Cell
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            //更改已选欠费
            TTCUserLocateViewControllerArrearOutputModel *outputModel = _vcViewModel.dataOutputArray[indexPath.section -1];
            if (cellStatus.isSelected) {
                //增加
                _selectedCount += [outputModel.arrearsun intValue];
                if ([_transServsArray indexOfObject:outputModel] == NSNotFound) {
                    [_transServsArray addObject:outputModel];
                }
            }else{
                //减少
                _selectedCount -= [outputModel.arrearsun intValue];
                if ([_transServsArray indexOfObject:outputModel] == NSNotFound) {
                    [_transServsArray removeObject:outputModel];
                }
            }
            //更新金额
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 12;
    }else{
        return 0.0001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
//UISearchResultsUpdating Method
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [_searchArray removeAllObjects];
    for (TTCUserLocateViewControllerArrearOutputModel *outputModel in _vcViewModel.dataOutputArray) {
        NSRange rang = [outputModel.keyno rangeOfString:searchController.searchBar.text];
        if (rang.location != NSNotFound) {
            [_searchArray addObject:outputModel];
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
        searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
}

#pragma mark - Other methods
@end
