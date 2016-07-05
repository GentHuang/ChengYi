//
//  TTCLockViewControllerCell.h
//  TTC_Broadband
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCLockViewControllerCell : UITableViewCell
@property (copy, nonatomic) IndexTransBlock indexBlock;
//标题
- (void)loadTitleName:(NSString *)title;
//开关状态
- (void)isON:(BOOL)isON;
@end
