//
//  TTCPrintViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCPrintViewController.h"
#import "TTCNavigationController.h"
#import "TTCPrintDetailViewController.h"
//View
#import "TTCPrintViewCell.h"
#import "TTCPrintViewDragView.h"
#import "TTCPrintViewCellAccountBackView.h"
//ViewModel
#import "TTCPrintViewControllerViewModel.h"
//Model
#import "TTCPrintViewControllerViewOutputUnprintinvinfosModel.h"
//Status
#import "TTCPrintViewCellStatus.h"
@interface TTCPrintViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (assign, nonatomic) BOOL allSelected;
@property (assign, nonatomic) BOOL isDrag;
@property (assign, nonatomic) int lastGroupID;
@property (assign, nonatomic) float selectedPrice;
@property (assign, nonatomic) float searchSelectedPrice;
@property (strong, nonatomic) NSString *typeString;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchVC;
@property (strong, nonatomic) NSMutableArray *searchArray;
@property (strong, nonatomic) NSMutableArray *statusArray;
@property (strong, nonatomic) NSMutableArray *searchStatusArray;
@property (strong, nonatomic) NSMutableArray *selecteStatusArray;
@property (strong, nonatomic) TTCPrintViewCellAccountBackView *accBackView;
@property (strong, nonatomic) CustomerInfo *customer;
@property (strong, nonatomic) TTCPrintViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCPrintViewDragView *dragView;
@end
@implementation TTCPrintViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCPrintViewControllerViewModel alloc] init];
    //客户信息
    _customer = [CustomerInfo shareInstance];
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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchVC dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self setNavigationBar];
}
#pragma mark - Getters and setters
- (void)createUI{
    _lastGroupID = 1;
    _isDrag = NO;
    _allSelected = NO;
    _typeString = @"发票分组:1";
    __block TTCPrintViewController *selfVC = self;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = LIGHTGRAY;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCPrintViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfVC getData];
    }];
    //打印发票栏
    _accBackView = [[TTCPrintViewCellAccountBackView alloc] init];
    _accBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _accBackView.layer.borderWidth = 0.5;
    _accBackView.backgroundColor = WHITE;
    [self.view addSubview:_accBackView];
    _accBackView.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
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
    _searchVC.searchBar.placeholder = @"搜索打印单号";
    _searchVC.searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    _searchVC.searchBar.layer.borderWidth = 0.5;
    _searchVC.searchBar.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
    _searchVC.searchBar.layer.masksToBounds = YES;
    _searchVC.searchBar.layer.cornerRadius = 0;
    _searchVC.searchBar.bounds = CGRectMake(0, 0, SCREEN_MAX_WIDTH, 110/2);
    _tableView.tableHeaderView = _searchVC.searchBar;
    //下拉视图
    _dragView = [[TTCPrintViewDragView alloc] init];
    _dragView.stringBlock = ^(NSString *string){
        [selfVC buttonPressed:string];
    };
    [self.view addSubview:_dragView];
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    tap.delegate = self;
    [_tableView addGestureRecognizer:tap];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
    //打印发票栏
    [_accBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(112/2);
    }];
    //下拉视图
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-TAB_HEIGHT-112/2);//-TAB_HEIGHT-112/2
        make.left.mas_equalTo(153/2);
        make.width.mas_equalTo(250/2);
        make.height.mas_equalTo(250/2);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc loadHeaderTitle:@"打印发票"];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(NSString *)buttonString{
    if ([buttonString isEqualToString:@"打印发票"]) {
        TTCPrintDetailViewController *detailVC = [[TTCPrintDetailViewController alloc] init];
        if (_searchVC.active) {
            detailVC.allPrintInfoArray = _searchArray;
            detailVC.allPrice = _searchSelectedPrice;
        }else{
            detailVC.allPrintInfoArray = _selecteStatusArray;
            detailVC.allPrice = _selectedPrice;
        }
        if (detailVC.allPrintInfoArray.count > 0) {
            //如果是全部打印则直接返回根视图
            if (detailVC.allPrintInfoArray.count ==_vcViewModel.dataPrintArray.count) {
                detailVC.isPopRootViewControl = YES;
            }
            [self.navigationController pushViewController:detailVC animated:YES];
        }else{
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有可以打印的发票" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }
    }else if([buttonString isEqualToString:@"选择按钮"]){
        _allSelected = !_allSelected;
        [self isAllSelected:_allSelected];
        [self loadAccountBackView];
        [_tableView reloadData];
    }else if([buttonString isEqualToString:@"下拉按钮"]){
        _isDrag = !_isDrag;
//        [_dragView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(246/2);
//        }];
        [self loadAccountBackView];
        [_tableView reloadData];
        if (_isDrag) {
            [_dragView showDragView];
        }else{
            [_dragView hideDragView];
        }
    }else{
        //选择菜单栏
        _isDrag = !_isDrag;
        _typeString = buttonString;
        NSArray *typeArray = [buttonString componentsSeparatedByString:@":"];
        [self getDataWithGroupID:[typeArray lastObject]];
//        if ([buttonString isEqualToString:@"模拟业务类"]) {
//            _lastGroupID = 0;
//            [self getDataWithGroupID:@"0"];
//        }else if([buttonString isEqualToString:@"数字业务类"]){
//            _lastGroupID = 1;
//            [self getDataWithGroupID:@"1"];
//        }else if([buttonString isEqualToString:@"宽带业务类"]){
//            _lastGroupID = 2;
//            [self getDataWithGroupID:@"2"];
//        }else if([buttonString isEqualToString:@"互动业务类"]){
//            _lastGroupID = 3;
//            [self getDataWithGroupID:@"3"];
//        }else if([buttonString isEqualToString:@"智能业务类"]){
//            _lastGroupID = 4;
//            [self getDataWithGroupID:@"4"];
//        }
        if (_isDrag) {
            [_dragView showDragView];
        }else{
            [_dragView hideDragView];
        }
    }
}
//收起下拉菜单
- (void)tapPressed{
    if (_isDrag) {
        _isDrag = !_isDrag;
        [_dragView hideDragView];
        [self loadAccountBackView];
        [_tableView reloadData];
    }
}
//获取数据
- (void)getData{
    //未开票全部获取成功
    __block TTCPrintViewController *selfVC = self;
    __block TTCPrintViewControllerViewModel *selfViewModel = _vcViewModel;
    _vcViewModel.noPrintInfoSuccessBlock = ^(NSMutableArray *resultArray){
        if (selfViewModel.dataGroupIDArray.count>0 ) {
            
            [selfVC.dragView loadDragViewWithArray:selfViewModel.dataGroupIDArray];
            [selfVC getDataWithGroupID:[NSString stringWithFormat:@"%d",selfVC.lastGroupID]];
            selfVC.allSelected = NO;
            [selfVC.tableView reloadData];
            //        [selfVC loadAccountBackView];
            [selfVC.tableView.mj_header endRefreshing];
        }
//        else {
//            //如果没有可以打印的发票直接返回
//            [selfVC.navigationController popToRootViewControllerAnimated:YES];
//        }

    };
    //未开票获取失败
    _vcViewModel.noPrintInfoFailBlock = ^(NSError *error){
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有可以打印的发票" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    };
    [_vcViewModel getNoInvoiceInfo];
}
#pragma mark - Network request
//根据选择类刷新tableview
- (void)getDataWithGroupID:(NSString *)groupID{
    [_vcViewModel getNoPrintInfoWithGroupID:groupID dataArray:_vcViewModel.allPrintArray];
    //存储已选的数据
    _selecteStatusArray = [NSMutableArray array];
    //加载Cell状态
    _selectedPrice = 0;
    _statusArray = [NSMutableArray array];
    for (int i = 0; i < _vcViewModel.dataPrintArray.count; i ++) {
        TTCPrintViewCellStatus *cellStatus = [[TTCPrintViewCellStatus alloc] init];
        cellStatus.isSelected = NO;
        [_statusArray addObject:cellStatus];
    }
    _allSelected = NO;
    [self loadAccountBackView];
    [_tableView reloadData];
}
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_searchVC.active) {
        //搜索
        if (_searchArray.count > 0) {
            return _searchArray.count+1;
        }else{
            return 1;
        }
    }else{
        //平常
        if (_vcViewModel.dataPrintArray.count > 0) {
            return _vcViewModel.dataPrintArray.count+1;
        }else{
            return 1;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCPrintViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.stringBlock = ^(NSString *buttonString){
        [self buttonPressed:buttonString];
    };
    if (indexPath.section == 0) {
        //发票总额
        float price;
        if (_searchVC.active) {
            price = _searchSelectedPrice;
        }else{
            price = _selectedPrice;
        }
        cell.hidden = YES;
        [cell selectCellType:kAccountType];
        [cell loadTypeWithString:_typeString];
        [cell isAllSelected:_allSelected];
        [cell loadSelectedPrice:price];
        [cell isDrag:_isDrag];
    }else{
        //发票详情
        [cell selectCellType:kDetailType];
        //加载状态
        TTCPrintViewCellStatus *cellStatus;
        //加载数据
        TTCPrintViewControllerViewOutputUnprintinvinfosModel *infoModel;
        if (_searchVC.active) {
            //搜索
            if (_searchArray.count > 0) {
                infoModel = _searchArray[indexPath.section - 1];
                cellStatus = _searchStatusArray[indexPath.section - 1];
            }
        }else{
            //平常
            if (_vcViewModel.dataPrintArray.count > 0) {
                infoModel  = _vcViewModel.dataPrintArray[indexPath.section - 1];
                cellStatus = _statusArray[indexPath.section - 1];
            }
        }
        //加载数据
        [cell loadWithInvcontid:infoModel.invcontid keyno:_customer.markno optime:infoModel.optime fees:[NSString stringWithFormat:@"%.2f",[infoModel.fees floatValue]] mName:infoModel.mName];
        //加载状态
        [cell isSelected:cellStatus.isSelected];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 0/2;
    }else{
        return 367/2;
    }
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else{
        return 0.001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0) {
        [self tapPressed];
        TTCPrintViewCell *cell = (TTCPrintViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        TTCPrintViewCellStatus *cellStatus;
        TTCPrintViewControllerViewOutputUnprintinvinfosModel *infoModel;
        if (_searchVC.active) {
            //搜索
            if (_searchStatusArray.count > 0) {
                cellStatus = _searchStatusArray[indexPath.section - 1];
                infoModel = _searchArray[indexPath.section - 1];
            }
        }else{
            //平常
            if (_statusArray.count > 0) {
                cellStatus = _statusArray[indexPath.section - 1];
                infoModel = _vcViewModel.dataPrintArray[indexPath.section - 1];
            }
        }
        //状态记录
        cellStatus.isSelected = !cellStatus.isSelected;
        [cell isSelected:cellStatus.isSelected];
        //选择价钱加减
        if (cellStatus.isSelected) {
            //增加
            _selectedPrice += [infoModel.fees floatValue];
            if ([_selecteStatusArray indexOfObject:infoModel] == NSNotFound) {
                [_selecteStatusArray addObject:infoModel];
            }
        }else{
            //减少
            _selectedPrice -= [infoModel.fees floatValue];
            [_selecteStatusArray removeObject:infoModel];
        }
        [self loadAccountBackView];
        [tableView reloadData];
    }
}
//UISearchResultsUpdating Method
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //搜索数组
    _searchArray = [NSMutableArray array];
    _searchStatusArray = [NSMutableArray array];
    _searchSelectedPrice = 0;
    if (_vcViewModel.dataPrintArray.count > 0) {
        for (TTCPrintViewControllerViewOutputUnprintinvinfosModel *infoModel in _vcViewModel.dataPrintArray) {
            NSRange rang = [infoModel.invcontid rangeOfString:searchController.searchBar.text];
            if (rang.location != NSNotFound) {
                //数据
                [_searchArray addObject:infoModel];
                //总价
                _searchSelectedPrice += [infoModel.fees floatValue];
                //状态
                TTCPrintViewCellStatus *cellStatus = [[TTCPrintViewCellStatus alloc] init];
                cellStatus.isSelected = YES;
                [_searchStatusArray addObject:cellStatus];
            }
        }
        [self loadAccountBackView];
        [_tableView reloadData];
    }
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
//UIGestureRecognizerDelegate Method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 输出点击的view的类名
    //    NSLog(@"%@", NSStringFromClass([touch.view class]));
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return YES;
    }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableView"]) {
        return YES;
    }
    return  NO;
}
#pragma mark - Other methods
//全选或全不选
- (void)isAllSelected:(BOOL)isSelected{
    if (_statusArray.count > 0) {
        for (TTCPrintViewCellStatus *status in _statusArray) {
            status.isSelected = isSelected;
            if (isSelected) {
                //全选
                _selecteStatusArray = [NSMutableArray arrayWithArray:_vcViewModel.dataPrintArray];
            }else{
                //全不选
                [_selecteStatusArray removeAllObjects];
            }
        }
    }
    if (isSelected) {
        //全选
        _selectedPrice = _vcViewModel.allPrice;
    }else{
        //全不选
        _selectedPrice = 0;
    }
}
//刷新打印发票栏
- (void)loadAccountBackView{
    //发票总额
    float price;
    if (_searchVC.active) {
        price = _searchSelectedPrice;
    }else{
        price = _selectedPrice;
    }
    [_accBackView loadTypeWithString:_typeString];
    [_accBackView isAllSelected:_allSelected];
    [_accBackView loadSelectedPrice:price];
    [_accBackView isDrag:_isDrag];
}
@end
