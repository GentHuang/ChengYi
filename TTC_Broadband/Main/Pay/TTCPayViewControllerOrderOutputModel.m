//
//  TTCPayViewControllerOrderOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPayViewControllerOrderOutputModel.h"
#import "TTCPayViewControllerOrderOutputOrderinfosModel.h"
@implementation TTCPayViewControllerOrderOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _orderinfos = [NSMutableArray array];
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
    if ([key isEqualToString:@"orderinfos"]) {
        for (NSDictionary *dic in value) {
            TTCPayViewControllerOrderOutputOrderinfosModel *orderInfoModel = [[TTCPayViewControllerOrderOutputOrderinfosModel alloc] init];
            [orderInfoModel setValuesForKeysWithDictionary:dic];
            [_orderinfos addObject:orderInfoModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
