//
//  TTCNewUserViewControllerCreateModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/5.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCNewUserViewControllerCreateOutputModel.h"
@interface TTCNewUserViewControllerCreateModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCNewUserViewControllerCreateOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;

@end
