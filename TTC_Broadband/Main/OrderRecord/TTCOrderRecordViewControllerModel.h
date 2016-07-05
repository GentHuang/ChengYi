//
//  TTCOrderRecordViewControllerModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCOrderRecordViewControllerOutputModel.h"

@interface TTCOrderRecordViewControllerModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCOrderRecordViewControllerOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
