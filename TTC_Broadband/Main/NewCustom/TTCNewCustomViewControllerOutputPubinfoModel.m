//
//  TTCNewCustomViewControllerOutputPubinfoModel.m
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCNewCustomViewControllerOutputPubinfoModel.h"

@implementation TTCNewCustomViewControllerOutputPubinfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _id_conflict = [value integerValue];
    }else{
        [super setValue:value forKey:key];
    }
}
@end


