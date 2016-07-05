//
//  TTCLockViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCLockViewController.h"
#import "TTCNavigationController.h"
#import "TTCTabbarController.h"
#import "AppDelegate.h"
//View
#import "TTCLockViewControllerCell.h"
#import "TTCLockViewSetNumView.h"
#import "TTCLockViewSetGestureView.h"
@interface TTCLockViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *cellNameArray;
@property (strong, nonatomic) NSMutableArray *cellStatusArray;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) LockInfo *lockInfo;
@property (strong, nonatomic) TTCLockViewSetNumView *setNumView;
@property (strong, nonatomic) TTCNavigationController *nvc;
@property (strong, nonatomic) TTCTabbarController *tabBarVC;
@property (strong, nonatomic) TTCLockViewSetGestureView *setGestureView;
@property (assign, nonatomic) BOOL isLoad;
@end
@implementation TTCLockViewController
#pragma mark - Init methods
- (void)initData{
    //Cell名
    _cellNameArray = @[@"数字密码",@"手势密码"];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
    //Cell状态
    _cellStatusArray = [NSMutableArray array];
    BOOL isOn = NO;
    for (int i = 0; i < _cellNameArray.count; i ++) {
        switch (i) {
            case 0:{
                if ([_userDefault valueForKey:@"数字密码"]) {
                    [_cellStatusArray addObject:[_userDefault valueForKey:@"数字密码"]];
                }else{
                    [_cellStatusArray addObject:[NSNumber numberWithBool:isOn]];
                }
            }
                break;
            case 1:{
                if ([_userDefault valueForKey:@"手势密码"]) {
                    [_cellStatusArray addObject:[_userDefault valueForKey:@"手势密码"]];
                }else{
                    [_cellStatusArray addObject:[NSNumber numberWithBool:isOn]];
                }
            }
                break;
            default:
                break;
        }
    }
    //lockInfo
    _lockInfo = [LockInfo sharedInstace];
    //tabBar
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    _tabBarVC = (TTCTabbarController *)appDelegate.tabbarVC;
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
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    _isLoad = NO;
    __block TTCLockViewController *selfVC = self;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TTCLockViewControllerCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //数字密码设置界面
    _setNumView = [[TTCLockViewSetNumView alloc] init];
    _setNumView.alpha = 0;
    _setNumView.stringBlock = ^(NSString *numPSW){
        [selfVC setNumPSW:numPSW];
    };
    _setNumView.backBlock = ^(NSString *backString){
        [selfVC numBack];
    };
    [self.view addSubview:_setNumView];
    //手势密码设置界面
    _setGestureView = [[TTCLockViewSetGestureView alloc] init];
    _setGestureView.alpha = 0;
    _setGestureView.stringBlock = ^(NSString *numPSW){
        [selfVC setGesturePSW:numPSW];
    };
    _setGestureView.backBlock = ^(NSString *backString){
        [selfVC gettureBack];
    };
    [self.view addSubview:_setGestureView];
    
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
    //数字密码设置界面
    [_setNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    //手势密码设置界面
    [_setGestureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (void)setNavigationBar{
    _nvc = (TTCNavigationController *)self.navigationController;
    [_nvc selectNavigationType:kProductDetailType];
    [_nvc loadHeaderTitle:@"设备安全锁"];
}
#pragma mark - Event response
//点击开关
- (void)switchPressed:(NSIndexPath *)indexPath{
        BOOL isON;
        if (indexPath.row == 0) {
            //判断是否首次使用数字密码
            if (![_lockInfo.firstNum isEqualToString:@"NO"]) {
                [_nvc hideBar];
                [_tabBarVC hideBar];
                //进行首次数字密码设置
                [self.view bringSubviewToFront:_setNumView];
                [UIView animateWithDuration:0.5 animations:^{
                    _setNumView.alpha = 1;
                }];
                [UIView commitAnimations];
            }else{
                //开启或关闭数字密码
                isON = ![_cellStatusArray[indexPath.row] boolValue];
                [_userDefault setValue:[NSNumber numberWithBool:isON] forKey:@"数字密码"];
                _cellStatusArray[indexPath.row] = [NSNumber numberWithBool:isON];
                isON = NO;
                [_userDefault setValue:[NSNumber numberWithBool:isON] forKey:@"手势密码"];
                _cellStatusArray[1] = [NSNumber numberWithBool:isON];
            }
        }else if(indexPath.row == 1){
            //判断是否首次使用数字密码
            if (![_lockInfo.firstGesture isEqualToString:@"NO"]) {
                [_nvc hideBar];
                [_tabBarVC hideBar];
                //进行首次数字密码设置
                [self.view bringSubviewToFront:_setGestureView];
                [UIView animateWithDuration:0.5 animations:^{
                    _setGestureView.alpha = 1;
                }];
                [UIView commitAnimations];
            }else{
                //开启或关闭手势密码
                isON = ![_cellStatusArray[indexPath.row] boolValue];
                [_userDefault setValue:[NSNumber numberWithBool:isON] forKey:@"手势密码"];
                _cellStatusArray[indexPath.row] = [NSNumber numberWithBool:isON];
                isON = NO;
                [_userDefault setValue:[NSNumber numberWithBool:isON] forKey:@"数字密码"];
                _cellStatusArray[0] = [NSNumber numberWithBool:isON];
            }
            
        }
        [_userDefault synchronize];
        [_tableView reloadData];
}
//设置数字密码
- (void)setNumPSW:(NSString *)numPSW{
    _setNumView.alpha = 0;
    [_nvc selectNavigationType:kProductDetailType];
//    [_tabBarVC showBar];
    
    //首次进来才执行自动开启开关
      BOOL isON;
    if(![_lockInfo.firstNum isEqualToString:@"NO"]){
    isON = ![_cellStatusArray[0] boolValue];
    [_userDefault setValue:[NSNumber numberWithBool:isON] forKey:@"数字密码"];
    _cellStatusArray[0] = [NSNumber numberWithBool:isON];
    }
    //存储数字密码信息
    [_lockInfo loadName:[SellManInfo sharedInstace].loginname psw:[SellManInfo sharedInstace].md5PSW];
    _lockInfo.numPSW = [numPSW MD5Digest];
    _lockInfo.firstNum = @"NO";
    //下次进入就是修改密码
    _lockInfo.isChangePSW = @"YES";
    [[FMDBManager sharedInstace] creatTable:_lockInfo];
    [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:_lockInfo withCheckNum:2];
    
    //开启或关闭数字密码
    isON = NO;
    [_userDefault setValue:[NSNumber numberWithBool:isON] forKey:@"手势密码"];
    _cellStatusArray[1] = [NSNumber numberWithBool:isON];
    [_tableView reloadData];
}
//设置手势密码
- (void)setGesturePSW:(NSString *)gesturePSW{
    _setGestureView.alpha = 0;
    [_nvc selectNavigationType:kProductDetailType];
//    [_tabBarVC showBar];
    BOOL isON;
    if(![_lockInfo.firstNum isEqualToString:@"NO"]){
        isON = ![_cellStatusArray[1] boolValue];
        [_userDefault setValue:[NSNumber numberWithBool:isON] forKey:@"手势密码"];
        _cellStatusArray[1] = [NSNumber numberWithBool:isON];
    }
    
    //存储手势密码信息
    [_lockInfo loadName:[SellManInfo sharedInstace].loginname psw:[SellManInfo sharedInstace].md5PSW];
    _lockInfo.gesturePSW = [gesturePSW MD5Digest];
    _lockInfo.firstGesture = @"NO";
    _lockInfo.isChangeGesture = @"YES";
    [[FMDBManager sharedInstace] creatTable:_lockInfo];
    [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:_lockInfo withCheckNum:2];
    //开启或关闭手势密码
    isON = NO;
    [_userDefault setValue:[NSNumber numberWithBool:isON] forKey:@"数字密码"];
    _cellStatusArray[0] = [NSNumber numberWithBool:isON];
    [_tableView reloadData];
}
//数字后退
- (void)numBack{
    [_nvc selectNavigationType:kProductDetailType];
//    [_tabBarVC showBar];
}
//手势后退
- (void)gettureBack{
    [_nvc selectNavigationType:kProductDetailType];
//    [_tabBarVC showBar];
}
#pragma mark - Data request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCLockViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __block TTCLockViewController *selfVC = self;
    cell.indexBlock = ^(NSInteger index){
        [selfVC switchPressed:indexPath];
    };
    //加载标题
    [cell loadTitleName:_cellNameArray[indexPath.row]];
    //加载Cell状态
    [cell isON:[_cellStatusArray[indexPath.row] boolValue]];
    return cell;
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //判断是否首次使用数字密码
        [_nvc hideBar];
        [_tabBarVC hideBar];
        //进行首次数字密码设置
        [self.view bringSubviewToFront:_setNumView];
        [UIView animateWithDuration:0.5 animations:^{
            _setNumView.alpha = 1;
        }];
        [UIView commitAnimations];
        
    }else if(indexPath.row == 1){
        //判断是否首次使用数字密码
        [_nvc hideBar];
        [_tabBarVC hideBar];
        //进行首次数字密码设置
        [self.view bringSubviewToFront:_setGestureView];
        [UIView animateWithDuration:0.5 animations:^{
            _setGestureView.alpha = 1;
        }];
        [UIView commitAnimations];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103/2;
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 500;
}
#pragma mark - Other methods
@end
