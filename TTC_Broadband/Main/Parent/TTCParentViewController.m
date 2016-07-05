//
//  TTCParentViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"
#import "TTCNavigationController.h"
#import "TTCTabbarController.h"
@interface TTCParentViewController ()

@end

@implementation TTCParentViewController
#pragma mark - Init methods
#pragma mark - Life circle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏tabbar
//    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
//    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
//    [tab hideBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LIGHTGRAY;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Getters and setters
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
@end
