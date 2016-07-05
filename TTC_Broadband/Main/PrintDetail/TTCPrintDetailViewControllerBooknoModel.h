//
//  TTCPrintDetailViewControllerBooknoModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCPrintDetailViewControllerBooknoOutputModel.h"
@interface TTCPrintDetailViewControllerBooknoModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCPrintDetailViewControllerBooknoOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
