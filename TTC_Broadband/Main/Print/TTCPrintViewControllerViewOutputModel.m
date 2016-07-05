//
//  TTCPrintViewControllerViewOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPrintViewControllerViewOutputModel.h"
#import "TTCPrintViewControllerViewOutputUnprintinvinfosModel.h"

@implementation TTCPrintViewControllerViewOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _unprintinvinfos = [NSMutableArray array];
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
    if ([key isEqualToString:@"unprintinvinfos"]) {
        for (NSDictionary *dic in value) {
            TTCPrintViewControllerViewOutputUnprintinvinfosModel *unprintinvinfosModel = [[TTCPrintViewControllerViewOutputUnprintinvinfosModel alloc] init];
            [unprintinvinfosModel setValuesForKeysWithDictionary:dic];
            [_unprintinvinfos addObject:unprintinvinfosModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
