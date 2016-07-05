//
//  TTCSellCountViewControllerModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellCountViewControllerModel.h"
#import "TTCSellCountViewControllerAnalysisModel.h"
#import "TTCSellCountViewControllerSalesMonthModel.h"

@implementation TTCSellCountViewControllerModel
- (instancetype)init{
    if (self = [super init]) {
        _analysis = [NSMutableArray array];
        _salemonths = [NSMutableArray array];
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
    if ([key isEqualToString:@"analysis"]) {
        for (NSDictionary *dic in value) {
            TTCSellCountViewControllerAnalysisModel *anModel = [[TTCSellCountViewControllerAnalysisModel alloc] init];
            [anModel setValuesForKeysWithDictionary:dic];
            [_analysis addObject:anModel];
        }
    }else if([key isEqualToString:@"salemonths"]){
        for (NSDictionary *dic in value) {
            TTCSellCountViewControllerSalesMonthModel *saleModel = [[TTCSellCountViewControllerSalesMonthModel alloc] init];
            [saleModel setValuesForKeysWithDictionary:dic];
            [_salemonths addObject:saleModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
