//
//  TTCUserNewAccoutResultSearchViewModel.h
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCUserNewAccoutResultSearchViewModel : NSObject
//用户开户状态结果
@property (strong, nonatomic) NSMutableArray *dataAccountResultArray;

//通过用户获取业务信息
- (void)getUserOpenAccountResultSearchsuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
