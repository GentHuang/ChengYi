//
//  TTCPrintDetailViewControllerNextInvoModel.h
//  TTC_Broadband
//
//  Created by apple on 16/1/15.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCPrintDetailViewControllerNextInvoOutputModel.h"

@interface TTCPrintDetailViewControllerNextInvoModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCPrintDetailViewControllerNextInvoOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
