//
//  TTCUserLocateViewControllerBalanceModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCUserLocateViewControllerBalanceOutputModel.h"
@interface TTCUserLocateViewControllerBalanceModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCUserLocateViewControllerBalanceOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
