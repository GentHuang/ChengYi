//
//  TTCAddCustAddrViewControllerOutputModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCAddCustAddrViewControllerOutputModel.h"
#import "TTCAddCustAddrViewControllerOutputHouseModel.h"

@implementation TTCAddCustAddrViewControllerOutputModel
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
            TTCAddCustAddrViewControllerOutputHouseModel *houseModel = [[TTCAddCustAddrViewControllerOutputHouseModel alloc] init];
            [houseModel setValuesForKeysWithDictionary:dic];
            [_houses addObject:houseModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

@end
