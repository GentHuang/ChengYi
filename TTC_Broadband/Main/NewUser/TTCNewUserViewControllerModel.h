//
//  TTCNewUserViewControllerModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/6.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCNewUserViewControllerOutputModel.h"

@interface TTCNewUserViewControllerModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCNewUserViewControllerOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
