//
//  TTCMessageDetailProductView.m
//  TTC_Broadband
//
//  Created by apple on 16/3/21.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCMessageDetailProductView.h"

@interface TTCMessageDetailProductView()

@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UILabel *PriceLabel;
@property (strong, nonatomic)UIButton *buyButton;
@property (strong, nonatomic)UIImageView *rmbImageView;
@property (strong, nonatomic)NSString *productID;

@end

@implementation TTCMessageDetailProductView

- (instancetype)init {
    if (self = [super init]) {
        [self creatUI];
        [self setSubViewLayout];
    }
    return self;
}
- (void)creatUI {
    
    self.userInteractionEnabled = YES;
    //产品名称
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = BLACK;
    _titleLabel.text = @"  ";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = FONTSIZES(30/2);
    [self addSubview:_titleLabel];
    //￥图片
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_rmb"]];
    _rmbImageView.backgroundColor =[UIColor clearColor];
    [self addSubview:_rmbImageView];
    //价格
    _PriceLabel = [[UILabel alloc]init];
    _PriceLabel.textColor = [UIColor orangeColor];
    _PriceLabel.textAlignment = NSTextAlignmentCenter;
    _PriceLabel.text = @"0.00";
    _PriceLabel.font = FONTSIZES(36/2);
    _PriceLabel.textColor = ORANGE;
    [self addSubview:_PriceLabel];
    //跳转按钮
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.backgroundColor = DARKBLUE;
    [_buyButton addTarget:self action:@selector(buyOrAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_buyButton setTitle:@"马上订购" forState:UIControlStateNormal];
    _buyButton.titleLabel.font = FONTSIZESBOLD(30/2);
    _buyButton.layer.masksToBounds = YES;
    _buyButton.layer.cornerRadius = 4;
    [self addSubview:_buyButton];
    
}
- (void)setSubViewLayout {
    //名称
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.left.equalTo(self.mas_left).offset(100/2);
    }];
    //跳转按钮
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    //价格
    [_PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.right.equalTo(_buyButton.mas_left).offset(-50);
    }];
     //价格图标
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(3);
        make.right.equalTo(_PriceLabel.mas_left).offset(-5);
        
    }];
    
}
//刷新数据
- (void)reloadDataWithString:(NSString*)titleName PriceString:(NSString*)price {
    self.titleLabel.text = titleName;
    self.PriceLabel.text = [NSString stringWithFormat:@"%@/月",price];
}
//马上订购按钮
- (void)buyOrAddButtonPressed:(UIButton*)button {
    if (self.buttonClick) {
        self.buttonClick(button);
    }
}

@end
