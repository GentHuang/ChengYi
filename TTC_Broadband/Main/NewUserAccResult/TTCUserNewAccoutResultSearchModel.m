//
//  TTCUserNewAccoutResultSearchOutModel.m
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCUserNewAccoutResultSearchModel.h"

@implementation TTCUserNewAccoutResultSearchModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"output"]) {
        _output = [[TTCUserNewAccountResultSearchOutputModel alloc] init];
        [_output setValuesForKeysWithDictionary:value];
    }else{
        [super setValue:value forKey:key];
    }
}
@end
