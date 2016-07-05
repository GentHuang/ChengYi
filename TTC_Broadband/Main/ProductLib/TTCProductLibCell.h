//
//  TTCProductLibCell.h
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCProductLibCell : UITableViewCell
@property (copy, nonatomic) StringTransBlock buttonBlock;
//加载信息
- (void)loadID:(NSString *)ID title:(NSString *)title img:(NSString *)img price:(NSString *)price type:(NSString *)type;
@end
