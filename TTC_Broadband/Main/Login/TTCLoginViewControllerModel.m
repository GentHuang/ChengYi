//
//  TTCLoginViewControllerModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCLoginViewControllerModel.h"
@implementation TTCLoginViewControllerModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"output"]) {
        _output = [[TTCLoginViewControllerOutputModel alloc] init];
        [_output setValuesForKeysWithDictionary:value];
    }else{
        [super setValue:value forKey:key];
    }
}
@end
