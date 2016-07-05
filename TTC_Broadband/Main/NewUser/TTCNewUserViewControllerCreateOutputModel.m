//
//  TTCNewUserViewControllerCreateOutputModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/5.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCNewUserViewControllerCreateOutputModel.h"
#import "TTCNewUserViewControllerCreateOutputAutoOpenDefModel.h"
@implementation TTCNewUserViewControllerCreateOutputModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"autoOpenDef"]) {
        _autoOpenDef = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            TTCNewUserViewControllerCreateOutputAutoOpenDefModel *defModel = [[TTCNewUserViewControllerCreateOutputAutoOpenDefModel alloc] init];
            [defModel setValuesForKeysWithDictionary:dic];
            [_autoOpenDef addObject:defModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
