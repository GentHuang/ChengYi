//
//  TTCUnlockViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUnlockViewController.h"
#import "TTCLoginViewController.h"
#import "AppDelegate.h"
//View
#import "TTCUnlockMainNumberView.h"
#import "TTCUnlockMainForgetNumberView.h"
#import "TTCUnlockMainForgetPermitView.h"
#import "TTCUnlockMainGestureView.h"
#import "TTCUnlockMainForgetGestureView.h"
@interface TTCUnlockViewController()<UIActionSheetDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) TTCUnlockMainNumberView *numView;
@property (strong, nonatomic) TTCUnlockMainForgetNumberView *forgetNumView;
@property (strong, nonatomic) TTCUnlockMainForgetPermitView *permitView;
@property (strong, nonatomic) LockInfo *lockInfo;
@property (strong, nonatomic) TTCUnlockMainGestureView *gestureView;
@property (strong, nonatomic) TTCUnlockMainForgetGestureView *forgetGestureView;
@end
@implementation TTCUnlockViewController
#pragma mark - Init methods
- (void)initData{
    //lockInfo
    _lockInfo = [LockInfo sharedInstace];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    __block TTCUnlockViewController *selfVC = self;
    //忘记密码验证
    _permitView = [[TTCUnlockMainForgetPermitView alloc] init];
    _permitView.alpha = 0;
    _permitView.stringBlock = ^(NSString *string){
        [selfVC permitStatus:string];
    };
    _permitView.alpha = 0;
    [self.view addSubview:_permitView];
    //数字密码解锁
    _numView = [[TTCUnlockMainNumberView alloc] init];
    _numView.alpha = 0;
    _numView.stringBlock = ^(NSString *typeString){
        [selfVC correctPSW:typeString];
    };
    [self.view addSubview:_numView];
    //忘记数字密码
    _forgetNumView = [[TTCUnlockMainForgetNumberView alloc] init];
    _forgetNumView.alpha = 0;
    _forgetNumView.stringBlock = ^(NSString *numPSW){
        [selfVC setNumPSW:numPSW];
    };
    [self.view addSubview:_forgetNumView];
    //手势密码解锁
    _gestureView = [[TTCUnlockMainGestureView alloc] init];
    _gestureView.alpha = 0;
    _gestureView.stringBlock = ^(NSString *typeString){
        [selfVC correctPSW:typeString];
    };
    [self.view addSubview:_gestureView];
    //忘记手势密码
    _forgetGestureView = [[TTCUnlockMainForgetGestureView alloc] init];
    _forgetGestureView.alpha = 0;
    _forgetGestureView.stringBlock = ^(NSString *numPSW){
        [selfVC setGesturePSW:numPSW];
    };
    [self.view addSubview:_forgetGestureView];
    //使用账号密码登录
    _actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"使用账号密码登录" otherButtonTitles:@"取消", nil];
    [self.view addSubview:_actionSheet];
    //选择登录方式
    [self selectLoginType];
}
- (void)setSubViewLayout{
    //忘记密码验证
    [_permitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    //数字密码解锁
    [_numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    //忘记数字密码
    [_forgetNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    //手势密码解锁
    [_gestureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    //忘记手势密码
    [_forgetGestureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)correctPSW:(NSString *)typeString{
    if ([typeString isEqualToString:@"数字密码登录成功"] || [typeString isEqualToString:@"手势密码登录成功"]) {
        AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
        appdelegate.window.rootViewController = appdelegate.tabbarVC;
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if([typeString isEqualToString:@"改变登录方式"]){
        [_actionSheet showInView:self.view];
    }else if([typeString isEqualToString:@"忘记密码"]){
        [self.view bringSubviewToFront:_permitView];
        [UIView animateWithDuration:0.5 animations:^{
            _permitView.alpha = 1;
        }];
    }
}
//忘记密码验证状态
- (void)permitStatus:(NSString *)status{
    if ([status isEqualToString:@"验证成功"]) {
        //判断使用哪种手势登录
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if ([[userDefault valueForKey:@"数字密码"] boolValue] == YES) {
            //数字密码
            [self.view bringSubviewToFront:_forgetNumView];
            [UIView animateWithDuration:0.5 animations:^{
                _forgetNumView.alpha = 1;
                _permitView.alpha = 0;
            }];
        }else{
            //手势密码
            [self.view bringSubviewToFront:_forgetGestureView];
            [UIView animateWithDuration:0.5 animations:^{
                _forgetGestureView.alpha = 1;
                _permitView.alpha = 0;
            }];
        }
    }else if([status isEqualToString:@"验证失败"]){
        //验证失败
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"更改密码验证失败，请检查账号和密码是否正确" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }
}
//更改数字密码
- (void)setNumPSW:(NSString *)numPSW{
    //存储数字密码信息
    [_lockInfo loadName:[SellManInfo sharedInstace].loginname psw:[SellManInfo sharedInstace].md5PSW];
    _lockInfo.numPSW = [numPSW MD5Digest];
    _lockInfo.firstNum = @"NO";
    [[FMDBManager sharedInstace] creatTable:_lockInfo];
    [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:_lockInfo withCheckNum:2];
    _forgetNumView.alpha = 0;
    _numView.alpha = 1;
}
//设置手势密码
- (void)setGesturePSW:(NSString *)gesturePSW{
    //存储手势密码信息
    [_lockInfo loadName:[SellManInfo sharedInstace].loginname psw:[SellManInfo sharedInstace].md5PSW];
    _lockInfo.gesturePSW = [gesturePSW MD5Digest];
    _lockInfo.firstGesture = @"NO";
    [[FMDBManager sharedInstace] creatTable:_lockInfo];
    [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:_lockInfo withCheckNum:2];
    _forgetGestureView.alpha = 0;
    _gestureView.alpha = 1;
}
#pragma mark - Data request
#pragma mark - Protocol methods
//UIActionSheetDelegate Method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //跳转到账户密码登录
        AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
        appdelegate.window.rootViewController = appdelegate.loginNVC;
        self.modalPresentationStyle=UIModalPresentationPopover;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - Other methods
//选择登录方式
- (void)selectLoginType{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([[userDefault valueForKey:@"数字密码"] boolValue] == YES) {
        //数字密码
        [self.view bringSubviewToFront:_numView];
        _numView.alpha = 1;
        _gestureView.alpha = 0;
    }else{
        //手势密码
        //数字密码
        [self.view bringSubviewToFront:_gestureView];
        _numView.alpha = 0;
        _gestureView.alpha = 1;
    }
}
@end
