//
//  TTCPrintDetailViewControllerNextInvoOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 16/1/15.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCPrintDetailViewControllerNextInvoOutputModel.h"

@implementation TTCPrintDetailViewControllerNextInvoOutputModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _id_conflict = value;
    }else{
        [super setValue:value forKey:key];
    }
}
@end


