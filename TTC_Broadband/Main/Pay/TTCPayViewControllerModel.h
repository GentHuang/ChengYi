//
//  TTCPayViewControllerModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCPayViewControllerOutputModel.h"

@interface TTCPayViewControllerModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCPayViewControllerOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
