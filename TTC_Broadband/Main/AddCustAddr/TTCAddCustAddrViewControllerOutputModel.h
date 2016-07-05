//
//  TTCAddCustAddrViewControllerOutputModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCAddCustAddrViewControllerOutputModel : NSObject

@property (nonatomic, strong) NSMutableArray *houses;

@property (nonatomic, copy) NSString *totalRecords;

@property (nonatomic, copy) NSString *currentPage;

@property (nonatomic, copy) NSString *pagesize;
@end
