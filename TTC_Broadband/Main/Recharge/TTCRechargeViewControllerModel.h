//
//  TTCRechargeViewControllerModel.h
//  TTC_Broadband
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCRechargeViewControllerOutputModel.h"

@interface TTCRechargeViewControllerModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCRechargeViewControllerOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
