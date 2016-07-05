//
//  TTCNewUserViewSingleSelected.h
//  TTC_Broadband
//
//  Created by apple on 16/3/1.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCNewUserViewSingleSelectedView : UIView

@property (copy,nonatomic) StringTransBlock stringBlock;

//刷新数据
- (void)getDataWithArray:(NSArray *)array;
//一行一个button
- (void)getTwoLineButtonDataWithArray:(NSArray *)array;
@end
