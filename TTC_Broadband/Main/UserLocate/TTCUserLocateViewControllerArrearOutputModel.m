//
//  TTCUserLocateViewControllerArrearOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateViewControllerArrearOutputModel.h"
#import "TTCUserLocateViewControllerArrearOutputArreardetsModel.h"
@implementation TTCUserLocateViewControllerArrearOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _arreardets = [NSMutableArray array];
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
    if ([key isEqualToString:@"arreardets"]) {
        for (NSDictionary *dic in value) {
            TTCUserLocateViewControllerArrearOutputArreardetsModel *arreardetsModel = [[TTCUserLocateViewControllerArrearOutputArreardetsModel alloc] init];
            [arreardetsModel setValuesForKeysWithDictionary:dic];
            [_arreardets addObject:arreardetsModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
