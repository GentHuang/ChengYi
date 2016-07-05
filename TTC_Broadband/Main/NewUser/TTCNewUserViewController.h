//
//  TTCNewUserViewController.h
//  TTC_Broadband
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"
//Model
#import "TTCAddAddressViewControllerOutputHouseModel.h"
@interface TTCNewUserViewController : TTCParentViewController
@property (strong, nonatomic) NSString *scanString;
//客户宽带号
@property (strong, nonatomic) NSString *broadAccountString;
@property (strong, nonatomic) TTCAddAddressViewControllerOutputHouseModel *houseModel;
@end
