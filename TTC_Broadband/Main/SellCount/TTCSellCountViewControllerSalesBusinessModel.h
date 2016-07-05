//
//  TTCSellCountViewControllerSalesBusinessModel.h
//  TTC_Broadband
//
//  Created by apple on 16/4/7.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TTCSellCountViewControllerSalesBusinessOutputModel.h"
@interface TTCSellCountViewControllerSalesBusinessModel : NSObject

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDictionary *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;

@end

@interface TTCSellCountViewControllerSalesBusinessOutputModel : NSObject

@property (strong, nonatomic) NSString *broad;
@property (strong, nonatomic) NSString *figure;
@property (strong, nonatomic) NSString *interact;

@end