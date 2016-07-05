//
//  TTCOrderRecordViewController.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCParentViewController.h"

@interface TTCOrderRecordViewController : TTCParentViewController
@property (assign, nonatomic) BOOL isDetail;
@property (assign, nonatomic) BOOL canLeave;
@property (strong, nonatomic) id dataModel;
@end
