//
//  TTCUserLocateScrollView.h
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCUserLocateScrollView : UIScrollView
@property (copy, nonatomic) StringTransBlock stringBlock;
@property (strong, nonatomic) ButtonPressedBlock tapBlock;
//公开属性，便于传值
@property (strong, nonatomic) UITextField *textField;

//加载记录数据
- (void)loadMemoryRecordWithArray:(NSArray *)dataArray;
//加载客户登录类型
- (void)loadTypeWithType:(NSString *)type;
//切换提示
- (void)changeHintWithType:(int)type;

//扫一扫
- (void)loadScanStringWithScanString:(NSString *)scanString;
@end
