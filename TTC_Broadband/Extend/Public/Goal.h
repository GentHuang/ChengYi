//
//  Goal.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goal : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *psw;
@property (strong, nonatomic) NSString *goal;
//单例
+ (Goal *)sharedInstace;
//加载手势密码数据
- (void)loadName:(NSString *)name psw:(NSString *)psw;
@end
