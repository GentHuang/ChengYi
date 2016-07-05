//
//  TTCMessageViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCMessageViewControllerViewModel : UIView
@property (strong, nonatomic) NSMutableArray *dataRowsArray;
//获取所有消息
- (void)getAllMessageWithPage:(int)page success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
