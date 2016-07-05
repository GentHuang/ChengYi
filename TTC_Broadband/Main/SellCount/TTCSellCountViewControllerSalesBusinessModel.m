//
//  TTCSellCountViewControllerSalesBusinessModel.m
//  TTC_Broadband
//
//  Created by apple on 16/4/7.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCSellCountViewControllerSalesBusinessModel.h"

@implementation TTCSellCountViewControllerSalesBusinessModel

- (instancetype)init {
    if (self= [super init]) {
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key=nil;
}
- (id)valueForUndefinedKey:(NSString *)key {
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}
@end


@implementation TTCSellCountViewControllerSalesBusinessOutputModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key=nil;
}
- (id)valueForUndefinedKey:(NSString *)key {
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}
@end