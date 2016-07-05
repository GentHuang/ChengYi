//
//  TTCUserDetailViewCellStatus.m
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserDetailViewCellStatus.h"

@implementation TTCUserDetailViewCellStatus
- (instancetype)init{
    if (self = [super init]) {
        _selectedArray = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
@end
