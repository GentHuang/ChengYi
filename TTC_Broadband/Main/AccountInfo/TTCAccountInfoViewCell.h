//
//  TTCAccountInfoViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCAccountInfoViewCell : UITableViewCell
//载入账本数据
- (void)loadAccountInfoWithFbfees:(NSString *)fbfees fbid:(NSString *)fbid fbname:(NSString *)fbname fbtype:(NSString *)fbtype;
@end
