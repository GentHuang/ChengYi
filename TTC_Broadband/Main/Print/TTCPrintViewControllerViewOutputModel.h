//
//  TTCPrintViewControllerViewOutputModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCPrintViewControllerViewOutputModel : NSObject
@property (strong, nonatomic) NSString *custid;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSMutableArray *unprintinvinfos;

@end
