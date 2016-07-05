//
//  TTCFirstPageViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TTCFirstPageViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataBannerArray;
@property (strong, nonatomic) NSMutableArray *dataImageArray;
@property (assign, nonatomic) BOOL hasNew;
//banner
- (void)getBannerSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//获取所有消息
- (void)getAllMessageWithPage:(int)page success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
