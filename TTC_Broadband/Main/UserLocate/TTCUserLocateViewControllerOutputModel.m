//
//  TTCUserLocateViewControllerOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateViewControllerOutputModel.h"
#import "TTCUserLocateViewControllerOutputAddrsModel.h"
@implementation TTCUserLocateViewControllerOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _addrs = [NSMutableArray array];
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
    if ([key isEqualToString:@"addrs"]) {
        for (NSDictionary *dic in value) {
            TTCUserLocateViewControllerOutputAddrsModel *addrsModel = [[TTCUserLocateViewControllerOutputAddrsModel alloc] init];
            [addrsModel setValuesForKeysWithDictionary:dic];
            [_addrs addObject:addrsModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

@end
