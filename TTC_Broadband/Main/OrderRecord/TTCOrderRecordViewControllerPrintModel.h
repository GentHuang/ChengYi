//
//  TTCOrderRecordViewControllerPrintModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCOrderRecordViewControllerPrintOutputModel.h"
@interface TTCOrderRecordViewControllerPrintModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCOrderRecordViewControllerPrintOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
