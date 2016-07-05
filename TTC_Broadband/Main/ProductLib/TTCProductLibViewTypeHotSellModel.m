//
//  TTCProductLibViewTypeHotSellModel.m
//  TTC_Broadband
//
//  Created by apple on 16/3/22.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCProductLibViewTypeHotSellModel.h"
#import "TTCProductLibViewControllerRowsModel.h"

@implementation TTCProductLibViewTypeHotSellModel

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    key = nil;
//}
//- (id)valueForUndefinedKey:(NSString *)key{
//    return nil;
//}
//
//- (void)setValue:(id)value forKey:(NSString *)key{
//    if ([key isEqualToString:@"rows"]) {
//        _rows = [NSMutableArray array];
//        for (NSDictionary *dic in value) {
//            TTCProductLibViewControllerRowsModel *RowsModel = [[TTCProductLibViewControllerRowsModel alloc]init];
//            [RowsModel setValuesForKeysWithDictionary:dic];
//            [_rows addObject:RowsModel];
//        }
//    }else{
//        [super setValue:value forKey:key];
//    }
//}


- (instancetype)init{
    if (self = [super init]) {
          _rows = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"rows"]) {
        for (NSDictionary *dic in value) {
            TTCProductLibViewControllerRowsModel *RowsModel = [[TTCProductLibViewControllerRowsModel alloc]init];
            [RowsModel setValuesForKeysWithDictionary:dic];
            [_rows addObject:RowsModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

@end
