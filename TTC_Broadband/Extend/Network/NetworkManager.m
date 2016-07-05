//
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "NetworkManager.h"
@implementation NetworkManager
//获取下载管理者
+ (AFHTTPRequestOperationManager *)sharedManager{
    static  AFHTTPRequestOperationManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPRequestOperationManager alloc] init];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    });
    return manager;
}
@end
