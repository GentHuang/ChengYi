//
//  TTCProductLibMidScrolll.h
//  TTC_Broadband
//
//  Created by apple on 16/2/27.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    KViewTypeScrollType,
    KViewTypeHotSellType
}KViewType;

@protocol TTCProductLibMidScrolldelegate <NSObject>

@optional
//点击展开菜单
- (void)ClickOnTheMenuWith;
@end

@interface TTCProductLibMidScroll : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;

@property (assign,nonatomic)id <TTCProductLibMidScrolldelegate>delegate;
//数据刷新
- (void)reloadScrollViewWithArray:(NSArray *)array;
//跟随选中
- (void)selectWithIndex:(NSInteger)index;
//选择中间视图模型
- (void)SelectedIntermediateViewType:(KViewType)Type;
@end
