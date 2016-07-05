//
//  TTCRechargeViewControllerOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCRechargeViewControllerOutputModel.h"

@implementation TTCRechargeViewControllerOutputModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
@end
