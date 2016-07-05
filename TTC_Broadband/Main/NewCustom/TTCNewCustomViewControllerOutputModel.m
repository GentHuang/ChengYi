//
//  TTCNewCustomViewControllerOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCNewCustomViewControllerOutputModel.h"

@implementation TTCNewCustomViewControllerOutputModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _id_conflict = [value integerValue];
    }else if([key isEqualToString:@"pubinfo"]){
        _pubinfo = [[TTCNewCustomViewControllerOutputPubinfoModel alloc] init];
        [_pubinfo setValuesForKeysWithDictionary:value];
    }else{
        [super setValue:value forKey:key];
    }
}
@end


