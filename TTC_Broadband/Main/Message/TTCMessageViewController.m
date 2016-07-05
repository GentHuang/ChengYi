//
//  TTCMessageViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCMessageViewController.h"
#import "TTCNavigationController.h"
#import "TTCMessageDetailViewController.h"
//View
#import "TTCMessageViewCell.h"
//ViewModel
#import "TTCMessageViewControllerViewModel.h"
//Model
#import "TTCMessageViewControllerRowsModel.h"
@interface TTCMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) int arrayCount;
@property (assign, nonatomic) int page;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TTCMessageViewControllerViewModel *vcViewModel;
@end

@implementation TTCMessageViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCMessageViewControllerViewModel alloc] init];
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
    [_tableView.mj_header beginRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    __block TTCMessageViewController *selfVC = self;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TTCMessageViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfVC getHeaderData];
    }];
    //上拉刷新
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [selfVC getFooterData];
    }];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);//-TAB_HEIGHT
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"消息"];
}
#pragma mark - Event response
//下拉刷新
- (void)getHeaderData{
    _page = 1;
    _arrayCount = 0;
    [_tableView.mj_footer resetNoMoreData];
    __block TTCMessageViewController *selfVC = self;
    [_vcViewModel getAllMessageWithPage:_page success:^(NSMutableArray *resultArray) {
        //获取成功
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        //获取失败
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    }];
}
//上拉刷新
- (void)getFooterData{
    _page ++;
    __block TTCMessageViewController *selfVC = self;
    __block TTCMessageViewControllerViewModel *selfViewModel = _vcViewModel;
    [_vcViewModel getAllMessageWithPage:_page success:^(NSMutableArray *resultArray) {
        //获取成功
        [selfVC.tableView reloadData];
        //尾部判断是否全部数据请求完成
        if (selfVC.arrayCount != _vcViewModel.dataRowsArray.count) {
            _arrayCount = (int)selfViewModel.dataRowsArray.count;
            [selfVC.tableView.mj_footer endRefreshing];
        }else{
            [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } fail:^(NSError *error) {
        //获取失败
        [selfVC.tableView reloadData];
        //尾部判断是否全部数据请求完成
        if (selfVC.arrayCount != _vcViewModel.dataRowsArray.count) {
            _arrayCount = (int)selfViewModel.dataRowsArray.count;
            [selfVC.tableView.mj_footer endRefreshing];
        }else{
            [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_vcViewModel.dataRowsArray.count > 0) {
        return _vcViewModel.dataRowsArray.count;
    }else{
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //加载图片
//    if (indexPath.row%2==0) {
        [cell loadImage:[UIImage imageNamed:@"msg_img1"]];
//    }else{
//        [cell loadImage:[UIImage imageNamed:@"msg_img2"]];
//    }
    //加载信息
    if (_vcViewModel.dataRowsArray.count > 0) {
        TTCMessageViewControllerRowsModel *rowsModel = _vcViewModel.dataRowsArray[indexPath.row];
        [cell loadTitleWithTitle:rowsModel.title content:rowsModel.digest];
        [cell isUnread:rowsModel.isread];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 154/2;
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 25/2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCMessageDetailViewController *detailVC = [[TTCMessageDetailViewController alloc] init];
    TTCMessageViewControllerRowsModel *rowsModel = _vcViewModel.dataRowsArray[indexPath.row];
    detailVC.mid = rowsModel.id_conflict;
    detailVC.titleString = rowsModel.title;
    detailVC.content = rowsModel.content;
    detailVC.aboutitemid = rowsModel.aboutitemid;
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - Other methods
@end
