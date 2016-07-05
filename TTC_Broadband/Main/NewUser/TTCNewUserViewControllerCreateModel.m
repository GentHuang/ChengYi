//
//  TTCNewUserViewControllerCreateModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/5.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCNewUserViewControllerCreateModel.h"

@implementation TTCNewUserViewControllerCreateModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"output"]) {
        _output = [[TTCNewUserViewControllerCreateOutputModel alloc] init];
        [_output setValuesForKeysWithDictionary:value];
    }else{
        [super setValue:value forKey:key];
    }
}

@end
