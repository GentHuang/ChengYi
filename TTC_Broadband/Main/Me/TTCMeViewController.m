//
//  TTCMeViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCMeViewController.h"
#import "TTCNavigationController.h"
#import "TTCConfigViewController.h"
#import "TTCLoginViewController.h"
#import "AppDelegate.h"
#import "TTCLockViewController.h"
#import "TTCSellCountViewController.h"
#import "TTCRankViewController.h"
//View
#import "TTCMeViewCell.h"
@interface TTCMeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *cellNameArray;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) NSArray *cellImageArray;
@end

@implementation TTCMeViewController
#pragma mark - Init methods
- (void)initData{
    _cellNameArray = @[@"设备安全锁",@"设置"];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
    //图片
    _cellImageArray = @[[UIImage imageNamed:@"me_img_lock"],[UIImage imageNamed:@"me_img_set"]];
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
    if (_tableView) {
        [_tableView reloadData];
    }
    //显示tab
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
    [tab showBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = LIGHTGRAY;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCMeViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_FIRST-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nav = (TTCNavigationController *)self.navigationController;
    [nav selectNavigationType:KMeType];
    [nav loadHeaderTitle:@"我"];
    NSArray *infoArray = @[[SellManInfo sharedInstace].name,[NSString stringWithFormat:@"工号:%@",[SellManInfo sharedInstace].loginname],[SellManInfo sharedInstace].depName];
    [nav loadMeInformation:infoArray];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    //返回登录界面
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.loginNVC popViewControllerAnimated:NO];
    if (appDelegate.window.rootViewController == appDelegate.tabbarVC) {
        [appDelegate.tabbarVC presentViewController:appDelegate.loginNVC animated:YES completion:nil];
    }else{
        [appDelegate.tabbarVC dismissViewControllerAnimated:YES completion:nil];
    }
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"营销人员退出登录" object:self userInfo:nil];
}
//点击顶部按钮
- (void)headerButtonPressed:(NSString *)string{
    int selectedIndex = [string intValue];
    switch (selectedIndex) {
        case 0:{
            //销售统计
            TTCSellCountViewController *sellCountVC = [[TTCSellCountViewController alloc] init];
            [self.navigationController pushViewController:sellCountVC animated:YES];
        }
            break;
        case 1:{
            //排行榜
            TTCRankViewController *rankVC = [[TTCRankViewController alloc] init];
            [self.navigationController pushViewController:rankVC animated:YES];
        }
            break;
        default:
            break;
    };
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return _cellNameArray.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block TTCMeViewController *selfVC = self;
    TTCMeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        //顶部模式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell selectCellType:kFirstType];
        cell.stringBlock = ^(NSString *string){
            [selfVC headerButtonPressed:string];
        };
    }else if (indexPath.section == 1) {
        //其他模式
        [cell selectCellType:kOtherType];
        [cell loadTitleName:_cellNameArray[indexPath.row]];
        [cell loadCellImageWithImage:_cellImageArray[indexPath.row]];
        if (indexPath.row == 0) {
            [cell hideIsUsed:NO];
        }else{
            [cell hideIsUsed:YES];
        }
        if ([[_userDefault valueForKey:@"数字密码"] boolValue] == NO && [[_userDefault valueForKey:@"手势密码"] boolValue] == NO) {
            [cell isUsed:NO];
        }else{
            [cell isUsed:YES];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //顶部模式
        return 264/2;
    }else{
        //其他模式
        return 75;
    }
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 500;
    }else{
        return 12;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *backView = [[UIView alloc] init];
        //退出账号
        UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        quitButton.backgroundColor = DARKBLUE;
        [quitButton setTitle:@"退出账号" forState:UIControlStateNormal];
        [quitButton setTitleColor:WHITE forState:UIControlStateNormal];
        [quitButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        quitButton.titleLabel.font = FONTSIZESBOLD(52/2);
        quitButton.layer.masksToBounds = YES;
        quitButton.layer.cornerRadius = 4;
        [backView addSubview:quitButton];
        [quitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backView.mas_centerX);
            make.top.mas_equalTo(90/2);
            make.width.mas_equalTo(628/2);
            make.height.mas_equalTo(120/2);
        }];
        return backView;
    }else{
        return [UIView new];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            TTCConfigViewController *configVC = [[TTCConfigViewController alloc] init];
            [self.navigationController pushViewController:configVC animated:YES];
        }else{
            TTCLockViewController *lockVC = [[TTCLockViewController alloc] init];
            [self.navigationController pushViewController:lockVC animated:YES];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
#pragma mark - Other methods
@end
