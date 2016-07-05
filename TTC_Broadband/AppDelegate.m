//
//  AppDelegate.m
//  TTC_Broadband
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "AppDelegate.h"
//Tool
//友盟
#import "UMCheckUpdate.h"
#import "MobClick.h"
//微信
#import "WXApi.h"
//Controller
#import "TTCLoginViewController.h"
#import "TTCProductLibViewController.h"
#import "TTCNavigationController.h"
#import "TTCFirstPageViewController.h"
#import "TTCUserLocateViewController.h"
#import "TTCShoppingCarViewController.h"
#import "TTCMeViewController.h"
#import "TTCUserLocateViewController.h"
#import "TTCUnlockViewController.h"
@interface AppDelegate()<WXApiDelegate>{
    UIBackgroundTaskIdentifier backgroundTask; //用来保存后台运行任务的标示符
}
@property (strong, nonatomic) TTCUnlockViewController *unlockVC;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@property (strong, nonatomic) NSTimer *timer;
@end
@implementation AppDelegate
#pragma mark - Init methods
#pragma mark - Life circle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self initData];
    [self createUI];
    [self displayFirstPage];
    [self notificationRecieve];
    //注册微信
    [WXApi registerApp:@"wxeaa163c839bae97e" withDescription:@"天途营销宝"];
    //注册友盟(自动更新)
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [UMCheckUpdate checkUpdate:@"检测到新版本" cancelButtonTitle:@"下次再说" otherButtonTitles:@"马上更新" appkey:@"56775df6e0f55ada1c0008bc" channel:nil];
//    [UMCheckUpdate checkUpdateWithDelegate:self selector:@selector(autoUpate:) appkey:@"56775df6e0f55ada1c0008bc" channel:nil];
    
    //获取营销人员的手势信息
    if ([[_userDefault valueForKey:@"数字密码"] boolValue] == YES || [[_userDefault valueForKey:@"手势密码"] boolValue] == YES || [[_userDefault valueForKey:@"营销人员登录状态"] isEqualToString:@"YES"]) {
        [self getLockInfoFromDataBase];
    }
    //停止延时锁屏
    [_timer invalidate];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //点击Home,若存在手势则使用手势，若不存在手势，则使用账号密码登录
    [_tabbarVC dismissViewControllerAnimated:NO completion:nil];
    if ([[_userDefault valueForKey:@"数字密码"] boolValue] == NO && [[_userDefault valueForKey:@"手势密码"] boolValue] == NO && [[_userDefault valueForKey:@"营销人员登录状态"] isEqualToString:@"NO"]) {
        //退出营销人员登录
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"营销人员退出登录" object:self userInfo:nil];
        self.window.rootViewController = _loginNVC;
    }else{
        UIApplication* app = [UIApplication sharedApplication];
        backgroundTask = [app beginBackgroundTaskWithExpirationHandler:^{
            [app endBackgroundTask:backgroundTask];
            backgroundTask = UIBackgroundTaskInvalid;
        }];
        //延迟2分钟锁屏
        _timer = [NSTimer scheduledTimerWithTimeInterval:2*60 target:self selector:@selector(delayLockView) userInfo:nil repeats:NO];
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    //停止延时锁屏
    [_timer invalidate];
    //获取营销人员的手势信息
    if ([[_userDefault valueForKey:@"数字密码"] boolValue] == YES || [[_userDefault valueForKey:@"手势密码"] boolValue] == YES) {
        [self getLockInfoFromDataBase];
    }
    [_tabbarVC showBar];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    //停止延时锁屏
    [_timer invalidate];
    //获取营销人员的手势信息
    if ([[_userDefault valueForKey:@"数字密码"] boolValue] == YES || [[_userDefault valueForKey:@"手势密码"] boolValue] == YES) {
        [self getLockInfoFromDataBase];
    }
    [_tabbarVC showBar];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    //退出进程
    if ([[_userDefault valueForKey:@"数字密码"] boolValue] == NO && [[_userDefault valueForKey:@"手势密码"] boolValue] == NO) {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"营销人员退出登录" object:self userInfo:nil];
    }else{
        self.window.rootViewController = _unlockVC;
        [_unlockVC selectLoginType];
    }
}
//延迟使用使用锁屏
- (void)delayLockView{
    [_timer invalidate];
    [self displayFirstPage];
    [_unlockVC selectLoginType];
    UIApplication* app = [UIApplication sharedApplication];
    [app endBackgroundTask:backgroundTask];
    backgroundTask = UIBackgroundTaskInvalid;
}
#pragma mark - Getters and setters
- (void)initData{
    _userDefault = [NSUserDefaults standardUserDefaults];
    //客户登录状态
    [_userDefault setValue:@"NO" forKey:@"客户登录状态"];
    [_userDefault synchronize];
    //客户信息
    _customerInfo = [CustomerInfo shareInstance];
    //注册微信
    [WXApi registerApp:@""];
}
- (void)createUI{
    //设置statusBar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //登录
    TTCLoginViewController *loginVC = [[TTCLoginViewController alloc] init];
    _loginNVC = [[TTCNavigationController alloc] initWithRootViewController:loginVC];
    //首页
    TTCFirstPageViewController *firstPageVC = [[TTCFirstPageViewController alloc] init];
    firstPageVC.appDelegate = self;
    TTCNavigationController *firstPageNVC = [[TTCNavigationController alloc] initWithRootViewController:firstPageVC];
    //产品库
    TTCProductLibViewController *productLibVC = [[TTCProductLibViewController alloc] init];
    productLibVC.canGoBack = NO;
    TTCNavigationController *libNVC = [[TTCNavigationController alloc] initWithRootViewController:productLibVC];
    //购物车
    TTCShoppingCarViewController *shoppingCarVC = [[TTCShoppingCarViewController alloc] init];
    shoppingCarVC.appDelegate = self;
    TTCNavigationController *carNVC = [[TTCNavigationController alloc] initWithRootViewController:shoppingCarVC];
    //我
    TTCMeViewController *meVC = [[TTCMeViewController alloc] init];
    meVC.appDelegate = self;
    TTCNavigationController *meNVC = [[TTCNavigationController alloc] initWithRootViewController:meVC];
    //Tabbar
    _tabbarVC = [[TTCTabbarController alloc] init];
    _tabbarVC.viewControllers = @[firstPageNVC,libNVC,carNVC,meNVC];
    //手势解锁
    _unlockVC = [[TTCUnlockViewController alloc] init];
}
#pragma mark - Event response
//接收通知
- (void)notificationRecieve{
    //营销人员登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"营销人员登录成功" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"营销人员退出登录" object:nil];
}
//通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"营销人员登录成功"]) {
        [_userDefault setObject:@"YES" forKey:@"营销人员登录状态"];
    }else if([notification.name isEqualToString:@"营销人员退出登录"]){
        [_userDefault setObject:@"NO" forKey:@"营销人员登录状态"];
        [_userDefault setObject:[NSNumber numberWithBool:NO] forKey:@"数字密码"];
        [_userDefault setObject:[NSNumber numberWithBool:NO] forKey:@"手势密码"];
    }
    [_userDefault synchronize];
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//判读显示的页面
- (void)displayFirstPage{
    //判断显示首页
    if ([[_userDefault valueForKey:@"数字密码"] boolValue] == YES || [[_userDefault valueForKey:@"手势密码"] boolValue] == YES) {
        self.window.rootViewController = _unlockVC;
        [_unlockVC selectLoginType];
    }else{
        self.window.rootViewController = _loginNVC;
    }
}
//从数据库获取当前营销人员的手势密码信息
- (void)getLockInfoFromDataBase{
    //从本地获取上一次登录的营销人员数据
    [[FMDBManager sharedInstace] selectModelArrayInDatabase:[SellManInfo sharedInstace] success:^(NSMutableArray *resultArray) {
        SellManInfo *sellInfo = [resultArray firstObject];
        [SellManInfo sharedInstace].md5PSW = sellInfo.md5PSW;
        [SellManInfo sharedInstace].mSales = sellInfo.mSales;
        [SellManInfo sharedInstace].commission = sellInfo.commission;
        [SellManInfo sharedInstace].dSales = sellInfo.dSales;
        [SellManInfo sharedInstace].ranking = sellInfo.ranking;
        [[SellManInfo sharedInstace] loadDepInfoName:sellInfo.depName ID:sellInfo.depID];
        [[SellManInfo sharedInstace] loadSellManInfoWithRequestid:sellInfo.requestid loginname:sellInfo.loginname message:sellInfo.message name:sellInfo.name password:sellInfo.password returnCode:sellInfo.returnCode];
    }];
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
}

@end
