//
//  TTCDepartmentViewController.h
//  TTC_Broadband
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"

@interface TTCDepartmentViewController : TTCParentViewController
//部门名称队列
@property (strong, nonatomic) NSMutableArray *depinfoNameArray;
@property (strong, nonatomic) NSMutableArray *searchNameArray;
//部门ID队列
@property (strong, nonatomic) NSMutableArray *depinfoIDArray;
@property (strong, nonatomic) NSMutableArray *searchIDArray;
@end
