//
//  TTCAddCustAddrViewControllerModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCAddCustAddrViewControllerOutputModel.h"

@interface TTCAddCustAddrViewControllerModel : NSObject
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *requestid;

@property (nonatomic, strong) TTCAddCustAddrViewControllerOutputModel *output;

@end
