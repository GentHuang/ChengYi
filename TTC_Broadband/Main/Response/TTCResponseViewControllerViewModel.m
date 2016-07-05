//
//  TTCResponseViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCResponseViewControllerViewModel.h"

@implementation TTCResponseViewControllerViewModel
//反馈
- (void)sendResponseWithContent:(NSString *)content success:(SuccessBlock)success fail:(FailBlock)fail{
    //下载数据
    [[NetworkManager sharedManager] GET:kSendResponseAPI parameters:@{@"content":content,@"code":[SellManInfo sharedInstace].loginname,@"title":[SellManInfo sharedInstace].name} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        if ([[responseObject valueForKey:@"msg"] isEqualToString:@"添加成功"]) {
            success(nil);
        }else{
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        fail(nil);
        NSLog(@"%@",error);
    }];
    
}
@end
