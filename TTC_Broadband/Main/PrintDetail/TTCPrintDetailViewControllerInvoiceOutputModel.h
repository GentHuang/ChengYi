//
//  TTCPrintDetailViewControllerInvoiceOutputModel.h
//  TTC_Broadband
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCPrintDetailViewControllerInvoiceOutputModel : NSObject
@property (strong, nonatomic) NSMutableArray *invprintinfo;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *returnCode;

//添加一个字段
@property (strong, nonatomic) NSString * status;

@end
