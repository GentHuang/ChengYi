//
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface NetworkManager : NSObject
//获取下载管理者
+ (AFHTTPRequestOperationManager *)sharedManager;
@end
