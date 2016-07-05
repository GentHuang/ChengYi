//
//  TTCNewUserViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCNewUserViewController.h"
#import "TTCScanViewController.h"
#import "TTCAddAddressViewController.h"
#import "TTCNavigationController.h"
#import "TTCPayViewController.h"
//View
#import "TTCNewUserViewControllerMainView.h"
//ViewModel
#import "TTCNewUserViewControllerViewModel.h"
//Model
#import "TTCNewUserViewControllerCreateOutputAutoOpenDefModel.h"
@interface TTCNewUserViewController ()
@property (assign, nonatomic) int pageCount;
@property (assign, nonatomic) int taskCount;
@property (strong, nonatomic) TTCNewUserViewControllerMainView *mainView;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) NSString *lastAddressString;
@property (strong, nonatomic) NSString *createModeString;
@property (strong, nonatomic) NSString *payWayString;
@property (strong, nonatomic) NSString *serveTypeString;
@property (strong, nonatomic) NSString *feeTypeString;
@property (strong, nonatomic) NSString *setupString;
@property (strong, nonatomic) NSString *mainCardString;
@property (strong, nonatomic) NSString *cardNumString;
@property (strong, nonatomic) NSString *topBoxString;
@property (strong, nonatomic) NSString *CMString;
@property (strong, nonatomic) NSString *houseIDString;
@property (strong, nonatomic) NSString *cardNumDeviceString;
@property (strong, nonatomic) NSString *topBoxDeviceString;
@property (strong, nonatomic) NSString *CMDeviceString;
//@property (strong, nonatomic) NSString *broadAccountString;
@property (strong, nonatomic) NSString *broadPWDString;
@property (strong, nonatomic) NSString *broadSuffixString;
@property (strong, nonatomic) TTCNewUserViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCNewUserViewControllerCreateOutputAutoOpenDefModel *createModel;
@end
@implementation TTCNewUserViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCNewUserViewControllerViewModel alloc] init];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self creatUI];
    [self setSubViewLayout];
    [self addObserver];
    [self getData];
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
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"scanString"];
    [self removeObserver:self forKeyPath:@"houseModel"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Getters and setters
- (void)creatUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //mainView
    _mainView = [[TTCNewUserViewControllerMainView alloc] init];
    [self.view addSubview:_mainView];
}
- (void)setSubViewLayout{
    //mainView
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc canGoBack:YES];
    [nvc loadHeaderTitle:@"开户"];
}
#pragma mark - Event response
//添加通知
- (void)notificationRecieve{
    //接收开户信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"开户" object:nil];
    //添加地址
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"添加地址" object:nil];
    //智能卡扫一扫
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"智能卡" object:nil];
    //机顶盒扫一扫
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"机顶盒" object:nil];
    //EOC扫一扫
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"EOC" object:nil];
    //开户地址下拉
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"开户地址下拉" object:nil];
    //开户地址上拉
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"开户地址上拉" object:nil];
    
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"开户"]) {
        //获取输入的信息
        _addressString = [notification.userInfo valueForKey:@"地址"];
        _lastAddressString = [notification.userInfo valueForKey:@"尾地址"];
        _createModeString = [notification.userInfo valueForKey:@"开户模式"];
        _feeTypeString = [notification.userInfo valueForKey:@"收费类型"];
        _setupString = [notification.userInfo valueForKey:@"上门安装"];
        _mainCardString = [notification.userInfo valueForKey:@"所属主卡"];
        _cardNumString = [notification.userInfo valueForKey:@"智能卡"];
        _topBoxString = [notification.userInfo valueForKey:@"机顶盒"];
        _CMString = [notification.userInfo valueForKey:@"Cm"];
        _payWayString = [notification.userInfo valueForKey:@"支付方式"];
        _serveTypeString = [notification.userInfo valueForKey:@"用户类型"];
        _cardNumDeviceString = [notification.userInfo valueForKey:@"智能卡设备来源"];
        _topBoxDeviceString = [notification.userInfo valueForKey:@"机顶盒设备来源"];
        _CMDeviceString = [notification.userInfo valueForKey:@"EOC设备来源"];
        _broadAccountString = [notification.userInfo valueForKey:@"宽带账号"];
        _broadPWDString = [notification.userInfo valueForKey:@"宽带密码"];
        _broadSuffixString = [notification.userInfo valueForKey:@"宽带后缀"];
//        NSString *houseID = [_vcViewModel getHouseIDWithAddress:[NSString stringWithFormat:@"%@%@",_addressString,_lastAddressString]];
        //需求要求只要前面的地址相同即可，不需要尾地址
        NSString *houseID = [_vcViewModel getHouseIDWithAddress:[NSString stringWithFormat:@"%@",_addressString]];
        if (houseID.length > 0) {
            _houseIDString = houseID;
        }
        if (!_houseIDString) {
            _houseIDString = @"";
        }
        //        if([_addressString isEqualToString:@""]){
        //            //判断数据是否为空
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else if ([_lastAddressString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入尾地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
        //        }else if ([_CMString isEqualToString:@""]){
        //            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入Cm" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alView show];
        //        }else{
        
        
        //执行开户
        __block TTCNewUserViewControllerViewModel *selfViewModel = _vcViewModel;
        //转换成ID
        [_vcViewModel transfromFeeTypeWith:_feeTypeString payWay:_payWayString serveType:_serveTypeString setup:_setupString cardNumString:_cardNumDeviceString topBoxString:_topBoxDeviceString CMString:_CMDeviceString broadSuffixString:_broadSuffixString];
        //获取开户模式Model
        _createModel = [_vcViewModel transfromCreateModeWithCreateModeString:_createModeString];
        if (!_createModel) {
            _createModel = [[TTCNewUserViewControllerCreateOutputAutoOpenDefModel alloc] init];
            _createModel.id_conflict = @"";
        }
        //下载等待
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //开户
        [_vcViewModel createNewUserWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password areaid:[CustomerInfo shareInstance].areaid houseid:_houseIDString addr:_addressString endaddr:_lastAddressString openmode:_createModel.id_conflict feekind:_vcViewModel.dataFeeTypeString custid:[CustomerInfo shareInstance].custid type:_vcViewModel.dataSetupString servtype:_vcViewModel.dataServeTypeString servrele:_mainCardString stbno:_topBoxString smno:_cardNumString cmno:_CMString oldstbno:@"" oldlogicno:@"" smnouseprop:_vcViewModel.dataCardNumDeviceString stbuseprop:_vcViewModel.dataTopBoxDeviceString payway:_vcViewModel.dataPayWayString cmuseprop:_vcViewModel.dataCMDeviceString uname:_broadAccountString passwrod:_broadPWDString suffix:_vcViewModel.dataBroadSuffixString success:^(NSMutableArray *resultArray) {
            //开户成功，跳到支付界面
            /*
             TTCProductDetailViewControllerModel *orderModel = [[TTCProductDetailViewControllerModel alloc] init];
             orderModel.id_conflict = _createModel.pid;
             orderModel.title = _createModel.modememo;
             orderModel.price = _createModel.price;
             orderModel.smallimg = @"开户";
             TTCPayViewController *payVC = [[TTCPayViewController alloc] init];
             payVC.priceCount = @"1";
             payVC.isOrderPay = YES;
             payVC.vcModel = orderModel;
             NSArray *orderIDArray = [NSArray arrayWithObjects:orderModel.id_conflict, nil];
             payVC.orderDataArray = orderIDArray;
             [self.navigationController pushViewController:payVC animated:YES];
             */
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开户已经成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
            [self.navigationController popViewControllerAnimated:YES];
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
    }else if ([notification.name isEqualToString:@"机顶盒"]){
        TTCScanViewController *scanVC = [[TTCScanViewController alloc] init];
        scanVC.postName = notification.name;
        [self.navigationController pushViewController:scanVC animated:YES];
    }else if ([notification.name isEqualToString:@"EOC"]){
        TTCScanViewController *scanVC = [[TTCScanViewController alloc] init];
        scanVC.postName = notification.name;
        [self.navigationController pushViewController:scanVC animated:YES];
    }else if ([notification.name isEqualToString:@"添加地址"]){
        TTCAddAddressViewController *addAddressVC = [[TTCAddAddressViewController alloc] init];
        [self.navigationController pushViewController:addAddressVC animated:YES];
    }else if([notification.name isEqualToString:@"开户地址下拉"]){
        [self getAddressHeader];
    }else if([notification.name isEqualToString:@"开户地址上拉"]){
        [self getAddressFooter];
    }
}
//观察者
- (void)addObserver{
    //扫一扫
    [self addObserver:self forKeyPath:@"scanString" options:NSKeyValueObservingOptionNew context:nil];
    //地址
    [self addObserver:self forKeyPath:@"houseModel" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"scanString"]) {
        //扫一扫
        NSString *scanString = [change valueForKey:@"new"];
        [_mainView loadScanStringWithScanString:scanString];
        
    }else if([keyPath isEqualToString:@"houseModel"]){
        //地址
        _houseIDString = _houseModel.houseid;
        [_mainView loadAddressStringWithAddressString:_houseModel.whladdr];
        [_mainView loadLastAddressStringWithAddressString:_houseModel.endaddr];
    }
}
#pragma mark - Data request
//获取数据
- (void)getData{
    //下载等待
    __block TTCNewUserViewControllerViewModel *selfViewModel = _vcViewModel;
    __block TTCNewUserViewController *selfVC = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //获取收费类型
    [_vcViewModel getFeeTypeSuccess:^(NSMutableArray *resultArray) {
        //获取上门安装
        [selfViewModel getSetupSuccess:^(NSMutableArray *resultArray) {
            //获取开户模式
            [selfViewModel getCreateModeWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password city:@"" areaId:@"" permark:@"" success:^(NSMutableArray *resultArray) {
                //获取用户类型
                [selfViewModel getServeTypeSuccess:^(NSMutableArray *resultArray) {
                    //获取支付方式
                    [selfViewModel getPayWaySuccess:^(NSMutableArray *resultArray) {
                        //获取智能卡设备来源
                        [selfViewModel getCardDeviceSuccess:^(NSMutableArray *resultArray) {
                            //获取机顶盒设备来源
                            [selfViewModel getTopBoxDeviceSuccess:^(NSMutableArray *resultArray) {
                                //获取EOC设备来源
                                [selfViewModel getCMDeviceSuccess:^(NSMutableArray *resultArray) {
                                    //获取宽带后缀
                                    [selfViewModel getBroadSuffixSuccess:^(NSMutableArray *resultArray) {
                                        //获取成功
                                        [selfVC getAddressHeader];
                                        //                                        [selfVC loadSuccess];
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
//获取开户地址（头部）
- (void)getAddressHeader{
    _pageCount = 1;
    _taskCount = 0;
    __block TTCNewUserViewController *selfVC = self;
    [_vcViewModel getAddressWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password custid:[CustomerInfo shareInstance].custid areaid:[CustomerInfo shareInstance].areaid patchid:@"" addr:@"" pagesize:@"6" currentPage:[NSString stringWithFormat:@"%d",_pageCount] success:^(NSMutableArray *resultArray) {
        //获取成功
        [selfVC loadSuccess];
    } fail:^(NSError *error) {
        //获取失败
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_mainView loadCreatModeArray:_vcViewModel.dataPermarkNameArray payWayArray:_vcViewModel.dataPayWayNameArray serveTypeArray:_vcViewModel.dataServeTypeNameArray feeTypeArray:_vcViewModel.dataFeeTypeNameArray setupArray:_vcViewModel.dataSetupNameArray cardDeviceArray:_vcViewModel.dataCardDeviceNameArray topBoxDeviceArray:_vcViewModel.dataTopBoxDeviceNameArray cmDeviceArray:_vcViewModel.dataCMDeviceNameArray broadSuffixArray:_vcViewModel.dataBroadSuffixNameArray broadDicArray:_vcViewModel.dataBroadSuffixCodeArray addressArray:_vcViewModel.dataAddressArray];
    }];
}
//获取开户地址(尾部)
- (void)getAddressFooter{
    _pageCount ++;
    _taskCount = 0;
    __block TTCNewUserViewController *selfVC = self;
    [_vcViewModel getAddressWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password custid:[CustomerInfo shareInstance].custid areaid:[CustomerInfo shareInstance].areaid patchid:@"" addr:@"" pagesize:@"6" currentPage:[NSString stringWithFormat:@"%d",_pageCount] success:^(NSMutableArray *resultArray) {
        //获取成功
        [selfVC loadSuccess];
    } fail:^(NSError *error) {
        //获取失败
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_mainView loadCreatModeArray:_vcViewModel.dataPermarkNameArray payWayArray:_vcViewModel.dataPayWayNameArray serveTypeArray:_vcViewModel.dataServeTypeNameArray feeTypeArray:_vcViewModel.dataFeeTypeNameArray setupArray:_vcViewModel.dataSetupNameArray cardDeviceArray:_vcViewModel.dataCardDeviceNameArray topBoxDeviceArray:_vcViewModel.dataTopBoxDeviceNameArray cmDeviceArray:_vcViewModel.dataCMDeviceNameArray broadSuffixArray:_vcViewModel.dataBroadSuffixNameArray broadDicArray:_vcViewModel.dataBroadSuffixCodeArray addressArray:_vcViewModel.dataAddressArray];
    }];
}
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载成功
- (void)loadSuccess{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mainView loadCreatModeArray:_vcViewModel.dataPermarkNameArray payWayArray:_vcViewModel.dataPayWayNameArray serveTypeArray:_vcViewModel.dataServeTypeNameArray feeTypeArray:_vcViewModel.dataFeeTypeNameArray setupArray:_vcViewModel.dataSetupNameArray cardDeviceArray:_vcViewModel.dataCardDeviceNameArray topBoxDeviceArray:_vcViewModel.dataTopBoxDeviceNameArray cmDeviceArray:_vcViewModel.dataCMDeviceNameArray broadSuffixArray:_vcViewModel.dataBroadSuffixNameArray broadDicArray:_vcViewModel.dataBroadSuffixCodeArray addressArray:_vcViewModel.dataAddressArray];
    //add
    [_mainView loadUserbroadAccountString:_broadAccountString];
}
//加载失败
- (void)loadFail{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mainView loadCreatModeArray:_vcViewModel.dataPermarkNameArray payWayArray:_vcViewModel.dataPayWayNameArray serveTypeArray:_vcViewModel.dataServeTypeNameArray feeTypeArray:_vcViewModel.dataFeeTypeNameArray setupArray:_vcViewModel.dataSetupNameArray cardDeviceArray:_vcViewModel.dataCardDeviceNameArray topBoxDeviceArray:_vcViewModel.dataTopBoxDeviceNameArray cmDeviceArray:_vcViewModel.dataCMDeviceNameArray broadSuffixArray:_vcViewModel.dataBroadSuffixNameArray broadDicArray:_vcViewModel.dataBroadSuffixCodeArray addressArray:_vcViewModel.dataAddressArray];
    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:_vcViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alView show];
}
@end
