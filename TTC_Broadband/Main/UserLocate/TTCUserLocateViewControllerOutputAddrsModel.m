//
//  TTCUserLocateViewControllerOutputAddrsModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateViewControllerOutputAddrsModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksModel.h"
@implementation TTCUserLocateViewControllerOutputAddrsModel
- (instancetype)init{
    if (self = [super init]) {
        _permarks = [NSMutableArray array];
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
    if ([key isEqualToString:@"permarks"]) {
        for (NSDictionary *dic in value) {
            TTCUserLocateViewControllerOutputAddrsPermarksModel *permarkModel = [[TTCUserLocateViewControllerOutputAddrsPermarksModel alloc] init];
            [permarkModel setValuesForKeysWithDictionary:dic];
            [_permarks addObject:permarkModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
