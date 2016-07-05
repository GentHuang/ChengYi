//
//  TTCAddAddressViewControllerModel.h
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCAddAddressViewControllerOutputModel.h"
@interface TTCAddAddressViewControllerModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *requestid;

@property (nonatomic, strong) TTCAddAddressViewControllerOutputModel *output;

@end
