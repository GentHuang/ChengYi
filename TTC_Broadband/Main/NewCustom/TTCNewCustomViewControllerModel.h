//
//  TTCNewCustomViewControllerModel.h
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCNewCustomViewControllerOutputModel.h"

@interface TTCNewCustomViewControllerModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *requestid;

@property (nonatomic, strong) TTCNewCustomViewControllerOutputModel *output;

@end

