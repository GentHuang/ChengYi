//
//  TTCModifiedDataMainView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCModifiedDataMainView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//载入数据
- (void)loadWithCustname:(NSString *)custname custid:(NSString *)custid mobile:(NSString *)mobile addr:(NSString *)addr cardtype:(NSString *)cardtype icno:(NSString *)icno markno:(NSString *)markno cardno:(NSString *)cardno pgroupname:(NSString *)pgroupname phone:(NSString *)phone custtype:(NSString *)custtype areaname:(NSString *)areaname;
@end
