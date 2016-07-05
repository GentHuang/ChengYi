//
//  TTCUserLocateViewControllerUserProductOutputModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCUserLocateViewControllerUserProductOutputModel : NSObject
@property (strong, nonatomic) NSString *currentPage;
@property (strong, nonatomic) NSString *pagesize;
@property (strong, nonatomic) NSMutableArray *prods;
@property (strong, nonatomic) NSString *totalRecords;
@end
