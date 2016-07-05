//
//  TTCSellCountViewControllerModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCSellCountViewControllerModel : NSObject
@property (strong, nonatomic) NSMutableArray *analysis;
@property (strong, nonatomic) NSMutableArray *salemonths;
@property (strong, nonatomic) NSString *mname;
@property (strong, nonatomic) NSString *mcode;
@property (strong, nonatomic) NSString *deptname;
@property (strong, nonatomic) NSNumber *commission;
@property (strong, nonatomic) NSNumber *mSales;
@property (strong, nonatomic) NSNumber *dSales;
@property (strong, nonatomic) NSNumber *ranking;
@end
