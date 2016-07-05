//
//  TTCModifiedDataViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCModifiedDataViewController.h"
#import "TTCNavigationController.h"
//View
#import "TTCModifiedDataMainView.h"
@interface TTCModifiedDataViewController ()
@property (strong, nonatomic) TTCModifiedDataMainView *mainView;
@end

@implementation TTCModifiedDataViewController
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
    __block TTCModifiedDataViewController *weakSelf = self;
    //mainView
    _mainView = [[TTCModifiedDataMainView alloc] init];
    _mainView.stringBlock = ^(NSString *string){
        [weakSelf buttonPressed];
    };
    //加载数据
    CustomerInfo *customerInfo = [CustomerInfo shareInstance];
    [_mainView loadWithCustname:customerInfo.custname custid:customerInfo.custid mobile:customerInfo.mobile addr:customerInfo.addr cardtype:customerInfo.cardtype icno:customerInfo.icno markno:customerInfo.markno cardno:customerInfo.cardno pgroupname:customerInfo.pgroupname phone:customerInfo.phone custtype:customerInfo.custtype areaname:customerInfo.areaname];
    [self.view addSubview:_mainView];
}
- (void)setSubViewLayout{
    //mainView
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
    
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc loadHeaderTitle:@"客户资料"];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
@end
