//
//  TTCAddCustAddrViewController.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCAddCustAddrViewController.h"
#import "TTCNavigationController.h"
//View
#import "TTCAddCustAddrViewControllerCell.h"
#import "TTCAddCustAddrViewControllerCellTopViewDragView.h"
//ViewModel
#import "TTCAddCustAddrViewViewModel.h"
//Model
#import "TTCAddAddressViewControllerOutputHouseModel.h"
#import "TTCNewCustomViewControllerDictionaryModel.h"

#import "TTCAddCustAddrViewControllerCellTopViewMenuView.h"
@interface TTCAddCustAddrViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (assign, nonatomic) int curPage;
@property (assign, nonatomic) int curCount;
@property (strong, nonatomic) NSString *areaIDString;
@property (strong, nonatomic) NSString *areaNameString;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) TTCAddCustAddrViewViewModel *vcViewModel;
@property (strong, nonatomic) MJRefreshAutoGifFooter *refreshFooter;

//@property (strong, nonatomic) TTCAddCustAddrViewControllerCellTopViewDragView *dragView;
//add
@property (strong, nonatomic) TTCAddCustAddrViewControllerCellTopViewMenuView *dragView;
@end
@implementation TTCAddCustAddrViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCAddCustAddrViewViewModel alloc] init];
    _addressString = @"";
    _areaIDString = @"";
    _areaNameString = @"";
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
    [self getArea];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    [self notificationRecieve];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    __block TTCAddCustAddrViewController *selfVC = self;
    //tableView
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = CLEAR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive | UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCAddCustAddrViewControllerCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfVC getHeaderData];
    }];
    //上拉刷新
    _refreshFooter = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(getFooterData)];
    _tableView.mj_footer = _refreshFooter;
    //收起键盘手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    tap.delegate = self;
    [_tableView addGestureRecognizer:tap];
    //业务区下拉列表
//    _dragView = [[TTCAddCustAddrViewControllerCellTopViewDragView alloc] init];
    _dragView = [[TTCAddCustAddrViewControllerCellTopViewMenuView alloc] init];

    _dragView.stringBlock = ^(NSString *string){
//        NSLog(@"string==%@",string);
        selfVC.areaNameString = string;
        [selfVC.tableView reloadData];
        selfVC.areaIDString = [selfVC.vcViewModel transfromAreaIDWithAreaName:selfVC.areaNameString];
    };
    [_tableView addSubview:_dragView];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
#if 0
    //业务区下拉列表
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(137/2);
        make.left.mas_equalTo(278);
        make.width.mas_equalTo(785/2);
    }];
#else
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(137/2+10);
        make.left.mas_equalTo(0);
        make.width.equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
//        make.height.mas_equalTo(0);
    }];
#endif
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc canGoBack:YES];
    [nvc loadHeaderTitle:@"添加地址"];
}
#pragma mark - Event response
//收起键盘
- (void)tapPressed:(UITapGestureRecognizer *)tap{
    TTCAddCustAddrViewControllerCell *cell = (TTCAddCustAddrViewControllerCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell packUpKeyBoard];
}
//接收通知
- (void)notificationRecieve{
    //查询
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"添加地址-查询" object:nil];
    //业务区
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"业务区上拉" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"业务区下拉" object:nil];
    //菜单隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"Menu隐藏" object:nil];

}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"添加地址-查询"]) {
        NSString *factorString = [notification.userInfo valueForKey:@"查询条件"];
        if (factorString.length > 0) {
            _addressString = factorString;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self getHeaderData];
        }else{
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入查询条件" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }
    }else if([notification.name isEqualToString:@"业务区上拉"]){
        [_dragView packUpList];
    }else if([notification.name isEqualToString:@"业务区下拉"]){
        [_dragView dragDownList];
    }else if([notification.name isEqualToString:@"Menu隐藏"]){
        [self tapPressed:nil];
    }
}
#pragma mark - Data request
//下拉刷新
- (void)getHeaderData{
    _curPage = 1;
    _curCount = 0;
    [_refreshFooter resetNoMoreData];
    __block TTCAddCustAddrViewController *selfVC = self;
    __block TTCAddCustAddrViewViewModel *selfViewModel = _vcViewModel;
    //获取地址列表
    [_vcViewModel getAddressListWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password areaid:_areaIDString patchid:@"" addr:_addressString pagesize:@"10" currentPage:[NSString stringWithFormat:@"%d",_curPage] success:^(NSMutableArray *resultArray) {
        //获取片区字典
        [selfViewModel getPatchSuccess:^(NSMutableArray *resultArray) {
            //获取状态字典
            [selfViewModel getStatusSuccess:^(NSMutableArray *resultArray) {
                //获取可安装业务
                [selfViewModel getPermarkSuccess:^(NSMutableArray *resultArray) {
                    //获取成功
                    [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
                    [selfVC.tableView.mj_header endRefreshing];
                    [selfVC.tableView reloadData];
                } fail:^(NSError *error) {
                    //获取失败
                    [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
                    [selfVC.tableView.mj_header endRefreshing];
                    [selfVC.tableView reloadData];
                    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alView show];
                }];
            } fail:^(NSError *error) {
                //获取失败
                [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
                [selfVC.tableView.mj_header endRefreshing];
                [selfVC.tableView reloadData];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alView show];
            }];
        } fail:^(NSError *error) {
            //获取失败
            [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
            [selfVC.tableView.mj_header endRefreshing];
            [selfVC.tableView reloadData];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }];
        
    } fail:^(NSError *error) {
        //获取失败
        [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
        [selfVC.tableView.mj_header endRefreshing];
        [selfVC.tableView reloadData];
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alView show];
    }];
}
//上拉刷新
- (void)getFooterData{
    _curPage ++;
    __block TTCAddCustAddrViewController *selfVC = self;
    __block TTCAddCustAddrViewViewModel *selfViewModel = _vcViewModel;
    [_vcViewModel getAddressListWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password areaid:_areaIDString patchid:@"" addr:_addressString pagesize:@"10" currentPage:[NSString stringWithFormat:@"%d",_curPage] success:^(NSMutableArray *resultArray) {
        //获取成功
        if (selfVC.curCount != selfViewModel.dataAddressArray.count) {
            selfVC.curCount = (int)selfViewModel.dataAddressArray.count;
            [selfVC.tableView.mj_footer endRefreshing];
            [selfVC.tableView reloadData];
        }else{
            [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
            [selfVC.tableView reloadData];
        }
    } fail:^(NSError *error) {
        //获取失败
        [selfVC.tableView.mj_footer endRefreshing];
        [selfVC.tableView reloadData];
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alView show];
    }];
}
//获取业务区
- (void)getArea{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block TTCAddCustAddrViewController *selfVC = self;
    __block TTCAddCustAddrViewViewModel *selfViewModel = _vcViewModel;
    [_vcViewModel getAreaSuccess:^(NSMutableArray *resultArray) {
        //获取成功
        [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
        [selfVC.dragView loadWithDataArray:selfViewModel.dataAreaNameArray];
    } fail:^(NSError *error) {
        //获取失败
        [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
        [selfVC.dragView loadWithDataArray:selfViewModel.dataAreaNameArray];
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alView show];
    }];
}
#pragma mark - Protocol methods
//UIScrollViewDelegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    TTCAddCustAddrViewControllerCell *cell = (TTCAddCustAddrViewControllerCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell packUpKeyBoard];
}
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        //顶部模式
        return 1;
    }else{
        //其他模式
        if (_vcViewModel.dataAddressArray.count > 0) {
            return _vcViewModel.dataAddressArray.count;
        }else{
            return 0;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCAddCustAddrViewControllerCell *cell = (TTCAddCustAddrViewControllerCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        //顶部模式
        [cell selectCellModel:kTopMode];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadAreaLabelWithAreaString:_areaNameString];
    }else if (indexPath.section == 1){
        //其他模式
        [cell selectCellModel:kOtherMode];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        if(_vcViewModel.dataAddressArray.count > 0){
            //地址数据
            TTCAddAddressViewControllerOutputHouseModel *houseModel = _vcViewModel.dataAddressArray[indexPath.row];
            [cell loadAddress:houseModel.whladdr area:[_vcViewModel transfromPatchNameWithPatchID:houseModel.patchid] business:[_vcViewModel transfromPermarkNameWithStatusID:houseModel.permark] status:[_vcViewModel transfromStatusNameWithStatusID:houseModel.status]];
        }
    }
    return cell;
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //顶部模式
        return 294/2;
    }else if(indexPath.section == 1){
        //其他模式
        return 300/2;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.0001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *vcArray = self.navigationController.viewControllers;
    UIViewController *lastVC = self.navigationController.viewControllers[vcArray.count - 2];
    [lastVC setValue:_vcViewModel.dataAddressArray[indexPath.row] forKey:@"houseModel"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
//UIGestureRecognizerDelegate Methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
     NSLog(@"%@",[touch.view class]);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"TTCAddCustAddrViewControllerOtherView"]) {
        return NO;
    }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"TTCAddCustAddrViewControllerCellTopViewMenuView"]){
//        NSLog(@"collection Touch~~~");
        return NO;
    }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]){
        //        NSLog(@"collection Touch~~~");
        return NO;
    }
    return  YES;
}
#pragma mark - Other methods

@end
