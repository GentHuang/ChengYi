//
//  TTCNewUserViewSingleSelected.m
//  TTC_Broadband
//
//  Created by apple on 16/3/1.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCNewUserViewSingleSelectedView.h"
#define KButtonTag 7660
#define kButtonWidth 120
#define kButtonHeight 30

@interface TTCNewUserViewSingleSelectedView()
@property (strong, nonatomic) UIButton *singleSelectedButton ;
@property (strong, nonatomic) UILabel *singleNameLable;
@property (assign, nonatomic) int  buttonCount;
//获取当前View的大小
@property (assign ,nonatomic) CGRect sizeView;

@end

@implementation TTCNewUserViewSingleSelectedView
//刷新
- (void)getDataWithArray:(NSArray *)array{
    //先清空数据
    [self deleteAllButton];
    _buttonCount = (int)array.count;
    UIView *lastView;
    //默认按钮
    UIButton *defaultSelectedButton;
    for (int i = 0,j = 0; i < array.count; i ++,j++) {
        if (j==3) {
            j = 0;
        }
        NSString *contentString = array[i];
        CGRect bounds = [contentString boundingRectWithSize:CGSizeMake(1000, kButtonHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONTSIZES(15)} context:nil];
        CGFloat labelWidth = bounds.size.width;
        CGFloat buttonWith = labelWidth+55/2;NSLog(@"button 宽度 %f",buttonWith);
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setTag:(i+KButtonTag)];
        [allButton addTarget:self action:@selector(singlebuttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [allButton setTitle:array[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateNormal];
        allButton.titleLabel.font = FONTSIZES(15);
        //添加照片
        [allButton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
        [allButton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
        //图片和文字的位置
        allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [allButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [allButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [self addSubview:allButton];
        if (i < 3) {
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mas_top).with.offset(0);
                make.left.mas_equalTo(self.mas_left).with.offset(j*(kButtonWidth+20));
                make.width.mas_equalTo(kButtonWidth);
                make.height.mas_equalTo(kButtonHeight);
            }];
            lastView = allButton;
            //默认选择
            if (i==0) {
                defaultSelectedButton = allButton;
            }
        }else{
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.mas_bottom).with.offset(10/2);
                make.left.equalTo(self.mas_left).with.offset(j*(kButtonWidth+20));
                make.width.mas_equalTo(kButtonWidth);
                make.height.mas_equalTo(kButtonHeight);
            }];
        }
        if (j == 2 || i == (array.count-1)) {
            lastView = allButton;
        }
    }
    for (int i = 0 ;i< array.count ; i++){
        if ([array[i] isEqualToString:@"无后缀"]) {
            [self singlebuttonPressed:(UIButton *)[self viewWithTag:(i+KButtonTag)]];
            NSLog(@"==%@",array[i]);
        }else {
            [self singlebuttonPressed:defaultSelectedButton];
        }
    }
    //默认选择第一个
//    [self singlebuttonPressed:defaultSelectedButton];
}
- (void)getTwoLineButtonDataWithArray:(NSArray *)array {
    [self deleteAllButton];
    _buttonCount = (int)array.count;
    UIView *lastView;
    //默认按钮
    UIButton *defaultSelectedButton;
    for (int i = 0; i < array.count; i ++) {
        NSString *contentString = array[i];
        CGRect bounds = [contentString boundingRectWithSize:CGSizeMake(1000, kButtonHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONTSIZES(15)} context:nil];
        CGFloat labelWidth = bounds.size.width;
        CGFloat buttonWith = labelWidth+55/2;NSLog(@"button 宽度 %f",buttonWith);
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setTag:(i+KButtonTag)];
        [allButton addTarget:self action:@selector(singlebuttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [allButton setTitle:array[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateNormal];
        allButton.titleLabel.font = FONTSIZES(15);
        //添加照片
        [allButton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
        [allButton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
        //跳转button位置
        allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [allButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [allButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [self addSubview:allButton];
        if (i==0) {
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mas_top).with.offset(0);
                make.left.mas_equalTo(self.mas_left).with.offset(0);
                make.width.mas_equalTo(kButtonWidth*2);
                make.height.mas_equalTo(kButtonHeight);
            }];
            lastView = allButton;
            //默认选择第一个
            defaultSelectedButton =allButton;
        }else{
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.mas_bottom).with.offset(10/2);
                make.left.equalTo(self.mas_left).with.offset(0);
                make.width.mas_equalTo(kButtonWidth*2);
                make.height.mas_equalTo(kButtonHeight);
            }];
        }
    }
    //默认选择第一个
    [self singlebuttonPressed:defaultSelectedButton];
}
//删除所有按钮
- (void)deleteAllButton{
    if (_buttonCount > 0) {
        for (int i = 0; i < _buttonCount; i ++) {
            UIButton *allButton = (UIButton *)[self viewWithTag:(i+KButtonTag)];
            [allButton removeFromSuperview];
        }
    }
}
#pragma mark  Event response
- (void)singlebuttonPressed:(UIButton*)button {
    for (int i = 0; i < _buttonCount; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:i+KButtonTag];
        button.selected = NO;
    }
    button.selected = YES;
    self.stringBlock(button.titleLabel.text);

}
- (void)deleteSubView:(UIView *)view{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}

@end
