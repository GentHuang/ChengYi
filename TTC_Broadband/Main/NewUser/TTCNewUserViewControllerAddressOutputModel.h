//
//  TTCNewUserViewControllerAddressOutputModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/28.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCNewUserViewControllerAddressOutputModel : NSObject
@property (strong, nonatomic) NSString *currentPage;
@property (strong, nonatomic) NSMutableArray *houses;
@property (strong, nonatomic) NSString *pagesize;
@property (strong, nonatomic) NSString *totalRecords;
@end
