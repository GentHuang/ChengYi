//
//  TTCPrintDetailViewControllerInvoiceModel.h
//  TTC_Broadband
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCPrintDetailViewControllerInvoiceOutputModel.h"
@interface TTCPrintDetailViewControllerInvoiceModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCPrintDetailViewControllerInvoiceOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
