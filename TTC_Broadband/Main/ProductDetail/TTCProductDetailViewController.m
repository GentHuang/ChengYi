//
//  TTCProductDetailViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCProductDetailViewController.h"
#import "TTCNavigationController.h"
#import "TTCPayViewController.h"
#import "TTCUserLocateViewController.h"
//View
#import "TTCProductDetailView.h"
#import "TTCProductDetailDragView.h"
//ViewModel
#import "TTCProductDetailViewControllerViewModel.h"
//Model
#import "TTCProductDetailViewControllerModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"

@interface TTCProductDetailViewController ()<UIGestureRecognizerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSString *priceCount;
@property (strong, nonatomic) NSString *keyno;
@property (strong, nonatomic) NSString *permark;
@property (strong, nonatomic) TTCProductDetailView *mainView;
@property (strong, nonatomic) TTCProductDetailDragView *dragView;
@property (strong, nonatomic) TTCProductDetailViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) MBProgressHUD *progressHud;
@property (strong, nonatomic) UIView *waitBackView;
@property (strong, nonatomic) UITapGestureRecognizer *allTap;
@property (strong, nonatomic) NSMutableArray *keynoArray;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (assign, nonatomic) BOOL isLog;
@property (strong, nonatomic) UIAlertView *buyAlView;
@property (strong, nonatomic) UIAlertView *carAlView;
@property (strong, nonatomic) UIAlertView *carSureAlView;
@property (strong, nonatomic) NSArray *allServsArray;
@property (strong, nonatomic) UIWebView *descWebView;

@end
@implementation TTCProductDetailViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCProductDetailViewControllerViewModel alloc] init];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
    //添加观察者
    [self addObserver];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    _isLog = [[_userDefault valueForKey:@"客户登录状态"] boolValue];
    if (_isLog) {
        //已登录
        [_mainView selectViewModel:kLogMode];
        //获取所有用户的信息
        _allServsArray = [CustomerInfo shareInstance].allServsArray;
    }else{
        //未登录模式
        [_mainView selectViewModel:kUnLogMode];
    }
    [self getData];
    
        TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
        TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
        [tab hideBar];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //隐藏和显示选择营销方案后的年份按钮
    if (_isMarketingPlan) {
        [_mainView hiddeBUyYearOrMonthlyButton];
    }else {
        [_mainView showBuyYearOrMonthlyButton];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
    [tab showBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    //删除观察者
    [_dragView removeObserver:self forKeyPath:@"addressString"];
    //购买月数
    [_mainView removeObserver:self forKeyPath:@"orderCount" context:nil];
}
#pragma mark - Getters and setters
- (void)createUI{
    _priceCount = @"1";
    self.view.backgroundColor = LIGHTGRAY;
    //allTap
    _allTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    _allTap.delegate = self;
    [self.view addGestureRecognizer:_allTap];
    //MainView
    _mainView = [[TTCProductDetailView alloc] init];
    __block TTCProductDetailViewController *selfVC = self;
    _mainView.tapBlock = ^(UITapGestureRecognizer *tap){
        [selfVC tapPressed:tap];
    };
    _mainView.stringBlock = ^(NSString *buttonString){
        [selfVC buttonPressed:buttonString];
    };
    [self.view addSubview:_mainView];
    //下拉列表
    _dragView = [[TTCProductDetailDragView alloc] init];
    [self.view addSubview:_dragView];
    //产品详情
    _descWebView = [[UIWebView alloc] init];
    _descWebView.backgroundColor = WHITE;
    _descWebView.opaque = NO;
    [self.view addSubview:_descWebView];
    //等待界面
    _waitBackView = [[UIView alloc] init];
    _waitBackView.hidden = YES;
    _waitBackView.backgroundColor = LIGHTGRAY;
    [self.view addSubview:_waitBackView];
    //
    _progressHud = [[MBProgressHUD alloc] init];
    _progressHud.hidden = YES;
    [_waitBackView addSubview:_progressHud];
}
- (void)setSubViewLayout{
    //MainView
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NAV_HEIGHT_PROLIB);
        make.height.mas_equalTo(718/2);
    }];
    //产品详情
    [_descWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_mainView.mas_bottom).with.offset(20);
        make.bottom.mas_equalTo(0);//-TAB_HEIGHT
    }];
    //下拉列表
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mainView.mas_top).with.offset(380/2);
        make.left.mas_equalTo(537/2);
        make.width.mas_equalTo(817/2);
    }];
    //等待界面
    [_waitBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mainView.mas_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-STA_HEIGHT);
    }];
    [_progressHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_waitBackView);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc canGoBack:YES];
    [nvc selectNavigationType:kAccountInfoType];
    [nvc loadHeaderTitle:@"产品详情"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if([[userDefault valueForKey:@"客户登录状态"] isEqualToString:@"YES"]){
        [nvc ClientLeaveButton:NO];
    }else {
        [nvc ClientLeaveButton:YES];
    }
}
#pragma mark - Event response
//点击按钮（马上订购，加入购物车）
- (void)buttonPressed:(NSString *)string{
    __block TTCProductDetailViewController *selfVC = self;
    __block TTCProductDetailViewControllerViewModel *selfViewModel = _vcViewModel;
    [_mainView hideKeyBoard];
    if ([string isEqualToString:@"马上订购"]) {
        if (_isLog) {
            if (_mainView.canBuy) {
                [self startLoading];
                _waitBackView.backgroundColor = CLEAR;
                //已经登录，发送订单
                [_vcViewModel productOrderWithModel:_vcViewModel.vcModel keyno:_keyno count:_priceCount success:^(NSMutableArray *resultArray) {
                    //订购成功,确定订单,跳转
                    TTCPayViewController *payVC = [[TTCPayViewController alloc] init];
                    payVC.isOrderPay = YES;
                    payVC.orderDataArray = selfViewModel.dataOrderArray;
                    payVC.priceCount = selfVC.priceCount;
                    payVC.vcModel = selfViewModel.vcModel;
                    payVC.keyno = selfVC.keyno;
                    [self.navigationController pushViewController:payVC animated:YES];
                } fail:^(NSError *error) {
                    //支付失败
                    [selfVC stopLoading];
                    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alView show];
                }];
            }
        }else{
            //未登录
            _buyAlView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先定位客户" delegate:self cancelButtonTitle:@"定位" otherButtonTitles:@"取消", nil];
            [_buyAlView show];
        }
    }else if([string isEqualToString:@"加入购物车"]){
        if (_isLog) {
            if (_mainView.canBuy) {
                //已经登录直接加入购物车
                [_vcViewModel addToShoppingCarWithModel:_vcViewModel.vcModel keyno:_keyno count:_priceCount permark:_permark success:^(NSMutableArray *resultArray) {
                    selfVC.carSureAlView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"产品已加入购物车" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [selfVC.carSureAlView show];
                } fail:^(NSError *error) {
                    selfVC.carSureAlView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [selfVC.carSureAlView show];
                }];
            }
        }else{
            //未登录
            _carAlView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先定位客户" delegate:self cancelButtonTitle:@"定位" otherButtonTitles:@"取消", nil];
            [_carAlView show];
        }
    }
}
//点击Tap
- (void)tapPressed:(UITapGestureRecognizer *)tap{
    if (tap == _allTap) {
        //收起下拉列表
        [_dragView packUpList];
        //        [_mainView packUpView];
    }else{
        //展开下拉列表
        [_dragView dragDownList];
        //        [_mainView dragDownView];
    }
    //收起键盘(确定购买数量)
    [_mainView hideKeyBoard];
}
//添加观察者
- (void)addObserver{
    //点击用户列表
    [_dragView addObserver:self forKeyPath:@"addressString" options:NSKeyValueObservingOptionNew context:nil];
    //购买月数
    [_mainView addObserver:self forKeyPath:@"orderCount" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == _dragView) {
        //点击用户列表
        NSString *addressString = [change valueForKey:@"new"];
        [_mainView loadAddressString:addressString];
        NSArray *dataArray = [addressString componentsSeparatedByString:@" "];
        _permark = [dataArray firstObject];
        _keyno = [dataArray lastObject];
        _transPermark = _permark;
        _transKeyno = _keyno;
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
    }else if(object == _mainView){
        _priceCount = [NSString stringWithFormat:@"%@",[change valueForKey:@"new"]];
    }
}
#pragma mark - Network request
//获取数据
- (void)getData{
    [self startLoading];
    __block TTCProductDetailViewController *selfVC = self;
    __block TTCProductDetailViewControllerViewModel *selfViewModel = _vcViewModel;
    [_vcViewModel getProductById:_id_conflict success:^(NSMutableArray *resultArray) {
        //请求成功
        [self stopLoading];
        //加载用户列表
        selfVC.keynoArray = [NSMutableArray array];
        NSMutableArray *permarArray = [NSMutableArray array];
        for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel in _allServsArray) {
            [_keynoArray addObject:servsModel.keyno];
            [permarArray addObject:servsModel.permark];
        }
        [selfVC.dragView loadUserListWithArray:selfVC.keynoArray permarkArray:permarArray];
        //加载产品详情
        NSString *contentString = [NSString stringWithFormat:@"%@",selfViewModel.vcModel.contents];
        if (contentString.length>1) {
//            contentString = [contentString stringByReplacingOccurrencesOfString:@"/UploadFiles" withString:HTML5URL@"/UploadFiles"];
            contentString = [contentString stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\""HTML5URL];

                    NSLog(@"====%@",contentString);
        }
        //-------------
        [selfVC.descWebView loadHTMLString:contentString baseURL:nil];
//        [selfVC.descWebView loadHTMLString:selfViewModel.vcModel.contents baseURL:[NSURL URLWithString:HTML5URL]];
        
        
        if (_transKeyno.length > 0) {
            //续订
            //            [selfVC.mainView loadTitle:selfViewModel.vcModel.title intro:selfViewModel.vcModel.intro price:selfViewModel.vcModel.price smallimg:selfViewModel.vcModel.smallimg firstUserKeyno:_transKeyno firstUserPermark:_transPermark];
            _keyno = _transKeyno;
            _permark = _transPermark;
        }else{
            //产品库
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            _permark = [permarArray firstObject];
            _keyno = [_keynoArray firstObject];
            if ([[userDefault valueForKey:@"客户登录状态"] isEqualToString:@"YES"]) {
                for (int i = 0; i < permarArray.count; i ++) {
                    if ([permarArray[i] isEqualToString:selfViewModel.vcModel.permark]) {
                        _permark = permarArray[i];
                        _keyno = _keynoArray[i];
                        break;
                    }
                }
            }
        }
        if(!_keyno){
            _keyno = @"";
        }
        if (!_permark) {
            _permark = @"";
        }
        [selfVC.mainView loadTitle:selfViewModel.vcModel.title intro:selfViewModel.vcModel.intro price:selfViewModel.vcModel.price smallimg:selfViewModel.vcModel.smallimg firstUserKeyno:_keyno firstUserPermark:_permark];
        
    } fail:^(NSError *error) {
        //请求失败
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }];
}
#pragma mark - Protocol methods
//UIGestureRecognizerDelegate Methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
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
    }else if(alertView == _carSureAlView){
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            [self stopLoading];
        }
    }
}
#pragma mark - Other methods
//开始加载
- (void)startLoading{
    _waitBackView.backgroundColor = LIGHTGRAY;
    _waitBackView.hidden = NO;
    _progressHud.hidden = NO;
    [_progressHud show:YES];
}
//停止加载
- (void)stopLoading{
    _waitBackView.hidden = YES;
    _progressHud.hidden = YES;
    [_progressHud show:NO];
}
@end
