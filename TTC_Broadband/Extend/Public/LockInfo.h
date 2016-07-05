//
//  LockInfo.h
//  TTC_Broadband
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LockInfo : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *psw;
@property (strong, nonatomic) NSString *numPSW;
@property (strong, nonatomic) NSString *gesturePSW;
@property (strong, nonatomic) NSString *firstNum;
@property (strong, nonatomic) NSString *firstGesture;
//是否修改密码
@property (strong, nonatomic) NSString *isChangePSW;
@property (strong, nonatomic) NSString *isChangeGesture;
//单例
+ (LockInfo *)sharedInstace;
//加载手势密码数据
- (void)loadName:(NSString *)name psw:(NSString *)psw;
@end
