//
//  TTCProductLibViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCProductLibViewController.h"
#import "TTCNavigationController.h"
#import "TTCProductDetailViewController.h"
#import "TTCUserLocateViewController.h"
#import "TTCPayViewController.h"
//View
#import "TTCProductLibTTopView.h"
#import "TTCProductLibCell.h"
#import "TTCProductLibLeftCell.h"
#import "TTCProductLibBuyView.h"
//add
#import "TTCProductLibMidScroll.h"
#import "TTCProudcntLibExpandMenuView.h"
//ViewModel
#import "TTCProductLibViewControllerViewModel.h"
#import "TTCProductLibLeftCell.h"

#import "TTCProductDetailViewControllerViewModel.h"
//Model
#import "TTCProductLibViewControllerRowsModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
#import "TTCProductLibViewTypeModel.h"
#import "TTCProductLibViewTypePclistModel.h"
#import "TTCProductDetailViewControllerModel.h"
@interface TTCProductLibViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,TTCProductLibMidScrolldelegate>
@property (strong, nonatomic) TTCProductLibViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCProductDetailViewControllerViewModel *detailViewModel;
@property (strong, nonatomic) TTCProductLibTTopView *topView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITableView *leftTableView;
@property (strong, nonatomic) NSString *itemID;
@property (assign, nonatomic) int page;
@property (assign, nonatomic) int arrayCount;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (assign, nonatomic) BOOL isLog;
@property (strong, nonatomic) UIAlertView *buyAlView;
@property (strong, nonatomic) UIAlertView *carAlView;
@property (strong, nonatomic) TTCProductLibBuyView *buyView;
@property (strong, nonatomic) NSArray *allServsArray;
@property (strong, nonatomic) NSString *keyno;
@property (strong, nonatomic) NSString *permark;
@property (strong, nonatomic) NSString *priceCount;
@property (strong, nonatomic) CALayer *layer;
@property (nonatomic,strong) UIBezierPath *path;
//add
@property (strong, nonatomic) TTCProductLibMidScroll *midScrollView;
@property (strong, nonatomic) TTCProudcntLibExpandMenuView *ExpandMenuView;
@property (strong, nonatomic) UIView *testView;
//add  小菊花
@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) NSString *tempPricecount;
@property (strong, nonatomic) NSString *tempNumberOne;
//营销方案
@property (assign, nonatomic) BOOL isMarketingPlan;
@end

@implementation TTCProductLibViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCProductLibViewControllerViewModel alloc] init];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
    //detailViewModel
    _detailViewModel = [[TTCProductDetailViewControllerViewModel alloc] init];
    //    _tempNumberOne = [NSString stringWithFormat:@"1"];
    _isMarketingPlan = NO;
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
    [self addObserver];
    [self getData];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    _isLog = [[_userDefault valueForKey:@"客户登录状态"] boolValue];
    if (_isLog) {
        //获取所有用户的信息
        _allServsArray = [CustomerInfo shareInstance].allServsArray;
    }
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
    [tab showBar];
}

- (void)dealloc{
    [_topView removeObserver:self forKeyPath:@"selectedIndex"];
    [_buyView removeObserver:self forKeyPath:@"addressString"];
    [_buyView removeObserver:self forKeyPath:@"orderCount"];
    [_midScrollView removeObserver:self forKeyPath:@"selectedIndexx"];
    [_ExpandMenuView removeObserver:self forKeyPath:@"selectedIndex"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    __block TTCProductLibViewController *selfVC = self;
    self.view.backgroundColor = LIGHTGRAY;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //TopView
    _topView = [[TTCProductLibTTopView alloc] init];
    [self.view addSubview:_topView];
    //add
    //中间的滚动视图
    _midScrollView = [[TTCProductLibMidScroll alloc]init];
    [self.view addSubview:_midScrollView];
    _midScrollView.delegate = self;
    //点击展开菜单
    _ExpandMenuView = [[TTCProudcntLibExpandMenuView alloc]init];
    [self.view addSubview:_ExpandMenuView];
    
    //TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = LIGHTGRAY;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCProductLibCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHeaderDataWithItemID:_itemID];
    }];
    //上拉刷新
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getFooterDataWithItemID:_itemID page:(++_page)];
    }];
    //左侧选择栏  弃用的左侧列表
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _leftTableView.backgroundColor = LIGHTGRAY;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.hidden  = YES;
    _leftTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_leftTableView registerClass:[TTCProductLibLeftCell class] forCellReuseIdentifier:@"leftCell"];
    [self.view addSubview:_leftTableView];
    //购买页面
    _buyView = [[TTCProductLibBuyView alloc] init];
    _buyView.alpha = 0;
    _buyView.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_buyView];
    //------add-----
    //创建小菊花
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activity.transform = CGAffineTransformMakeScale(1, 1);
    [self.view addSubview:_activity];
    _activity.color = [UIColor grayColor];
}
- (void)setSubViewLayout{
    //TopView
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(264/2);
        make.top.mas_equalTo(NAV_HEIGHT_PROLIB);
    }];
    //    //中间的滚动视图
    [_midScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);//-20
        make.height.mas_equalTo(90/2);
        make.top.mas_equalTo(_topView.mas_bottom).offset(20);
    }];
    //点击展开菜单
    [_ExpandMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_midScrollView.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    //菊花位置
    [_activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_midScrollView.mas_bottom);
        make.centerX.mas_equalTo(self.view);
    }];
    //leftTableView
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        //        make.width.mas_equalTo(200);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(-TAB_HEIGHT);
        make.top.mas_equalTo(_midScrollView.mas_bottom);
    }];
    //TableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        //        make.left.mas_equalTo(_leftTableView.mas_right);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);
        make.top.mas_equalTo(_midScrollView.mas_bottom);
    }];
    //购买页面
    [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);
        make.top.mas_equalTo(NAV_HEIGHT_PROLIB);
        //        make.top.mas_equalTo(_midScrollView.mas_bottom);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc canGoBack:_canGoBack];
    [nvc loadHeaderTitle:@"产品库"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if([[userDefault valueForKey:@"客户登录状态"] isEqualToString:@"YES"]){
        [nvc ClientLeaveButton:NO];
    }else {
        [nvc ClientLeaveButton:YES];
    }
}
#pragma mark - Event response
//添加观察者
- (void)addObserver{
    //观察顶部按钮
    [_topView addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    //点击用户列表
    [_buyView addObserver:self forKeyPath:@"addressString" options:NSKeyValueObservingOptionNew context:nil];
    //购买月数
    [_buyView addObserver:self forKeyPath:@"orderCount" options:NSKeyValueObservingOptionNew context:nil];
    //中间滚动视图的按钮选择
    [_midScrollView addObserver:self forKeyPath:@"selectedIndexx" options:NSKeyValueObservingOptionNew context:nil];
    //观察collection的点击
    [_ExpandMenuView addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == _topView) {
        //观察顶部按钮
        int selectedIndex = [[change valueForKey:@"new"] intValue];
        //如果是点击热销按钮
        if (selectedIndex==4) {
            //热销文案模式
            [_midScrollView SelectedIntermediateViewType:KViewTypeHotSellType];
            //隐藏下拉菜单
            [_ExpandMenuView paclUpMenu];
            self.itemID = @"热销";
            [self reloadDataOnceAgain:self.itemID];
            
        }else {
            //普通模式
            [_midScrollView SelectedIntermediateViewType:KViewTypeScrollType];
            //获取子目录
            [_vcViewModel getSubProTypeWithIndex:selectedIndex];
            [_leftTableView reloadData];
            //获取产品列表
            TTCProductLibViewTypeModel *typeModel = [_vcViewModel.dataProductTypeArray objectAtIndex:selectedIndex];
            self.itemID = typeModel.itemid;
            [self reloadDataOnceAgain:self.itemID];
            //add
            //刷新中间滚动视图数据
            [_midScrollView reloadScrollViewWithArray:_vcViewModel.dataProductSubTypeNameArray];
            [_ExpandMenuView getDataWithArray:_vcViewModel.dataProductSubTypeNameArray];
            
        }
        
        //隐藏年份购买按钮
        if(selectedIndex ==3){
            _isMarketingPlan = YES;
            //隐藏
            [_buyView hiddeBUyYearOrMonthlyButton];
        }else{
            _isMarketingPlan = NO;
            //显示
            [_buyView showBuyYearOrMonthlyButton];
        }
        
        
    }else if ([keyPath isEqualToString:@"addressString"]) {
        //点击用户列表
        NSString *addressString = [change valueForKey:@"new"];
        NSArray *dataArray = [addressString componentsSeparatedByString:@" "];
        _permark = [dataArray firstObject];
        _keyno = [dataArray lastObject];
    }else if([keyPath isEqualToString:@"orderCount"]){
        _priceCount = [NSString stringWithFormat:@"%@",[change valueForKey:@"new"]];
        
    }else if (object==_midScrollView){
        int selectedIndex = [[change valueForKey:@"new"]intValue];
        TTCProductLibViewTypePclistModel *pclistModel = [_vcViewModel.dataProductSubTypeArray objectAtIndex:selectedIndex];
        self.itemID = pclistModel.itemid;
        [_ExpandMenuView selectWithIndex:selectedIndex];
        [self reloadDataOnceAgain:self.itemID];
    }else if (object==_ExpandMenuView){
        int selectedIndex = [[change valueForKey:@"new"]intValue];
        TTCProductLibViewTypePclistModel *pclistModel = [_vcViewModel.dataProductSubTypeArray objectAtIndex:selectedIndex];
        self.itemID = pclistModel.itemid;
        //        [self.tableView.mj_header beginRefreshing];
        [self reloadDataOnceAgain:self.itemID];
        [_midScrollView selectWithIndex:selectedIndex];
    }
}
//立即购买
- (void)buyButtonPressed:(NSIndexPath *)indexPath{
    if (_isLog) {
        TTCProductLibViewControllerRowsModel *rowsModel = _vcViewModel.dataProductListArray[indexPath.row];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __block TTCProductDetailViewControllerViewModel *selfViewModel = _detailViewModel;
        [_detailViewModel getProductById:rowsModel.id_conflict success:^(NSMutableArray *resultArray) {
            //请求成功
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_buyView showBuyView];
            [_buyView selectViewType:kBuyType];
            [self loadBuyViewWithModel:_vcViewModel.dataProductListArray[indexPath.row]];
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            //请求失败
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
            
        }];
    }else{
        //未登录
        _buyAlView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先定位客户" delegate:self cancelButtonTitle:@"定位" otherButtonTitles:@"取消", nil];
        [_buyAlView show];
    }
    
}
//加入购物车
- (void)addCarButtonPressed:(NSIndexPath *)indexPath{
    if (_isLog) {
        TTCProductLibViewControllerRowsModel *rowsModel = _vcViewModel.dataProductListArray[indexPath.row];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __block TTCProductDetailViewControllerViewModel *selfViewModel = _detailViewModel;
        [_detailViewModel getProductById:rowsModel.id_conflict success:^(NSMutableArray *resultArray) {
            //请求成功
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_buyView showBuyView];
            [_buyView selectViewType:kCarType];
            [self loadBuyViewWithModel:_vcViewModel.dataProductListArray[indexPath.row]];
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            //请求失败
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }];
    }else{
        //未登录
        _carAlView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先定位客户" delegate:self cancelButtonTitle:@"定位" otherButtonTitles:@"取消", nil];
        [_carAlView show];
    }
}
//点击按钮（马上订购，加入购物车）
- (void)buttonPressed:(NSString *)string{
    if (!_priceCount) {
        _priceCount = @"1";
    }
    __block TTCProductLibViewController *selfVC = self;
    __block TTCProductDetailViewControllerViewModel *selfViewModel = _detailViewModel;
    if ([_permark isEqualToString:@"模拟"]) {
        _permark = @"0";
    }else if ([_permark isEqualToString:@"数字"]) {
        _permark = @"1";
    }else if ([_permark isEqualToString:@"宽带"]) {
        _permark = @"2";
    }else if ([_permark isEqualToString:@"互动"]) {
        _permark = @"3";
    }else if ([_permark isEqualToString:@"智能"]) {
        _permark = @"4";
    }
    if ([string isEqualToString:@"马上订购"]) {
        [selfVC.buyView startDownload];
        [_detailViewModel productOrderWithModel:_detailViewModel.vcModel keyno:_keyno count:_priceCount success:^(NSMutableArray *resultArray) {
            //订购成功,确定订单,跳转
            [selfVC.buyView stopDownload];
            [self.buyView hideBuyView];
            TTCPayViewController *payVC = [[TTCPayViewController alloc] init];
            payVC.isOrderPay = YES;
            payVC.orderDataArray = selfViewModel.dataOrderArray;
            payVC.priceCount = selfVC.priceCount;
            payVC.vcModel = selfViewModel.vcModel;
            payVC.keyno = selfVC.keyno;
            [self.navigationController pushViewController:payVC animated:YES];
        } fail:^(NSError *error) {
            //支付失败
            [selfVC.buyView stopDownload];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }];
    }else if([string isEqualToString:@"加入购物车"]){
        //已经登录直接加入购物车
        [_detailViewModel addToShoppingCarWithModel:_detailViewModel.vcModel keyno:_keyno count:_priceCount permark:_permark success:^(NSMutableArray *resultArray) {
            //加入成功
            UIImageView *productImageView = (UIImageView *)[selfVC.buyView valueForKey:@"viewImageView"];
            [selfVC startAnimationWithRect:CGRectMake(0, 350, 50, 50) ImageView:productImageView];
        } fail:^(NSError *error) {
            //加入失败
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }];
    }
}

#pragma mark - Network request
//获取数据
- (void)getData{
    __block TTCProductLibViewController *selfVC = self;
    __block TTCProductLibViewControllerViewModel *selfViewModel = _vcViewModel;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //获取产品分类
    [_vcViewModel getProductTypeSuccess:^(NSMutableArray *resultArray) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //获取产品分类
        //        [selfVC.topView loadProductTypeWithArray:selfViewModel.dataProductTypeNameArray];
        [selfVC.topView loadProductTypeWithArray:selfViewModel.dataProductTypeNameArray titleImage:selfViewModel.dataProductTypeImageArray];
        
        //获取子目录
        [selfViewModel getSubProTypeWithIndex:0];
        //获取中间滚动视图信息
        //add
        [selfVC.midScrollView reloadScrollViewWithArray:selfViewModel.dataProductSubTypeNameArray];
        [selfVC.ExpandMenuView getDataWithArray:selfViewModel.dataProductSubTypeNameArray];
        
        [selfVC.leftTableView reloadData];
        //获取产品列表
        TTCProductLibViewTypeModel *typeModel = [selfViewModel.dataProductTypeArray firstObject];
        selfVC.itemID = typeModel.itemid;
        [selfVC.tableView.mj_header beginRefreshing];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


//下拉获取数据
- (void)getHeaderDataWithItemID:(NSString *)itemID{
    //    //如果顶部列表为空
    if (_vcViewModel.dataProductTypeNameArray==nil) {
        [self getData];
    }
    _arrayCount = 0;
    _page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [_vcViewModel getProListWithItemID:itemID page:_page success:^(NSMutableArray *resultArray) {
        //请求成功
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        //请求失败
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    }];
}
//上拉获取数据
- (void)getFooterDataWithItemID:(NSString *)itemID page:(int)page{
    __block TTCProductLibViewController *selfVC = self;
    __block TTCProductLibViewControllerViewModel *selfViewModel = _vcViewModel;
    [_vcViewModel getProListWithItemID:itemID page:_page success:^(NSMutableArray *resultArray) {
        //请求成功
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        //尾部判断是否全部数据请求完成
        if (selfVC.arrayCount != _vcViewModel.dataProductListArray.count) {
            _arrayCount = (int)selfViewModel.dataProductListArray.count;
            [selfVC.tableView.mj_footer endRefreshing];
        }else{
            [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } fail:^(NSError *error) {
        //请求失败
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [selfVC.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}
//获取产品详情数据
- (void)loadBuyViewWithModel:(TTCProductLibViewControllerRowsModel *)model{
    //加载用户列表
    NSMutableArray *keynoArray = [NSMutableArray array];
    NSMutableArray *permarArray = [NSMutableArray array];
    for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel in _allServsArray) {
        [keynoArray addObject:servsModel.keyno];
        [permarArray addObject:servsModel.permark];
    }
    [_buyView loadUserListWithArray:keynoArray permarkArray:permarArray];
    
    for (int i = 0; i < permarArray.count; i ++) {
        if ([permarArray[i] isEqualToString:model.permark]) {
            _permark = permarArray[i];
            _keyno = keynoArray[i];
            break;
        }
    }
    if(!_keyno){
        _keyno = @"";
    }
    if (!_permark) {
        _permark = @"";
    }
    [self.buyView loadTitle:model.title intro:@"" price:model.price smallimg:model.img firstUserKeyno:_keyno firstUserPermark:_permark];
}

#pragma mark - Protocol methods
//UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        //产品列表
        if (_vcViewModel.dataProductListArray.count > 0) {
            return _vcViewModel.dataProductListArray.count;
        }else{
            return 0;
        }
    }else if (tableView == _leftTableView){
        //分类列表
        if (_vcViewModel.dataProductSubTypeNameArray.count > 0) {
            return _vcViewModel.dataProductSubTypeNameArray.count;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        //产品列表
        TTCProductLibCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (_vcViewModel.dataProductListArray.count > 0) {
            TTCProductLibViewControllerRowsModel *rowsModel = _vcViewModel.dataProductListArray[indexPath.row];
            [cell loadID:rowsModel.id_conflict title:rowsModel.title img:rowsModel.img price:rowsModel.price type:rowsModel.type];
        }
        cell.buttonBlock = ^(NSString *buttonString){
            if ([buttonString isEqualToString:@"立即购买"]) {
                [self buyButtonPressed:indexPath];
            }else if([buttonString isEqualToString:@"加入购物车"]){
                [self addCarButtonPressed:indexPath];
            }
        };
        return cell;
    }else if(tableView == _leftTableView){
        //分类列表
        TTCProductLibLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        if (_vcViewModel.dataProductSubTypeNameArray.count > 0) {
            [cell loadTitleWithTitle:_vcViewModel.dataProductSubTypeNameArray[indexPath.row]];
        }
        return cell;
    }else{
        return [UITableViewCell new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        //产品列表
        return 200/2;//150/2
    }else if(tableView == _leftTableView){
        //分类列表
        return 96/2;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == _tableView) {
        //产品列表
        return 0.0001;
    }else if(tableView == _leftTableView){
        //分类列表
        return 0.0001;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        //产品列表
        return 34/2;
    }else if(tableView == _leftTableView){
        //分类列表
        return 34/2;
    }else{
        return 0;
    }
}
//UITableViewDelegate Methods
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView){
        //产品列表
        TTCProductLibViewControllerRowsModel *rowsModel = _vcViewModel.dataProductListArray[indexPath.row];
        TTCProductDetailViewController *detailVC = [[TTCProductDetailViewController alloc] init];
        detailVC.id_conflict = rowsModel.id_conflict;
        detailVC.isMarketingPlan = _isMarketingPlan;
        [self.navigationController pushViewController:detailVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else if(tableView == _leftTableView){
        //分类列表
        //获取产品列表
        TTCProductLibViewTypePclistModel *pclistModel = [_vcViewModel.dataProductSubTypeArray objectAtIndex:indexPath.row];
        self.itemID = pclistModel.itemid;
        [self.tableView.mj_header beginRefreshing];
    }
}
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == _buyAlView || alertView == _carAlView) {
        if (buttonIndex == 0) {
            //未登录的先客户定位
            TTCUserLocateViewController *userLocateVC = [[TTCUserLocateViewController alloc] init];
            userLocateVC.isProductDetail = YES;
            userLocateVC.canGoBack = YES;
            [self.navigationController pushViewController:userLocateVC animated:YES];
        }
    }
}
//弹出菜单
- (void)ClickOnTheMenuWith {
    _ExpandMenuView.hidden = NO;
    [self.view bringSubviewToFront:_ExpandMenuView];
    [_ExpandMenuView dragDownMenu];
}
#pragma mark - Other methods
//购物车动画
-(void)startAnimationWithRect:(CGRect)rect ImageView:(UIImageView *)imageView{
    if (!_layer) {
        _layer = [CALayer layer];
        _layer.contents = (id)imageView.layer.contents;
        
        _layer.contentsGravity = kCAGravityResizeAspectFill;
        _layer.bounds = rect;
        [_layer setCornerRadius:CGRectGetHeight([_layer bounds]) / 2];
        _layer.masksToBounds = YES;
        // 导航64
        _layer.position = CGPointMake(200, CGRectGetMidY(rect)+64);
        [self.view.layer addSublayer:_layer];
        self.path = [UIBezierPath bezierPath];
        [_path moveToPoint:_layer.position];
        [_path addQuadCurveToPoint:CGPointMake(SCREEN_MAX_WIDTH - 330, SCREEN_MAX_Height-40) controlPoint:CGPointMake(SCREEN_MAX_WIDTH/2,rect.origin.y-80)];
    }
    [self groupAnimation];
}
-(void)groupAnimation{
    _tableView.userInteractionEnabled = NO;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.25f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.25;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    narrowAnimation.duration = 0.25f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
}
//动画完成
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (anim == [_layer animationForKey:@"group"]) {
        _tableView.userInteractionEnabled = YES;
        [_layer removeFromSuperlayer];
        _layer = nil;
    }
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"加入购物车" object:nil];
    
    //隐藏动画完成视图
    [_buyView hideBuyView];
    
}
#pragma mark  小菊花动画
- (void)reloadDataOnceAgain:(NSString *)itemID{
    //3.开启动画
    [_activity startAnimating];
    //加载数据
    [self getHeaderDataWithItemID:itemID];
    [self.tableView reloadData];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideActivityView:) userInfo:_activity repeats:NO];
}
-(void)hideActivityView:(NSTimer *)timer{
    UIActivityIndicatorView *activity = timer.userInfo;
    //关闭动画(在某个点触发)
    [activity stopAnimating];
}
@end
