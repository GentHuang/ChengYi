//
//  TTCNewCustomViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/12/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCNewCustomViewController.h"
#import "TTCNavigationController.h"
#import "TTCUserDetailViewController.h"
#import "TTCAddCustAddrViewController.h"
//View
#import "TTCNewCustomViewControllerMainView.h"
//ViewModel
#import "TTCNewCustomViewControllerViewModel.h"
#import "TTCUserLocateViewControllerViewModel.h"
@interface TTCNewCustomViewController ()
@property (strong, nonatomic) TTCNewCustomViewControllerMainView *mainView;
@property (strong, nonatomic) NSString *areaString;
@property (strong, nonatomic) NSString *custNameString;
@property (strong, nonatomic) NSString *cardTypeString;
@property (strong, nonatomic) NSString *cardIDString;
@property (strong, nonatomic) NSString *MobileString;
@property (strong, nonatomic) NSString *custTypeString;
@property (strong, nonatomic) NSString *custSubTypeString;
@property (strong, nonatomic) NSString *shareString;
@property (strong, nonatomic) NSString *contactNameString;
@property (strong, nonatomic) NSString *contactAddString;
@property (strong, nonatomic) NSString *remarkString;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) TTCNewCustomViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) TTCUserLocateViewControllerViewModel *locateViewModel;
@end

@implementation TTCNewCustomViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCNewCustomViewControllerViewModel alloc] init];
    //locateViewModel
    _locateViewModel = [[TTCUserLocateViewControllerViewModel alloc] init];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
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
    _mainView = [[TTCNewCustomViewControllerMainView alloc] init];
    [self.view addSubview:_mainView];
}
- (void)setSubViewLayout{
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
    [nvc loadHeaderTitle:@"新建客户"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if([[userDefault valueForKey:@"客户登录状态"] isEqualToString:@"YES"]){
        [nvc ClientLeaveButton:NO];
    }else {
        [nvc ClientLeaveButton:YES];
    }
}
#pragma mark - Event response
//添加通知
- (void)notificationRecieve{
    //接收新建开户信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"新建开户" object:nil];
    //添加地址
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"添加地址" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"新建开户"]) {
        //获取输入的信息
        _custNameString = [notification.userInfo valueForKey:@"客户名称"];
        _cardTypeString = [notification.userInfo valueForKey:@"证件类型"];
        _cardIDString = [notification.userInfo valueForKey:@"证件号码"];
        _MobileString = [notification.userInfo valueForKey:@"手机"];
        _custTypeString = [notification.userInfo valueForKey:@"客户类别"];
        _custSubTypeString = [notification.userInfo valueForKey:@"客户子类型"];
        _shareString = [notification.userInfo valueForKey:@"农村文化共享户"];
        _contactNameString = [notification.userInfo valueForKey:@"联系人"];
        _contactAddString = [notification.userInfo valueForKey:@"联系地址"];
        _remarkString = [notification.userInfo valueForKey:@"备注"];
        
        if([_areaString isEqualToString:@""]){
            //判断数据是否为空
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择业务区" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else if ([_custNameString isEqualToString:@""]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入客户名称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else if ([_cardTypeString isEqualToString:@""]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择证件类型" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else if ([_cardIDString isEqualToString:@""]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入证件号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else if ([_cardTypeString isEqualToString:@"身份证"]&&[self iSIdentityCard:_cardIDString]==NO){//添加正则表达式判断身份证
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确身份证号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alView show];
        }else if ([_MobileString isEqualToString:@""]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else if ([self iSPhoneNumber:_MobileString]==NO){//添加正则表达式判断
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            NSLog(@"_cardTypeString=%@",_MobileString);
                [alView show];
        }else if ([_custTypeString isEqualToString:@""]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择客户类别" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else if ([_custSubTypeString isEqualToString:@""]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择客户子类型" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else if ([_contactNameString isEqualToString:@""]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入联系人名称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else if ([_contactAddString isEqualToString:@""]){
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入联系人地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
        }else{
            //进行名称和ID的互换
            [_vcViewModel transfromCardType:_cardTypeString customType:_custTypeString customSubType:_custSubTypeString share:_shareString];
            _cardTypeString = _vcViewModel.dataCardTypeIDString;
            _custTypeString = _vcViewModel.dataCustomTypeIDString;
            _custSubTypeString = _vcViewModel.dataCustomSubTypeIDString;
            _shareString = _vcViewModel.dataShareIDString;
            //新建客户
            __block TTCNewCustomViewControllerViewModel *selfViewModel = _vcViewModel;
            __block TTCNewCustomViewController *selfVC = self;
            //下载等待
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            //topmemo为空
            [_vcViewModel createNewCustomWithDeptid:[SellManInfo sharedInstace].depID clientcode:[SellManInfo sharedInstace].loginname clientpwd:[SellManInfo sharedInstace].password areaid:_areaString markno:@"" custType:_custTypeString subtype:_custSubTypeString cardType:_cardTypeString cardNo:_cardIDString linkaddr:_contactAddString linkman:_contactNameString mobile:_MobileString phone:@"" memo:_remarkString topmemo:@"" name:_custNameString success:^(NSMutableArray *resultArray) {
                //新建客户成功,定位客户
                [selfVC userLocateAction:selfViewModel.markNum];
            } fail:^(NSError *error) {
                //新建客户失败
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alView show];
            }];
        }
    }else if ([notification.name isEqualToString:@"添加地址"]){
        TTCAddCustAddrViewController *addAddressVC = [[TTCAddCustAddrViewController alloc] init];
        [self.navigationController pushViewController:addAddressVC animated:YES];
    }
}
//观察者
- (void)addObserver{
    //地址
    [self addObserver:self forKeyPath:@"houseModel" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"houseModel"]){
        //地址
        _areaString = _houseModel.areaid;
        [_vcViewModel transfromAreaID:_areaString];
        [_mainView loadWithAreaString:_vcViewModel.dataAreaNameString];
    }
}
#pragma mark - Data request
//请求网络数据
- (void)getData{
    //下载等待
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block TTCNewCustomViewControllerViewModel *selfViewModel = _vcViewModel;
    __block TTCNewCustomViewController *selfVC = self;
    //请求业务区
    [_vcViewModel getAreaSuccess:^(NSMutableArray *resultArray) {
        //请求证件类型
        [selfViewModel getCardTypeSuccess:^(NSMutableArray *resultArray) {
            //请求客户类别
            [selfViewModel getCustomTypeSuccess:^(NSMutableArray *resultArray) {
                //请求农村文化共享户口
                [selfViewModel getShareSuccess:^(NSMutableArray *resultArray) {
                    //请求客户子类型
                    [selfViewModel getCustomSubTypeSuccess:^(NSMutableArray *resultArray) {
                        [selfVC loadSuccess];
                    } fail:^(NSError *error) {
                        [selfVC loadFail];
                    }];
                } fail:^(NSError *error) {
                    [selfVC loadFail];
                }];
            } fail:^(NSError *error) {
                [selfVC loadFail];
            }];
            
        } fail:^(NSError *error) {
            [selfVC loadFail];
        }];
    } fail:^(NSError *error) {
        [selfVC loadFail];
    }];
}
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载成功
- (void)loadSuccess{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mainView loadAreaWithCardTypeArray:_vcViewModel.dataCardTypeNameArray custTypeArray:_vcViewModel.dataCustomTypeNameArray custSubTypeArray:_vcViewModel.dataCustomSubTypeNameArray shareArray:_vcViewModel.dataShareNameArray];
}
//加载失败
- (void)loadFail{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mainView loadAreaWithCardTypeArray:_vcViewModel.dataCardTypeNameArray custTypeArray:_vcViewModel.dataCustomTypeNameArray custSubTypeArray:_vcViewModel.dataCustomSubTypeNameArray shareArray:_vcViewModel.dataShareNameArray];
    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:_vcViewModel.failMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alView show];
}
//客户定位
- (void)userLocateAction:(NSString *)icno{
    //请求客户数据
    __weak TTCNewCustomViewController *selfVC = self;
    //使用客户证号方式登陆
    [_locateViewModel getCustomerInfoWithIcno:icno type:[NSString stringWithFormat:@"%d",2] success:^(NSMutableArray *resultArray) {
        //请求成功
        __block BOOL balanceOK = NO;
        __block BOOL arrearOK = NO;
        __block BOOL productOK = NO;
        __block BOOL printOK = NO;
        //请求余额信息
        _locateViewModel.balanceSuccessBlock = ^(NSMutableArray *resultArray){
            balanceOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                //跳转到客户详情
                [selfVC pushToUserDetailActionWithIcno:icno];
            }
        };
        [_locateViewModel getBalanceInfo];
        //请求欠费信息
        _locateViewModel.arrearSuccessBlock = ^(NSMutableArray *resultArray){
            arrearOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                //跳转到客户详情
                [selfVC pushToUserDetailActionWithIcno:icno];
            }
        };
        [_locateViewModel getArrearsListWithServsArray:_locateViewModel.dataServsArray];
        //请求所有业务信息
        _locateViewModel.userProductSuccessBlock = ^(NSMutableArray *resultArray){
            productOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                //跳转到客户详情
                [selfVC pushToUserDetailActionWithIcno:icno];
            }
        };
        [_locateViewModel getUseProductWithServsArray:_locateViewModel.dataServsArray];
        //请求所有未打印单信息
        _locateViewModel.noPrintInfoSuccessBlock = ^(NSMutableArray *resultArray){
            printOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                //跳转到客户详情
                [selfVC pushToUserDetailActionWithIcno:icno];
            }
        };
        _locateViewModel.noPrintInfoFailBlock = ^(NSError *erroe){
            //请求失败
            [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"客户定位失败，请重新定位" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [al show];
        };
        [_locateViewModel getNoInvoiceInfo];
    } fail:^(NSError *error) {
        //请求失败
        [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:_locateViewModel.failMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
    }];
}
//跳到客户详情
- (void)pushToUserDetailActionWithIcno:(NSString *)icno{
    //缓存客户ID
    NSArray *memoryArray = [_userDefault objectForKey:@"客户ID"];
    if (memoryArray.count > 0) {
        //添加新的客户ID
        NSMutableArray *dataArray = [NSMutableArray array];
        BOOL isExit = NO;
        for (int i = 0; i < memoryArray.count; i ++) {
            [dataArray addObject:memoryArray[i]];
            if ([icno isEqualToString:memoryArray[i]]) {
                isExit = YES;
            }
            if (i == memoryArray.count -1 && !isExit) {
                [dataArray addObject:icno];
            }
        }
        [_userDefault setObject:dataArray forKey:@"客户ID"];
    }else{
        //若本为空，创建客户ID数组
        memoryArray = [NSArray arrayWithObjects:icno, nil];
        [_userDefault setObject:memoryArray forKey:@"客户ID"];
    }
    [_userDefault synchronize];
    //记录客户登录状态
    [_userDefault setValue:@"YES" forKey:@"客户登录状态"];
    [_userDefault synchronize];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    TTCUserDetailViewController *detailVC = [[TTCUserDetailViewController alloc] init];
    //定位成功，去掉定位页面
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    if(navigationArray.count > 0){
        [navigationArray removeObject:self];
        [navigationArray addObject:detailVC];
        [self.navigationController setViewControllers:navigationArray animated:YES];
    }
}
#pragma mark  正则表达式 判断是否格式正确
- (BOOL)iSPhoneNumber :(NSString*)patten{
    
    //手机号格式
    NSString *phoneNum = @"^1\\d{10}$";
    //创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:phoneNum options:0 error:nil];
    //测试字符串
    NSArray *results = [regex matchesInString:patten options:0 range:NSMakeRange(0, patten.length)];
    
    return results.count>0;
}
- (BOOL)iSIdentityCard:(NSString*)patten{
    //身份证格式
    NSString *identityCard = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    //创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:identityCard options:0 error:nil];
    //测试字符串
    NSArray *results = [regex matchesInString:patten options:0 range:NSMakeRange(0, patten.length)];
    
    return results.count>0;
}


@end
