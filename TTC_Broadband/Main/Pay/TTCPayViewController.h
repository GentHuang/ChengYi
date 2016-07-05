//
//  TTCPayViewController.h
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"
//Model
#import "TTCProductDetailViewControllerModel.h"
@interface TTCPayViewController : TTCParentViewController
@property (assign, nonatomic) float selectedCount;
@property (assign, nonatomic) BOOL isDebtPay;
@property (assign, nonatomic) BOOL isOrderPay;
@property (assign, nonatomic) BOOL isCarPay;

@property (strong, nonatomic) NSArray *carDataArray;
@property (strong, nonatomic) NSArray *orderDataArray;

@property (strong, nonatomic) NSString *keyno;
@property (strong, nonatomic) NSString *priceCount;
@property (strong, nonatomic) NSArray *allServsArray;
@property (strong, nonatomic) TTCProductDetailViewControllerModel *vcModel;
@end
