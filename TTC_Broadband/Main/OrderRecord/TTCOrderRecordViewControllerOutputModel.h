//
//  TTCOrderRecordViewControllerOutputModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCOrderRecordViewControllerOutputModel : NSObject
@property (strong, nonatomic) NSString *currentPage;
@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) NSString *pagesize;
@property (strong, nonatomic) NSString *totalRecords;
@end
