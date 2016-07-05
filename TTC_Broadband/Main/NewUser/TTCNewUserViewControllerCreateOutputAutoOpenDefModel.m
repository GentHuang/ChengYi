//
//  TTCNewUserViewControllerCreateOutputAutoOpenDefModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/5.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCNewUserViewControllerCreateOutputAutoOpenDefModel.h"

@implementation TTCNewUserViewControllerCreateOutputAutoOpenDefModel
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
