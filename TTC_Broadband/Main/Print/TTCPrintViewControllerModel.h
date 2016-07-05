//
//  TTCPrintViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCPrintViewControllerViewOutputModel.h"

@interface TTCPrintViewControllerModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCPrintViewControllerViewOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
