//
//  TTCAddAddressViewControllerOutputModel.h
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCAddAddressViewControllerOutputModel : NSObject

@property (nonatomic, strong) NSMutableArray *houses;

@property (nonatomic, copy) NSString *totalRecords;

@property (nonatomic, copy) NSString *currentPage;

@property (nonatomic, copy) NSString *pagesize;

@end

