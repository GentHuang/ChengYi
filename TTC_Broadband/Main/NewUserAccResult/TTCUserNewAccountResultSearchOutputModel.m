//
//  TTCUserAccountResultSearchOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCUserNewAccountResultSearchOutputModel.h"

@implementation TTCUserNewAccountResultSearchOutputModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    key = nil;
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return key;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"tmpsustOrderList"]) {
        _tmpsustOrderList = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            TTCUserAccountResultSearchMessageModel *messgaeModel =[[TTCUserAccountResultSearchMessageModel alloc]init];
            [messgaeModel setValuesForKeysWithDictionary:dic];
            [_tmpsustOrderList addObject:messgaeModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

@end

/*******************TTCUserAccountResultSearchMessageModel************************/

@implementation TTCUserAccountResultSearchMessageModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    key = nil;
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return key;
}

@end
