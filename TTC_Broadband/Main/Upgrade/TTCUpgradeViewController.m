//
//  TTCUpgradeViewController.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/3.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCUpgradeViewController.h"
#import "TTCScanViewController.h"
#import "TTCNavigationController.h"
#import "TTCPayViewController.h"
//View
#import "TTCUpgradeViewControllerMainView.h"
//ViewModel
#import "TTCUpgradeViewControllerViewModel.h"
//Model
#import "TTCNewUserViewControllerCreateOutputAutoOpenDefModel.h"
@interface TTCUpgradeViewController ()
@property (strong, nonatomic) TTCUpgradeViewControllerMainView *mainView;
@property (strong, nonatomic) TTCUpgradeViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCNewUserViewControllerCreateOutputAutoOpenDefModel *createModel;
@property (strong, nonatomic) NSString *oldTopBoxString;
@property (strong, nonatomic) NSString *oldCardNumString;
@property (strong, nonatomic) NSString *createModeString;
@property (strong, nonatomic) NSString *feeTypeString;
@property (strong, nonatomic) NSString *setupString;
@property (strong, nonatomic) NSString *mainSeconderyString;
@property (strong, nonatomic) NSString *mainCardString;
@property (strong, nonatomic) NSString *topBoxString;
@property (strong, nonatomic) NSString *cardNumString;
@property (strong, nonatomic) NSString *scanString;
@property (assign, nonatomic) BOOL isUpgrade;
@end

@implementation TTCUpgradeViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCUpgradeViewControllerViewModel alloc] init];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubLayout];
    [self addObserver];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    [self notificationRecieve];
    [self getData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"scanString"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    __block TTCUpgradeViewController *selfVC = self;
    _isUpgrade = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //mainView
    _mainView = [[TTCUpgradeViewControllerMainView alloc] init];
    _mainView.buttonBlock = ^(NSString *string){
        [selfVC upgradeButtonPressed];
    };
    [_mainView isUpgradeDevice:_isUpgrade];
    [_mainView loadCreatModeArray:@[@"天河番禺区",@"天河客运站",@"广州市死哈的哦啊胡搜帝豪谁都爱好是滴哦",@"啊实打实大卡号十大科技和SD卡接啊圣诞节卡上",@"啊还SD卡金黄色空间的好看就阿訇是肯定哈客户端上开始",@"卡说假话的空间啊还是坎大哈开户送科技等哈看聚划算科技等哈看书"] feeTypeArray:@[@"天河番禺区",@"天河客运站",@"广州市死哈的哦啊胡搜帝豪谁都爱好是滴哦",@"啊实打实大卡号十大科技和SD卡接啊圣诞节卡上",@"啊还SD卡金黄色空间的好看就阿訇是肯定哈客户端上开始",@"卡说假话的空间啊还是坎大哈开户送科技等哈看聚划算科技等哈看书"] setupArray:@[@"天河番禺区",@"天河客运站",@"广州市死哈的哦啊胡搜帝豪谁都爱好是滴哦",@"啊实打实大卡号十大科技和SD卡接啊圣诞节卡上",@"啊还SD卡金黄色空间的好看就阿訇是肯定哈客户端上开始",@"卡说假话的空间啊还是坎大哈开户送科技等哈看聚划算科技等哈看书"] mainSeconderyArray:@[@"天河番禺区",@"天河客运站",@"广州市死哈的哦啊胡搜帝豪谁都爱好是滴哦",@"啊实打实大卡号十大科技和SD卡接啊圣诞节卡上",@"啊还SD卡金黄色空间的好看就阿訇是肯定哈客户端上开始",@"卡说假话的空间啊还是坎大哈开户送科技等哈看聚划算科技等哈看书"]];
    [self.view addSubview:_mainView];
    
}
- (void)setSubLayout{
    //mainView
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL);
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc canGoBack:YES];
    [nvc loadHeaderTitle:@"升级"];
}
#pragma mark - Event response
//添加通知
- (void)notificationRecieve{
    //接收开户信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"升级" object:nil];
    //旧智能卡扫一扫
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"旧智能卡" object:nil];
    //智能卡扫一扫
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"智能卡" object:nil];
    //旧机顶盒扫一扫
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"旧机顶盒" object:nil];
    //机顶盒扫一扫
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"机顶盒" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"升级"]) {
        //获取输入的信息
        _oldTopBoxString = [notification.userInfo valueForKey:@"旧机顶盒"];
        _oldCardNumString = [notification.userInfo valueForKey:@"旧智能卡"];
        _createModeString = [notification.userInfo valueForKey:@"开户模式"];
        _feeTypeString = [notification.userInfo valueForKey:@"收费类型"];
        _setupString = [notification.userInfo valueForKey:@"上门安装"];
        _mainSeconderyString = [notification.userInfo valueForKey:@"主副机"];
        _mainCardString = [notification.userInfo valueForKey:@"所属主卡"];
        if (_isUpgrade) {
            _cardNumString = [notification.userInfo valueForKey:@"智能卡"];
            _topBoxString = [notification.userInfo valueForKey:@"机顶盒"];
        }else{
            _cardNumString = @"";
            _topBoxString = @"";
        }
        
        //        if([_oldTopBoxString isEqualToString:@""]){
        //            //判断数据是否为空
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入旧机顶盒号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_oldCardNumString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入旧智能卡号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_createModeString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择开户模式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_feeTypeString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择收费类型" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_setupString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择上门安装方式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_mainSeconderyString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择主副机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_mainCardString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入所属主卡" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_cardNumString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入智能卡号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_topBoxString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入机顶盒号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else{
        //执行开户
        __block TTCUpgradeViewControllerViewModel *selfViewModel = _vcViewModel;
        //获取开户模式Model
        _createModel = [_vcViewModel transfromCreateModeWithCreateModeString:_createModeString];
        if (!_createModel) {
            _createModel = [[TTCNewUserViewControllerCreateOutputAutoOpenDefModel alloc] init];
            _createModel.id_conflict = @"";
        }
        //下载等待
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //开户
        [_vcViewModel createNewUserWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].loginname areaid:[CustomerInfo shareInstance].areaid houseid:@"" addr:@"" endaddr:@"" openmode:_createModel.id_conflict feekind:_feeTypeString custid:[CustomerInfo shareInstance].custid type:_setupString servtype:@"" servrele:_mainCardString stbno:_topBoxString logicno:_cardNumString cmno:@"" oldstbno:_oldTopBoxString oldlogicno:_oldCardNumString smnouseprop:@"" stbuseprop:@"" payway:@"" success:^(NSMutableArray *resultArray) {
            //开户成功，跳到支付界面
            TTCProductDetailViewControllerModel *orderModel = [[TTCProductDetailViewControllerModel alloc] init];
            orderModel.id_conflict = _createModel.pid;
            orderModel.title = _createModel.modememo;
            orderModel.price = _createModel.price;
            orderModel.smallimg = @"升级";
            TTCPayViewController *payVC = [[TTCPayViewController alloc] init];
            payVC.priceCount = @"1";
            payVC.isOrderPay = YES;
            payVC.vcModel = orderModel;
            NSArray *orderIDArray = [NSArray arrayWithObjects:orderModel.id_conflict, nil];
            payVC.orderDataArray = orderIDArray;
            [self.navigationController pushViewController:payVC animated:YES];
        } fail:^(NSError *error) {
            //开户失败
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }];
    }else if ([notification.name isEqualToString:@"智能卡"]){
        TTCScanViewController *scanVC = [[TTCScanViewController alloc] init];
        scanVC.postName = notification.name;
        [self.navigationController pushViewController:scanVC animated:YES];
    }else if ([notification.name isEqualToString:@"旧智能卡"]){
        TTCScanViewController *scanVC = [[TTCScanViewController alloc] init];
        scanVC.postName = notification.name;
        [self.navigationController pushViewController:scanVC animated:YES];
    }else if ([notification.name isEqualToString:@"机顶盒"]){
        TTCScanViewController *scanVC = [[TTCScanViewController alloc] init];
        scanVC.postName = notification.name;
        [self.navigationController pushViewController:scanVC animated:YES];
    }else if ([notification.name isEqualToString:@"旧机顶盒"]){
        TTCScanViewController *scanVC = [[TTCScanViewController alloc] init];
        scanVC.postName = notification.name;
        [self.navigationController pushViewController:scanVC animated:YES];
    }
}
//观察者
- (void)addObserver{
    //扫一扫
    [self addObserver:self forKeyPath:@"scanString" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"scanString"]) {
        NSString *scanString = [change valueForKey:@"new"];
        [_mainView loadScanStringWithScanString:scanString];
    }
}
//是否升级设备
- (void)upgradeButtonPressed{
    _isUpgrade = !_isUpgrade;
    [_mainView isUpgradeDevice:_isUpgrade];
}
#pragma mark - Data request
//获取数据
- (void)getData{
    //下载等待
    __block TTCUpgradeViewControllerViewModel *selfViewModel = _vcViewModel;
    __block TTCUpgradeViewController *selfVC = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //获取收费类型
    [_vcViewModel getFeeTypeSuccess:^(NSMutableArray *resultArray) {
        //获取上门安装
        [selfViewModel getSetupSuccess:^(NSMutableArray *resultArray) {
            //获取开户模式
            [selfViewModel getCreateModeWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password city:@"" areaId:@"" permark:@"" success:^(NSMutableArray *resultArray) {
                //获取成功
                [selfVC loadSuccess];
            } fail:^(NSError *error) {
                //获取失败
                [selfVC loadFail];
            }];
        } fail:^(NSError *error) {
            //获取失败
            [selfVC loadFail];
        }];
    } fail:^(NSError *error) {
        //获取失败
        [selfVC loadFail];
    }];
}
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载成功
- (void)loadSuccess{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mainView loadCreatModeArray:_vcViewModel.dataPermarkNameArray feeTypeArray:_vcViewModel.dataFeeTypeNameArray setupArray:_vcViewModel.dataSetupNameArray mainSeconderyArray:nil];
}
//加载失败
- (void)loadFail{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mainView loadCreatModeArray:_vcViewModel.dataPermarkNameArray feeTypeArray:_vcViewModel.dataFeeTypeNameArray setupArray:_vcViewModel.dataSetupNameArray mainSeconderyArray:nil];
    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:_vcViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alView show];
}
@end
