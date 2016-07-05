//
//  TTCShoppingCarBar.m
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCShoppingCarBar.h"
@interface TTCShoppingCarBar()
//购物车
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UILabel *sellManLabel;
@property (strong, nonatomic) UILabel *clientLabel;
@property (strong, nonatomic) UIButton *productLibSearchButton;
@end
@implementation TTCShoppingCarBar
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    //背景
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_backgroundImageView];
    //顶部标题
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.textColor = WHITE;
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel.text = @"购物车";
    _headerLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_headerLabel];
    //营销人员
    _sellManLabel = [[UILabel alloc] init];
    _sellManLabel.textColor = WHITE;
    _sellManLabel.textAlignment = NSTextAlignmentCenter;
    _sellManLabel.text = @"营销人员 张三";
    _sellManLabel.font = FONTSIZESBOLD(29/2);
    [self addSubview:_sellManLabel];
    //客户
    _clientLabel = [[UILabel alloc] init];
    _clientLabel.textColor = WHITE;
    _clientLabel.textAlignment = NSTextAlignmentCenter;
    _clientLabel.text = @"客户 李四";
    _clientLabel.font = FONTSIZESBOLD(29/2);
    [self addSubview:_clientLabel];
    //客户离开
    _productLibSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_productLibSearchButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _productLibSearchButton.backgroundColor = CLEAR;
    [_productLibSearchButton setImage:[UIImage imageNamed:@"nav_img_leave_udel"] forState:UIControlStateNormal];
//    [_productLibSearchButton setTitle:@"客户离开" forState:UIControlStateNormal];
//    [_productLibSearchButton setTitleColor:WHITE forState:UIControlStateNormal];
//    _productLibSearchButton.titleLabel.font = FONTSIZESBOLD(29/2);
//    [_productLibSearchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [_productLibSearchButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self addSubview:_productLibSearchButton];
}
- (void)setSubViewLayout{
    //产品库
    //背景
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //顶部标题
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //营销人员
    [_sellManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-21/2);
        make.left.mas_equalTo(31/2);
        
    }];
    //客户
    [_clientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-21/2);
        make.right.mas_equalTo(-31/2);
    }];
    //搜索按钮
    [_productLibSearchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headerLabel.mas_centerY);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _productLibSearchButton) {
        self.stringBlock(@"客户离开");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置购物车标题
- (void)loadShoppingCarHeaderLabel:(NSString *)title{
    _headerLabel.text = title;
}
//设置营销人员姓名，客户姓名
- (void)loadWithSellManName:(NSString *)sName customerName:(NSString *)cName{
    _sellManLabel.text = [NSString stringWithFormat:@"营销人员 %@",sName];
    _clientLabel.text = [NSString stringWithFormat:@"客户 %@",cName];
}
@end
