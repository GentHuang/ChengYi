//
//  TTCDepartmentViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "AppDelegate.h"
#import "TTCDepartmentViewController.h"
#import "TTCNavigationController.h"
#import "TTCDutyViewController.h"
//View
#import "TTCDepartmentViewCell.h"
//ViewModel
#import "TTCDepartmentViewControllerViewModel.h"
@interface TTCDepartmentViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchVC;
@property (strong, nonatomic) MBProgressHUD *progressHud;
@property (strong, nonatomic) TTCDepartmentViewControllerViewModel *vcViewModel;
@end
@implementation TTCDepartmentViewController
#pragma mark - Init methods
- (void)initData{
    _vcViewModel = [[TTCDepartmentViewControllerViewModel alloc] init];
    _searchNameArray = [NSMutableArray array];
    _searchIDArray = [NSMutableArray array];
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
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self setExtendedLayoutIncludesOpaqueBars:YES];
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive | UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCDepartmentViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
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
                //修改TextField
                UITextField *searchField = (UITextField *)a;
                searchField.borderStyle = UITextBorderStyleNone;
                searchField.layer.borderWidth = 0.5;
                searchField.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
                searchField.layer.masksToBounds = YES;
                searchField.layer.cornerRadius = 3;
            }
        }
    }
    _searchVC.searchBar.placeholder = @"输入部门筛选";
    _searchVC.searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    _searchVC.searchBar.layer.borderWidth = 0.5;
    _searchVC.searchBar.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
    _searchVC.searchBar.layer.masksToBounds = YES;
    _searchVC.searchBar.layer.cornerRadius = 0;
    _searchVC.searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    _tableView.tableHeaderView = _searchVC.searchBar;
    //等待界面
    _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    [_progressHud show:NO];
    _progressHud.hidden = YES;
    [self.view addSubview:_progressHud];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-STA_HEIGHT);
    }];
    //等待界面
    [_progressHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"首次登录请选择部门"];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchVC.active) {
        //返回搜索结果
        return _searchNameArray.count;
    }else{
        //返回未搜索结果
        if (_depinfoNameArray.count > 0) {
            return _depinfoNameArray.count;
        }else{
            return 0;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCDepartmentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_searchVC.active) {
        //返回搜索结果
        [cell loadTitleLabel:_searchNameArray[indexPath.row]];
    }else{
        //返回未搜索结果
        [cell loadTitleLabel:_depinfoNameArray[indexPath.row]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103/2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 28/2;
}
//UITableViewDelegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self startLoading];
    //加载营销人员登录信息
    NSString *depName = _depinfoNameArray[indexPath.row];
    NSString *depID = _depinfoIDArray[indexPath.row];
    if (_searchVC.active) {
        depName = _searchNameArray[indexPath.row];
        depID = _searchIDArray[indexPath.row];
    }
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    [sellManInfo loadDepInfoName:depName ID:depID];
    //获取销售统计
    [_vcViewModel getSalesStatisticsSuccess:^(NSMutableArray *resultArray) {
        //请求成功
        [self stopLoading];
        //发送登录成功通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"营销人员登录成功" object:self userInfo:nil];
        //营销人员信息存入数据库
        [[FMDBManager sharedInstace] creatTable:sellManInfo];
        [[FMDBManager sharedInstace] deleteModelAllInDatabase:sellManInfo];
        [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:sellManInfo withCheckNum:3];
        //获取手势密码信息
        [[FMDBManager sharedInstace] selectModelArrayInDatabase:[LockInfo class] withDic:@{@"name":[SellManInfo sharedInstace].loginname,@"psw":[SellManInfo sharedInstace].md5PSW} success:^(NSMutableArray *resultArray) {
            LockInfo *info = (LockInfo *)[resultArray firstObject];
            [LockInfo sharedInstace].name = info.name;
            [LockInfo sharedInstace].psw = info.psw;
            [LockInfo sharedInstace].numPSW = info.numPSW;
            [LockInfo sharedInstace].firstNum = info.firstNum;
            [LockInfo sharedInstace].gesturePSW = info.gesturePSW;
            [LockInfo sharedInstace].firstGesture = info.firstGesture;
            //add
            [LockInfo sharedInstace].isChangePSW = info.isChangePSW;
            [LockInfo sharedInstace].isChangeGesture = info.isChangeGesture;
        } fail:^(NSError *error) {
            [LockInfo sharedInstace].name = @"";
            [LockInfo sharedInstace].psw = @"";
            [LockInfo sharedInstace].numPSW = @"";
            [LockInfo sharedInstace].firstNum = @"";
            [LockInfo sharedInstace].gesturePSW = @"";
            [LockInfo sharedInstace].firstGesture = @"";
            [LockInfo sharedInstace].isChangePSW = @"";
            [LockInfo sharedInstace].isChangeGesture = @"";
        }];
        //新登录的关闭手势
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setValue:[NSNumber numberWithBool:NO] forKey:@"数字密码"];
        [userDefault setValue:[NSNumber numberWithBool:NO] forKey:@"手势密码"];
        [userDefault synchronize];
        //登录
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = appDelegate.tabbarVC;
        if (_searchVC.active) {
            [_searchVC dismissViewControllerAnimated:NO completion:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        //请求失败
        [self stopLoading];
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"获取销售人员信息有误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }];
}
//UISearchResultsUpdating Method
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSPredicate *p = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchController.searchBar.text];
    _searchNameArray = [NSMutableArray arrayWithArray:[self.depinfoNameArray filteredArrayUsingPredicate:p]];
    for (int i = 0; i < _searchNameArray.count; i ++) {
        for (int j = 0; j < _depinfoNameArray.count; j ++) {
            if ([_searchNameArray[i] isEqualToString:_depinfoNameArray[j]]) {
                [_searchIDArray addObject:_depinfoIDArray[j]];
                break;
            }
        }
    }
    [_tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    // 修改UISearchBar右侧的取消按钮
    for (UIView *searchbuttons in [searchBar subviews]){
        for (UIView *a in searchbuttons.subviews) {
            if ([a isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                UIButton *cancelButton = (UIButton*)a;
                // 修改文字颜色
                [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
}
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Other methods
//开始加载
- (void)startLoading{
    _progressHud.hidden = NO;
    [_progressHud show:YES];
}
//停止加载
- (void)stopLoading{
    _progressHud.hidden = YES;
    [_progressHud show:NO];
}

@end
