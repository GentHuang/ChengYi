//
//  TTCUserLocateViewControllerOutputAddrsPermarksModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateViewControllerOutputAddrsPermarksModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
@implementation TTCUserLocateViewControllerOutputAddrsPermarksModel
- (instancetype)init{
    if (self = [super init]) {
        _servs = [NSMutableArray array];
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
    if ([key isEqualToString:@"servs"]) {
        for (NSDictionary *dic in value) {
            TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servcModel = [[TTCUserLocateViewControllerOutputAddrsPermarksServsModel alloc] init];
            [servcModel setValuesForKeysWithDictionary:dic];
            [_servs addObject:servcModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
