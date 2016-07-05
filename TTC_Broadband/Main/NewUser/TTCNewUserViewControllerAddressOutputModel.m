//
//  TTCNewUserViewControllerAddressOutputModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/28.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCNewUserViewControllerAddressOutputModel.h"
#import "TTCNewUserViewControllerAddressOutputHouseModel.h"

@implementation TTCNewUserViewControllerAddressOutputModel
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
            TTCNewUserViewControllerAddressOutputHouseModel *houseModel = [[TTCNewUserViewControllerAddressOutputHouseModel alloc] init];
            [houseModel setValuesForKeysWithDictionary:dic];
            [_houses addObject:houseModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
