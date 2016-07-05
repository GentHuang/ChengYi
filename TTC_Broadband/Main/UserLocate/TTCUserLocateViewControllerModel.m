//
//  TTCUserLocateViewControllerModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateViewControllerModel.h"
#import "TTCUserLocateViewControllerOutputModel.h"
@implementation TTCUserLocateViewControllerModel
- (instancetype)init{
    if (self = [super init]) {
        _output = [NSMutableArray array];
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
    if ([key isEqualToString:@"output"]) {
        for (NSDictionary *dic in value) {
            TTCUserLocateViewControllerOutputModel *outputModel = [[TTCUserLocateViewControllerOutputModel alloc] init];
            [outputModel setValuesForKeysWithDictionary:dic];
            [_output addObject:outputModel];
        }        
    }else{
        [super setValue:value forKey:key];
    }
}
@end
