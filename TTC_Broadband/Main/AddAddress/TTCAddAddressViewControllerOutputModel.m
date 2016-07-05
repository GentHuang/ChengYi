//
//  TTCAddAddressViewControllerOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCAddAddressViewControllerOutputModel.h"
#import "TTCAddAddressViewControllerOutputHouseModel.h"

@implementation TTCAddAddressViewControllerOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _houses = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"houses"]) {
        for (NSDictionary *dic in value) {
            TTCAddAddressViewControllerOutputHouseModel *houseModel = [[TTCAddAddressViewControllerOutputHouseModel alloc] init];
            [houseModel setValuesForKeysWithDictionary:dic];
            [_houses addObject:houseModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end


