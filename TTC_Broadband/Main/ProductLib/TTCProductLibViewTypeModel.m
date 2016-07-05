//
//  TTCProductLibViewTypeModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/29.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCProductLibViewTypeModel.h"
#import "TTCProductLibViewTypePclistModel.h"

@implementation TTCProductLibViewTypeModel
- (instancetype)init{
    if (self = [super init]) {
        _pclist = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"pclist"]) {
        for (NSDictionary *dic in value) {
            TTCProductLibViewTypePclistModel *plictModel = [[TTCProductLibViewTypePclistModel alloc] init];
            [plictModel setValuesForKeysWithDictionary:dic];
            [_pclist addObject:plictModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

@end
