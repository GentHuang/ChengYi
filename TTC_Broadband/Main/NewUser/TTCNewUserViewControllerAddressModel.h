//
//  TTCNewUserViewControllerAddressModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/28.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCNewUserViewControllerAddressOutputModel.h"

@interface TTCNewUserViewControllerAddressModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCNewUserViewControllerAddressOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;
@end
