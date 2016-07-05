//
//  TTCConfigViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCConfigViewController.h"
#import "TTCTabbarController.h"
#import "TTCNavigationController.h"
#import "TTCResponseViewController.h"
#import "TTCFunctionViewController.h"
#import "TTCAboutViewController.h"
//View
#import "TTCConfigViewCell.h"
@interface TTCConfigViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *cellNameArray;
@property (strong, nonatomic) NSArray *cellImageArray;
@property (strong, nonatomic) UIScrollView *startView;
@end
@implementation TTCConfigViewController
#pragma mark - Init methods
- (void)initData{
    _cellNameArray = @[@"清除缓存",@"功能介绍",@"反馈",@"关于APP"];
    _cellImageArray = @[[UIImage imageNamed:@"config_img1"],[UIImage imageNamed:@"config_img2"],[UIImage imageNamed:@"config_img3"],[UIImage imageNamed:@"config_img4"]];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = LIGHTGRAY;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCConfigViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"设置"];
}
#pragma mark - Event response
//立即体验
- (void)startButtonPressed{
    [UIView animateWithDuration:0.1 animations:^{
        [self setNavigationBar];
        TTCTabbarController *tab = (TTCTabbarController *)self.tabBarController;
        [tab showBar];
        _startView.frame = CGRectMake(0, SCREEN_MAX_Height, SCREEN_MAX_WIDTH, SCREEN_MAX_Height);
    } completion:^(BOOL finished) {
        [_startView removeFromSuperview];
    }];
    [UIView commitAnimations];
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCConfigViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadTitleName:_cellNameArray[indexPath.row]];
    [cell loadImage:_cellImageArray[indexPath.row]];
    return cell;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            //清理缓存
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清理缓存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alView show];
        }
            break;
        case 1:{
            //功能介绍
            [self useStartPage];
        }
            break;
        case 2:{
            //反馈
            TTCResponseViewController *responseVC = [[TTCResponseViewController alloc] init];
            [self.navigationController pushViewController:responseVC animated:YES];
        }
            break;
        case 3:{
            //关于APP
            TTCAboutViewController *aboutVC = [[TTCAboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存清理成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alView show];
    }
}
//UIScrollViewDelegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == _startView){
        //滚动结束
        if (scrollView.contentOffset.x > 2400) {
            [UIView animateWithDuration:0.1 animations:^{
                scrollView.frame = CGRectMake(-SCREEN_MAX_WIDTH, 0, SCREEN_MAX_WIDTH, SCREEN_MAX_Height);
                TTCTabbarController *tab = (TTCTabbarController *)self.tabBarController;
                [tab showBar];
                [self setNavigationBar];
            } completion:^(BOOL finished) {
                [scrollView removeFromSuperview];
            }];
            [UIView commitAnimations];
        }
    }
}
#pragma mark - Other methods
//启动画面
- (void)useStartPage{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc hideBar];
    TTCTabbarController *tab = (TTCTabbarController *)self.tabBarController;
    [tab hideBar];
    _startView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_MAX_WIDTH, SCREEN_MAX_Height)];
    _startView.delegate = self;
    _startView.showsHorizontalScrollIndicator = NO;
    _startView.pagingEnabled = YES;
    _startView.contentSize = CGSizeMake(SCREEN_MAX_WIDTH*4, SCREEN_MAX_Height);
    NSArray *imageArray = @[[UIImage imageNamed:@"start_img1"],[UIImage imageNamed:@"start_img2"],[UIImage imageNamed:@"start_img3"],[UIImage imageNamed:@"start_img4"]];
    for (int i = 0; i < imageArray.count; i ++) {
        UIImageView *allImageView = [[UIImageView alloc] initWithImage:imageArray[i]];
        allImageView.userInteractionEnabled = YES;
        allImageView.frame = CGRectMake(i*SCREEN_MAX_WIDTH, 0, SCREEN_MAX_WIDTH, SCREEN_MAX_Height);
        [_startView addSubview:allImageView];
        if (i == imageArray.count - 1) {
            UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
            startButton.center = CGPointMake(SCREEN_MAX_WIDTH/2, 870);
            startButton.bounds = CGRectMake(0, 0, 200, 50);
            startButton.backgroundColor = CLEAR;
            [startButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [allImageView addSubview:startButton];
        }
    }
    [self.view addSubview:_startView];
    [self.view bringSubviewToFront:_startView];
}
@end
