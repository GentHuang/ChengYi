//
//  TTCUserLocateViewControllerBalanceOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateViewControllerBalanceOutputModel.h"
#import "TTCUserLocateViewControllerBalanceOutputFeebooksModel.h"
@implementation TTCUserLocateViewControllerBalanceOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _feebooks = [NSMutableArray array];
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
    if ([key isEqualToString:@"feebooks"]) {
        for (NSDictionary *dic in value) {
            TTCUserLocateViewControllerBalanceOutputFeebooksModel *feebooksModel = [[TTCUserLocateViewControllerBalanceOutputFeebooksModel alloc] init];
            [feebooksModel setValuesForKeysWithDictionary:dic];
            [_feebooks addObject:feebooksModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
