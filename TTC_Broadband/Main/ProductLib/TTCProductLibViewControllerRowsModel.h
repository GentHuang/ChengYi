//
//  TTCProductLibViewControllerRowsModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCProductLibViewControllerRowsModel : NSObject
@property (strong, nonatomic) NSString *id_conflict;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *permark;
@property (strong, nonatomic) NSString *type;
//设置itemid
@property (strong, nonatomic) NSString *itemid;
//设置Page
@property (assign, nonatomic) int page;
//@property (strong, nonatomic) NSString *sales;
@end
