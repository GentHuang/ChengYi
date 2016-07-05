//
//  TTCUserLocateViewControllerUserProductOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateViewControllerUserProductOutputModel.h"
#import "TTCUserLocateViewControllerUserProductOutputProsModel.h"

@implementation TTCUserLocateViewControllerUserProductOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _prods = [NSMutableArray array];
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
    if ([key isEqualToString:@"prods"]) {
        for (NSDictionary *dic in value) {
            TTCUserLocateViewControllerUserProductOutputProsModel *prosModel = [[TTCUserLocateViewControllerUserProductOutputProsModel alloc] init];
            [prosModel setValuesForKeysWithDictionary:dic];
            [_prods addObject:prosModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
