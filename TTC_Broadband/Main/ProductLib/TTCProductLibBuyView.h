//
//  TTCProductLibBuyView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/27.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kBuyType,
    kCarType
}ViewType;
@interface TTCProductLibBuyView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//显示
- (void)showBuyView;
//隐藏
- (void)hideBuyView;
//首次加载等待
- (void)startDownload;
//首次加载成功
- (void)stopDownload;
//加载用户数据
- (void)loadUserListWithArray:(NSArray *)dataArray permarkArray:(NSArray *)permarkArray;
//选择View模式
- (void)selectViewType:(ViewType)viewType;
//加载产品数据
- (void)loadTitle:(NSString *)title intro:(NSString *)intro price:(NSString *)price smallimg:(NSString *)smallimg firstUserKeyno:(NSString *)firstUserKeyno firstUserPermark:(NSString *)firstUserPermark;

/**********************************/
//显示购买年份月份按钮
- (void)showBuyYearOrMonthlyButton;
//隐藏购买年份月份按钮
- (void)hiddeBUyYearOrMonthlyButton;

@end
