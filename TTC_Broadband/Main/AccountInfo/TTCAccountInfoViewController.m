//
//  TTCAccountInfoViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCAccountInfoViewController.h"
#import "TTCNavigationController.h"
//View
#import "TTCAccountInfoViewCell.h"
//Model
#import "TTCUserLocateViewControllerBalanceOutputFeebooksModel.h"
@interface TTCAccountInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end
@implementation TTCAccountInfoViewController
#pragma mark - Init methods
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
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
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCAccountInfoViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO-20);
        make.left.right.bottom.mas_equalTo(0);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc loadHeaderTitle:@"账本信息"];
    
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_allAccountInfoArray.count > 0) {
        return _allAccountInfoArray.count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCAccountInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    TTCUserLocateViewControllerBalanceOutputFeebooksModel *feeModel = _allAccountInfoArray[indexPath.row];
    [cell loadAccountInfoWithFbfees:feeModel.fbfees fbid:feeModel.fbid fbname:feeModel.fbname fbtype:feeModel.fbtype];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190/2;
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 26/2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
#pragma mark - Other methods
@end
