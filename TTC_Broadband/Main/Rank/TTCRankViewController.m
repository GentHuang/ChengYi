//
//  TTCRankViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCRankViewController.h"
#import "TTCNavigationController.h"
//View
#import "TTCRankViewCell.h"
#import "TTCRandHeadView.h"
//ViewModel
#import "TTCRankViewControllerViewModel.h"
//Model
#import "TTCRankViewControllerArrayModel.h"
@interface TTCRankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *rankImageViewArray;
@property (strong, nonatomic) NSArray *colorArray;
@property (assign, nonatomic) CGFloat maxCount;
@property (strong, nonatomic) TTCRankViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCRandHeadView *headView;

@end
@implementation TTCRankViewController
#pragma mark - Init methods
- (void)initData{
    _rankImageViewArray = @[[UIImage imageNamed:@"rank_img_1"],[UIImage imageNamed:@"rank_img_2"],[UIImage imageNamed:@"rank_img_3"]];
    _colorArray = @[[UIColor colorWithRed:255/256.0 green:180/256.0 blue:0/256.0 alpha:1],[UIColor colorWithRed:255/256.0 green:102/256.0 blue:0/256.0 alpha:1],[UIColor colorWithRed:71/256.0 green:168/256.0 blue:239/256.0 alpha:1],[UIColor colorWithRed:255/256.0 green:180/256.0 blue:0/256.0 alpha:1],[UIColor colorWithRed:255/256.0 green:180/256.0 blue:0/256.0 alpha:1]];
    //vcViewModel
    _vcViewModel = [[TTCRankViewControllerViewModel alloc] init];
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
    __block TTCRankViewController *selfVC = self;
    //头部视图
    _headView = [[TTCRandHeadView alloc]init];
    [self.view addSubview:_headView];
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.hidden = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TTCRankViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfVC getData];
    }];
}
- (void)setSubViewLayout{
    //头部视图
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL-20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(620/2);
    }];
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(NAV_HEIGHT_PRODEL-20);
        make.top.equalTo(_headView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-STA_HEIGHT);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"排行榜"];
}
#pragma mark - Event response
//获取排行榜数据
- (void)getData{
    _maxCount = 0;
    __block TTCRankViewControllerViewModel *selfViewModel = _vcViewModel;
    __block TTCRankViewController *selfVC = self;
    [_vcViewModel getSalesRankingSuccess:^(NSMutableArray *resultArray) {
        //请求成功
        //按从小到大排序
        NSMutableArray *dataArray = [NSMutableArray arrayWithArray:selfViewModel.dataRankArray];
        for (int i = 0; i < selfViewModel.dataRankArray.count; i ++) {
            for (int j = i; j < selfViewModel.dataRankArray.count; j ++) {
                TTCRankViewControllerArrayModel *iModel = selfViewModel.dataRankArray[i];
                TTCRankViewControllerArrayModel *jModel = selfViewModel.dataRankArray[j];
                if ([iModel.salesamount floatValue] <= [jModel.salesamount floatValue]) {
                    [dataArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
        selfViewModel.dataRankArray = dataArray;
        TTCRankViewControllerArrayModel *maxModel = [selfViewModel.dataRankArray firstObject];
        _maxCount = [maxModel.salesamount floatValue];
        //刷新
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        //请求失败
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_vcViewModel.dataRankArray.count > 0) {
        return _vcViewModel.dataRankArray.count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row <= 2) {
        [cell selectCellType:kImageType];
        [cell loadImageView:_rankImageViewArray[indexPath.row]];
    }else{
        [cell selectCellType:kNumType];
        [cell loadRankLabel:(int)(indexPath.row+1)];
    }
    TTCRankViewControllerArrayModel *arrayModel = _vcViewModel.dataRankArray[indexPath.row];
    //载入数据
    NSArray *dataArray = [NSArray arrayWithObjects:arrayModel.mname,arrayModel.deptname,[NSString stringWithFormat:@"￥%@",arrayModel.salesamount],nil];
    [cell loadInformation:dataArray];
    //显示排名前四的名次
    if (indexPath.row<4) {
        [cell showRankNumerText:indexPath.row];
    }
    //载入营业额
    [cell loadProgressViewColor:_colorArray[indexPath.row] Progress:([arrayModel.salesamount floatValue]/_maxCount)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 208/2;
}
//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

#pragma mark - Other methods
@end
