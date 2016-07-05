//
//  TTCUserLocateViewController.h
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"
#import "AppDelegate.h"
@interface TTCUserLocateViewController : TTCParentViewController
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (assign, nonatomic) BOOL isUserDetail;
@property (assign, nonatomic) BOOL isProductOrder;
@property (assign, nonatomic) BOOL isProductDetail;
@property (assign, nonatomic) BOOL isSetOrder;
@property (assign, nonatomic) BOOL isPayDebt;
@property (assign, nonatomic) BOOL isCheckOrder;
@property (assign, nonatomic) BOOL isShoppingCar;
@property (assign, nonatomic) BOOL isPrint;
@property (assign, nonatomic) BOOL canGoBack;

//add
@property (strong, nonatomic) NSString *scanString;
@end
