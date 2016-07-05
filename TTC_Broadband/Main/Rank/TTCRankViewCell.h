//
//  TTCRankViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kImageType,
    kNumType
}CellType;
@interface TTCRankViewCell : UITableViewCell
//add 名词
@property (strong, nonatomic) UILabel *rankNumberLable;

//选择Cell类型
- (void)selectCellType:(CellType)type;
//加载图片
- (void)loadImageView:(UIImage *)image;
//加载排名
- (void)loadRankLabel:(int)rank;
//加载进度条
- (void)loadProgressViewColor:(UIColor *)color Progress:(CGFloat)progress;
//加载信息
- (void)loadInformation:(NSArray *)dataArray;
//显示排行榜前面的四名
- (void)showRankNumerText:(NSInteger)row;
@end

