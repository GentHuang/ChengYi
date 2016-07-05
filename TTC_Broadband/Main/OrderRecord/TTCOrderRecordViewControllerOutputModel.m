//
//  TTCOrderRecordViewControllerOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordViewControllerOutputModel.h"
#import "TTCOrderRecordViewControllerOutputOrderModel.h"

@implementation TTCOrderRecordViewControllerOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _orders = [NSMutableArray array];
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
    if ([key isEqualToString:@"orders"]) {
        for (NSDictionary *dic in value) {
            TTCOrderRecordViewControllerOutputOrderModel *orderModel = [[TTCOrderRecordViewControllerOutputOrderModel alloc] init];
            [orderModel setValuesForKeysWithDictionary:dic];
            [_orders addObject:orderModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
