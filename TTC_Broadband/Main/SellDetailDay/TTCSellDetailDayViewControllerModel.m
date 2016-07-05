//
//  TTCSellDetailDayViewControllerModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailDayViewControllerModel.h"
#import "TTCSellDetailDayViewControllerOdsModel.h"
@implementation TTCSellDetailDayViewControllerModel
- (instancetype)init{
    if (self = [super init]) {
        _ods = [NSMutableArray array];
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
    if ([key isEqualToString:@"id"]) {
        _id_conflict = value;
    }else if([key isEqualToString:@"ods"]){
        for (NSDictionary *dic in value) {
            TTCSellDetailDayViewControllerOdsModel *odsModel = [[TTCSellDetailDayViewControllerOdsModel alloc] init];
            [odsModel setValuesForKeysWithDictionary:dic];
            [_ods addObject:odsModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

@end
