//
//  TTCQRPayViewOrderPayResultModel.h
//  TTC_Broadband
//
//  Created by apple on 16/5/7.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCQRPayViewOrderPayResultModel : NSObject

@property (strong, nonatomic) NSString *adddate;
@property (strong, nonatomic) NSString *orderno;
@property (strong, nonatomic) NSString *paysuccess;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *proname;
/*
"adddate" : "2016/5/7 15:51:48",
"orderno" : "8042",
"paysuccess" : "1",
"price" : "0.01",
"proname" : "chc动作电影"
 */
@end
