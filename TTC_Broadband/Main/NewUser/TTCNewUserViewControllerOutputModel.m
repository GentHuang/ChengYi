//
//  TTCNewUserViewControllerOutputModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/6.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCNewUserViewControllerOutputModel.h"

@implementation TTCNewUserViewControllerOutputModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
@end
