//
//  TTCProductLibMidScrolll.m
//  TTC_Broadband
//
//  Created by apple on 16/2/27.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

//View
#import "TTCProductLibMidScroll.h"
//Lib
#import "Masonry.h"
//Macro
#define kButtonTag 31200
#define KLabel_W 200
#define kButtonHeight (23/2)

@interface TTCProductLibMidScroll()<UIScrollViewDelegate>
@property (assign, nonatomic) int selectedIndexx;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIScrollView *scorllView;
@property (strong, nonatomic) UIImageView *dragImageMenu;
@property (assign, nonatomic) int buttoncount;
//切换到热销文案
@property (strong, nonatomic) UIView *hotSellView;
@property (strong, nonatomic) UILabel*hotSellLabeltitle;

@end

@implementation TTCProductLibMidScroll
#pragma mark - Init methods
- (instancetype)init {
    if (self =[super init]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    self.backgroundColor = WHITE;
    //热销标题
    _hotSellView = [[UIView alloc]init];
    _hotSellView.hidden = YES;
    _hotSellView.backgroundColor = WHITE;
    [self addSubview:_hotSellView];
    //热销标题
    _hotSellLabeltitle = [[UILabel alloc]init];
    _hotSellLabeltitle.text = @"热销产品Top20";
    _hotSellLabeltitle.font = FONTSIZES(15);
    _hotSellLabeltitle.backgroundColor = WHITE;
    _hotSellLabeltitle.textColor = [UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0];
    [_hotSellView addSubview:_hotSellLabeltitle];
    //
    //滚动标题
    _scorllView = [[UIScrollView alloc]init];
    _scorllView.hidden = NO;
    [self addSubview:_scorllView];
    
    _scorllView.showsVerticalScrollIndicator = NO;
    _scorllView.pagingEnabled = YES;
    _scorllView.delegate = self;
    _scorllView.showsHorizontalScrollIndicator = NO;
    //ContentView
    _contentView = [[UIView alloc] init];
    [_scorllView addSubview:_contentView];
    //下拉箭头
    _dragImageMenu = [[UIImageView alloc]init];
    _dragImageMenu.hidden = YES;
    _dragImageMenu.contentMode =UIViewContentModeScaleAspectFill,
    _dragImageMenu.image = [UIImage imageNamed:@"SlideDown"];
    _dragImageMenu.backgroundColor = [UIColor redColor];
    _dragImageMenu.userInteractionEnabled = YES;
    [self addSubview:_dragImageMenu];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture:)];
    [_dragImageMenu addGestureRecognizer:tap];
}
- (void)setSubViewLayout{
    //点击下拉箭头
    [_dragImageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.width.mas_equalTo (119/2);
        make.height.mas_equalTo(90/2);
    }];
    //scorllView
    [_scorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(_dragImageMenu.mas_left).with.offset(-10);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
   //ContentView
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_scorllView);
        make.height.mas_equalTo(_scorllView);
    }];
    //热销文案
    [_hotSellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    //热销title
    [_hotSellLabeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_hotSellView.mas_left).offset(33);
        make.top.equalTo(_hotSellView);
        make.height.equalTo(_hotSellView);
    }];
}
- (void)reloadScrollViewWithArray:(NSArray *)array {
    _buttoncount = (int)array.count;
    //先清除旧数据
    [self deleteSubView:_contentView];
    UIView *lastView;
//    CGFloat currX = 0;
    for (int i = 0; i < array.count; i ++) {
        //---
        //根据字符计算Label的宽度
        NSString *contentString = array[i];
        CGRect bounds = [contentString boundingRectWithSize:CGSizeMake(1000, kButtonHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONTSIZES(15)} context:nil];
        CGFloat labelWidth = bounds.size.width;
        //---
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i+kButtonTag;
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.backgroundColor = WHITE;
        [allButton setTitle:array[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor colorWithRed:70/255.0 green:168/255.0 blue:238/255.0 alpha:1.0] forState:UIControlStateSelected];
        [allButton setTitleColor:[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        [allButton setBackgroundImage:[UIImage imageNamed:@"backgroundLine"] forState:UIControlStateSelected];
        allButton.selected = NO;
        allButton.titleLabel.font = FONTSIZESBOLD(14);
        [_contentView addSubview:allButton];
        if (i == 0) {
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(_scorllView.mas_bottom).offset(0);
                make.width.mas_equalTo(labelWidth);
                make.left.mas_equalTo(31);
            }];
        }else{
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(_scorllView.mas_bottom).offset(0);
                make.width.mas_equalTo(labelWidth);
                make.left.mas_equalTo(lastView.mas_right).with.offset(31);
            }];
        }
        lastView = allButton;
    }
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lastView.mas_right);
    }];
    _dragImageMenu.hidden = NO;
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    self.selectedIndexx = (int)(button.tag - kButtonTag);
    for (UIButton *button in _contentView.subviews){
        button.selected = NO;
    }
    button.selected = YES;
}
//跟随选中
- (void)selectWithIndex:(NSInteger)index{
    self.selectedIndexx =(int)index;
    for (UIButton *button in _contentView.subviews){
        button.selected = NO;
    }
    for (int i =0; i<_buttoncount; i++) {
        if (i==index) {
            UIButton *button = (UIButton*)[_contentView viewWithTag:index+kButtonTag];
            button.selected = YES;
        }
    }
}

- (void)tapgesture:(UITapGestureRecognizer*)tap {
        if ([self.delegate respondsToSelector:@selector(ClickOnTheMenuWith)]) {
        [self.delegate ClickOnTheMenuWith];
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//清除旧数据
- (void)deleteSubView:(UIView *)view{
    for (UIView *subView in [view subviews]) {
        [subView removeFromSuperview];
    }
}
#pragma mark ---- 选择模式
- (void)SelectedIntermediateViewType:(KViewType)Type {
    switch (Type) {
        case 0:
            [self SelectedScrollView];
            break;
        case 1:{
            [self SelectedhotSellView];
        }
            break;
        default:{
            [self SelectedScrollView];
        }
            break;
    }
}
- (void)SelectedScrollView {
    self.hotSellView.hidden = YES;
    self.scorllView.hidden = NO;
    self.dragImageMenu.hidden = NO;
}
- (void)SelectedhotSellView {
    self.hotSellView.hidden = NO;
    self.scorllView.hidden = YES;
    self.dragImageMenu.hidden = YES;
}
@end
