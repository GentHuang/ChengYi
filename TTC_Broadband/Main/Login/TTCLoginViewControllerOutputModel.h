//
//  TTCLoginViewControllerOutputModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TTCLoginViewControllerOutputModel : NSObject
@property (strong, nonatomic) NSMutableArray *depinfo;
@property (strong, nonatomic) NSString *loginname;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *returnCode;
@end
