//
//  TTCResponseViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCResponseViewControllerViewModel : NSObject
//反馈
- (void)sendResponseWithContent:(NSString *)content success:(SuccessBlock)success fail:(FailBlock)fail;
@end
