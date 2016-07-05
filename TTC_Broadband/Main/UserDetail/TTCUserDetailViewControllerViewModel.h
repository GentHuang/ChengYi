//
//  TTCUserDetailViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
//Model
#import "TTCUserLocateViewControllerOutputAddrsModel.h"
@interface TTCUserDetailViewControllerViewModel : NSObject
//用户开户状态结果
@property (strong, nonatomic) NSMutableArray *dataAccountResultArray;

//获取地址信息
- (NSString *)getAddrsInfoWithModel:(TTCUserLocateViewControllerOutputAddrsModel *)model;
//通过下标获取用户信息
- (NSArray *)getServcInfoWithArray:(NSArray *)dataArray index:(int)index;
//通过用户获取业务信息
- (NSArray *)getUserProductWithAddressArray:(NSArray *)addressArray productArray:(NSArray *)productArray sectionIndex:(int)sectionIndex rowIndex:(int)rowIndex;
@end
