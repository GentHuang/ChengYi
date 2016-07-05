//
//  TTCLoginViewControllerModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCLoginViewControllerOutputModel.h"

@interface TTCLoginViewControllerModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCLoginViewControllerOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
