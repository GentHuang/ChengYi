//
//  TTCMessageViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCMessageViewCell : UITableViewCell
//是否已读
- (void)isUnread:(NSString *)isRead;
//加载图片
- (void)loadImage:(UIImage *)image;
//加载名称,内容
- (void)loadTitleWithTitle:(NSString *)titleString content:(NSString *)contentString;
@end
