//
//  TTCSellCountViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCSellCountViewController.h"
#import "TTCNavigationController.h"
#import "TTCSellDetailMonthViewController.h"
#import "TTCSellDetailDayViewController.h"
#import "TTCRankViewController.h"
//View
#import "TTCSellCountViewCell.h"
//ViewModel
#import "TTCSellCountViewControllerViewModel.h"
//Model
#import "TTCSellCountViewControllerSalesMonthModel.h"
#import "TTCSellCountViewControllerAnalysisModel.h"
#import "TTCSellCountViewControllerSalesBusinessModel.h"

@interface TTCSellCountViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) BOOL hideNum;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *lineCharArray;
//@property (strong, nonatomic) NSMutableArray *pieArray;
@property (strong, nonatomic) TTCSellCountViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) SellManInfo *sellManInfo;
@property (strong, nonatomic) Goal *goal;
//add
@property (strong, nonatomic) NSArray *businessArray;
@property (strong, nonatomic) NSArray *businessHideNumArray;
@property (strong, nonatomic) NSArray *pieArray;
@end
@implementation TTCSellCountViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCSellCountViewControllerViewModel alloc] init];
    //sellManInfo
    _sellManInfo = [SellManInfo sharedInstace];
    //本月目标
    _goal = [Goal sharedInstace];
    //隐藏数字
    _businessHideNumArray = @[@"***",@"***",@"***"];
    _pieArray = @[@"12",@"15",@"20"];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
    [self notificationRecieve];
    [self getData];
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
    __block TTCSellCountViewController *selfVC = self;
    _hideNum = NO;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = CLEAR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TTCSellCountViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfVC getData];
    }];
    [_tableView.mj_header beginRefreshing];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_SELLCOUNT-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kSellCountType];
    [nvc loadHeaderTitle:@"销售统计"];
    [nvc loadWithMname:_sellManInfo.name mcode:_sellManInfo.loginname deptname:_sellManInfo.depName commission:_sellManInfo.commission];
}
#pragma mark - Event response
//接收通知
- (void)notificationRecieve{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"本月销售额" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"今日销售额" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"月度排名" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"隐藏数字" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"设置本月目标" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"本月销售额"]) {
        TTCSellDetailMonthViewController *sellDetailMonthVC = [[TTCSellDetailMonthViewController alloc] init];
        [self.navigationController pushViewController:sellDetailMonthVC animated:YES];
    }else if ([notification.name isEqualToString:@"今日销售额"]) {
        TTCSellDetailDayViewController *sellDetailDayVC = [[TTCSellDetailDayViewController alloc] init];
        [self.navigationController pushViewController:sellDetailDayVC animated:YES];
    }else if ([notification.name isEqualToString:@"月度排名"]) {
        TTCRankViewController *rankVC = [[TTCRankViewController alloc] init];
        [self.navigationController pushViewController:rankVC animated:YES];
    }else if ([notification.name isEqualToString:@"隐藏数字"]) {
        _hideNum = !_hideNum;
        [_tableView reloadData];
    }else if([notification.name isEqualToString:@"设置本月目标"]){
        [_tableView.mj_header beginRefreshing];
    }
}
#pragma mark - Network request
//获取数据
- (void)getData{
    __block TTCSellCountViewController *selfVC = self;
    __block TTCSellCountViewControllerViewModel *selfViewModel = _vcViewModel;
    [_vcViewModel getSalesStatisticsSuccess:^(NSMutableArray *resultArray) {
        //获取成功
        //折线图
        //折线图数组
        _lineCharArray = [NSMutableArray array];
        for (TTCSellCountViewControllerSalesMonthModel *saleModel in selfViewModel.dataSaleMonthArray) {
            [_lineCharArray addObject:saleModel.money];
        }
        //饼状图数组
        //        _pieArray = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0,@0]];
        //        for (TTCSellCountViewControllerAnalysisModel *anModel in selfViewModel.dataAnalysisArray) {
        //            _pieArray[[anModel.ordertype intValue]] = anModel.money;
        //
        ////                        [_pieArray insertObject:anModel.money atIndex:[anModel.ordertype intValue]];
        //        }
        
        
        
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        //获取失败
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    }];
    //获取当前营业人员的本月目标
    [selfViewModel getMonthTargetSuccess:^(NSMutableArray *resultArray) {
        //获取成功
        selfVC.goal = [resultArray firstObject];
        [selfVC.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
    } fail:^(NSError *error) {
        //获取失败
        [selfVC.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    //获取销售类型数据统计
    [_vcViewModel getSalesBusinessStatisticsSuccess:^(NSMutableArray *resultArray) {
        TTCSellCountViewControllerSalesBusinessOutputModel *outputModel =(TTCSellCountViewControllerSalesBusinessOutputModel*)[selfViewModel.dataSaleBusinessArray firstObject];
        //把业务内容添加到数组
        _businessArray =[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",outputModel.figure?outputModel.figure:@"0"],[NSString stringWithFormat:@"%@",outputModel.interact?outputModel.interact:@"0"],[NSString stringWithFormat:@"%@",outputModel.broad?outputModel.broad:@"0"],nil];
        
        //饼状图数组
        _pieArray = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",outputModel.figure?outputModel.figure:@"0"],[NSString stringWithFormat:@"%@",outputModel.interact?outputModel.interact:@"0"],[NSString stringWithFormat:@"%@",outputModel.broad?outputModel.broad:@"0"],nil];
        
        
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        //获取失败
        [selfVC.tableView reloadData];
        [selfVC.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;//5
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCSellCountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:{
            //销售业务
            [cell selectCellType:kRoyaltyType];
            if (_businessArray.count>0){
                if (_hideNum) {
                    [cell loadBusinessStatisticsWithArray:_businessHideNumArray];;
                    
                }else {
                    [cell loadBusinessStatisticsWithArray:_businessArray];
                }
            }
        }
            break;
        case 1:{
            //顶部Cell
            [cell selectCellType:kTopViewType];
            if (_hideNum) {
                [cell loadWithMSales:@"****" dSales:@"****" ranking:@"****"];
                
            }else{
                [cell loadWithMSales:_sellManInfo.mSales dSales:_sellManInfo.dSales ranking:_sellManInfo.ranking];
            }
        }
            break;
        case 2:{
            //每月目标
            [cell selectCellType:kGoalViewType];
            float percent = 0;
            if (_goal.goal.length > 0) {
                percent = [_sellManInfo.mSales floatValue]/[_goal.goal floatValue];
                if (percent >= 1) {
                    percent = 1;
                }
            }
            [cell loadFinishPercentWithPercent:percent];
        }
            break;
        case 3:{
            //折线图
            [cell selectCellType:kLineChartViewType];
            if (_lineCharArray.count > 0) {
                [cell loadLineChartWithArray:_lineCharArray];
            }
        }
            break;
        case 4:{
            //饼状图
            [cell selectCellType:kRoundChartViewType];
            if (_pieArray.count > 0) {
                [cell loadPiePercentWithArray:_pieArray];
            }
        }
            break;
            
            
        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 264/2;
            break;
        case 1:
            return 264/2;
            break;
        case 2:
            return 530/2;
            break;
        case 3:
            return 682/2;
            break;
        case 4:
            return 700/2;//581/2;  660/2
            break;            
        default:
            return 100;
            break;
    }
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 26/2;
}
#pragma mark - Other methods
@end
