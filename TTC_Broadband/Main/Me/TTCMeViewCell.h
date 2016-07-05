//
//  TTCMeViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kFirstType,
    kOtherType
}CellType;
@interface TTCMeViewCell : UITableViewCell
@property (copy, nonatomic) StringTransBlock stringBlock;
//标题
- (void)loadTitleName:(NSString *)title;
//是否已启用
- (void)isUsed:(BOOL)isUsed;
//隐藏或显示已启用
- (void)hideIsUsed:(BOOL)hide;
//选择模式
- (void)selectCellType:(CellType)type;
//加载图片
- (void)loadCellImageWithImage:(UIImage *)image;
@end
