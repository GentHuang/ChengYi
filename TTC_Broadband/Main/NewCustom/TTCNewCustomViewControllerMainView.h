//
//  TTCNewCustomViewControllerMainView.h
//  TTC_Broadband
//
//  Created by apple on 15/12/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCNewCustomViewControllerMainView : UIView
@property (copy,nonatomic)StringTransBlock stringBlock;

//加载证件类型，客户类别，客户子类型，农村文化共享户
- (void)loadAreaWithCardTypeArray:(NSArray *)cardTypeArray custTypeArray:(NSArray *)custTypeArray custSubTypeArray:(NSArray *)custSubTypeArray shareArray:(NSArray *)shareArray;
//加载业务区
- (void)loadWithAreaString:(NSString *)areaString;
@end
