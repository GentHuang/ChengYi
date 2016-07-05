//
//  TTCOrderRecordViewControllerPrintOutputModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCOrderRecordViewControllerPrintOutputModel : NSObject
@property (strong, nonatomic) NSMutableArray *infos;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *returnCode;

@end
