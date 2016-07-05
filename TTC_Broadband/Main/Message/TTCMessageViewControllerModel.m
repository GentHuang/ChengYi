//
//  TTCMessageViewControllerModel.m
//  TTC_Broadband
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCMessageViewControllerModel.h"
#import "TTCMessageViewControllerRowsModel.h"

@implementation TTCMessageViewControllerModel
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
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"rows"]) {
        for (NSDictionary *dic in value) {
            TTCMessageViewControllerRowsModel *rowsModel = [[TTCMessageViewControllerRowsModel alloc] init];
            [rowsModel setValuesForKeysWithDictionary:dic];
            [_rows addObject:rowsModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
