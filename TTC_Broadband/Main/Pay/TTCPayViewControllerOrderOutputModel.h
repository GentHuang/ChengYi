//
//  TTCPayViewControllerOrderOutputModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCPayViewControllerOrderOutputModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *orderid;
@property (strong, nonatomic) NSMutableArray *orderinfos;
@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSString *sums;
@end
