//
//  TTCOrderRecordViewControllerPrintOutputModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordViewControllerPrintOutputModel.h"
#import "TTCOrderRecordViewControllerPrintOutputInfosModel.h"

@implementation TTCOrderRecordViewControllerPrintOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _infos = [NSMutableArray array];
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
    if ([key isEqualToString:@"infos"]) {
        for (NSDictionary *dic in value) {
            TTCOrderRecordViewControllerPrintOutputInfosModel *infoModel = [[TTCOrderRecordViewControllerPrintOutputInfosModel alloc] init];
            [infoModel setValuesForKeysWithDictionary:dic];
            [_infos addObject:infoModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

@end
