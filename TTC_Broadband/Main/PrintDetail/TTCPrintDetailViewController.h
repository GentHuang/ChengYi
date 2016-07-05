//
//  TTCPrintDetailViewController.h
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"

@interface TTCPrintDetailViewController : TTCParentViewController
@property (strong, nonatomic) NSArray *allPrintInfoArray;
@property (assign, nonatomic) CGFloat allPrice;

//
@property (assign ,nonatomic) BOOL isPopRootViewControl;

@end
