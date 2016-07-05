//
//  TTCUserLocateViewControllerModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCUserLocateViewControllerOutputModel.h"
@interface TTCUserLocateViewControllerModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSMutableArray *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
