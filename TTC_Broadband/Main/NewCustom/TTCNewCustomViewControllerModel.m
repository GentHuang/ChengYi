//
//  TTCNewCustomViewControllerModel.m
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCNewCustomViewControllerModel.h"

@implementation TTCNewCustomViewControllerModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
   if([key isEqualToString:@"output"]){
        _output = [[TTCNewCustomViewControllerOutputModel alloc] init];
        [_output setValuesForKeysWithDictionary:value];
    }else{
        [super setValue:value forKey:key];
    }
}
@end


