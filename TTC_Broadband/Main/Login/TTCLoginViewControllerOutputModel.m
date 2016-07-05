//
//  TTCLoginViewControllerOutputModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCLoginViewControllerOutputModel.h"
#import "TTCLoginViewControllerOutputDepinfoModel.h"
@implementation TTCLoginViewControllerOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _depinfo = [NSMutableArray array];
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
    if ([key isEqualToString:@"depinfo"]) {
        for (NSDictionary *dic in value) {
            TTCLoginViewControllerOutputDepinfoModel *depinfoModel = [[TTCLoginViewControllerOutputDepinfoModel alloc] init];
            [depinfoModel setValuesForKeysWithDictionary:dic];
            [_depinfo addObject:depinfoModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
