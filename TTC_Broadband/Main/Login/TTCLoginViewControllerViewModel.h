//
//  TTCLoginViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCLoginViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataDepinfoNameArray;
@property (strong, nonatomic) NSMutableArray *dataDepinfoIDArray;
//销售人员登录
- (void)saleManLoginWithName:(NSString *)name pwd:(NSString *)pwd successs:(SuccessBlock) success fail:(FailBlock)failBlock;
@end
