//
//  TTCPrintDetailViewControllerInvoiceOutputModel.m
//  TTC_Broadband
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPrintDetailViewControllerInvoiceOutputModel.h"
#import "TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel.h"

@implementation TTCPrintDetailViewControllerInvoiceOutputModel
- (instancetype)init{
    if (self = [super init]) {
        _invprintinfo = [NSMutableArray array];
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
    if ([key isEqualToString:@"invprintinfo"]) {
        for (NSDictionary *dic in value) {
            TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel *infoModel = [[TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel alloc] init];
            [infoModel setValuesForKeysWithDictionary:dic];
            [_invprintinfo addObject:infoModel];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
