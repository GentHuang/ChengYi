//
//  TTCSellDetailMonthViewControllerOdsModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailMonthViewControllerOdsModel.h"

@implementation TTCSellDetailMonthViewControllerOdsModel
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
