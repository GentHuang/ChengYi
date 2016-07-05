//
//  TTCUserNewAccoutResultSearchOutModel.h
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCUserNewAccountResultSearchOutputModel.h"

@interface TTCUserNewAccoutResultSearchModel : NSObject
@property (strong , nonatomic) NSString *message;
@property (strong , nonatomic) TTCUserNewAccountResultSearchOutputModel *output;
@property (strong , nonatomic) NSString *requestid;
@property (strong , nonatomic) NSString *status;

@end
