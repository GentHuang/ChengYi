//
//  TTCPayViewControllerOrderModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPayViewControllerOrderModel.h"

@implementation TTCPayViewControllerOrderModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"output"]) {
        _output = [[TTCPayViewControllerOrderOutputModel alloc] init];
        [_output setValuesForKeysWithDictionary:value];
    }else{
        [super setValue:value forKey:key];
    }
}
@end
