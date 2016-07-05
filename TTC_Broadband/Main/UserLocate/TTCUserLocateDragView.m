//
//  TTCUserLocateDragView.m
//  TTC_Broadband
//
//  Created by apple on 15/12/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateDragView.h"
//Macro
#define kButtonTag 60000
@interface TTCUserLocateDragView()
@property (strong, nonatomic) UIScrollView *dragView;
@property (strong, nonatomic) UIView *dragContentView;
@property (strong, nonatomic) NSArray *typeName;
@end

@implementation TTCUserLocateDragView
#pragma mark - Init methods
- (void)initData{
    _typeName = @[@"客户证号",@"智能卡号",@"身份证号",@"电话号码",@"姓名+地址"];
}
- (instancetype)init{
    if (self = [super init]) {
        [self initData];
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    self.alpha = 0;
    //下拉菜单
    _dragView = [[UIScrollView alloc] init];
    _dragView.backgroundColor = WHITE;
    _dragView.layer.borderWidth = 0.5;
    _dragView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:_dragView];
    //下拉菜单内容
    _dragContentView = [[UIView alloc] init];
    _dragContentView.backgroundColor = RED;
    [_dragView addSubview:_dragContentView];
    [self loadDragViewWithArray:_typeName];
}
- (void)setSubViewLayout{
    //下拉菜单
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.width.mas_equalTo(self);
    }];
    //下拉菜单内容
    [_dragContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_dragView);
        make.width.mas_equalTo(_dragView.mas_width);
    }];
    
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    self.stringBlock(button.titleLabel.text);
    for (int i = 0; i < _typeName.count; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:i+kButtonTag];
        allButton.selected = NO;
        allButton.backgroundColor = WHITE;
    }
    button.selected = YES;
    button.backgroundColor = DARKBLUE;
}
#pragma mark - Data request
#pragma mark - Protocol methods
#pragma mark - Other methods
//隐藏拉下菜单
- (void)hideDragView{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
}
//显示下拉菜单
- (void)showDragView{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
}
//加载下拉菜单信息
- (void)loadDragViewWithArray:(NSArray *)dataArray{
    UIView *lastView;
    for (int i = 0; i < dataArray.count; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setTag:i+kButtonTag];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [allButton setTitle:dataArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:WHITE forState:UIControlStateSelected];
        [allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [allButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        allButton.titleLabel.font = FONTSIZESBOLD(30/2);
        if (i == 0) {
            allButton.selected = YES;
            allButton.backgroundColor = DARKBLUE;
        }else{
            allButton.selected = NO;
            allButton.backgroundColor = WHITE;
        }
        [_dragView addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(i*(65/2));
            make.height.mas_equalTo(65/2);
            make.left.right.mas_equalTo(0);
        }];
        lastView = allButton;
    }
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView.mas_bottom);
    }];
}

@end
