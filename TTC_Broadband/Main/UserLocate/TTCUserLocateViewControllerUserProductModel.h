//
//  TTCUserLocateViewControllerUserProductModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCUserLocateViewControllerUserProductOutputModel.h"

@interface TTCUserLocateViewControllerUserProductModel : NSObject
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) TTCUserLocateViewControllerUserProductOutputModel *output;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *status;

@end
