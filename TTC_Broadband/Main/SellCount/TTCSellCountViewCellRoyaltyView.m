//
//  TTCSellCountViewCellRoyaltyView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellCountViewCellRoyaltyView.h"
@interface TTCSellCountViewCellRoyaltyView()
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@end
@implementation TTCSellCountViewCellRoyaltyView
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
   //价格
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.text = @"121";
    _priceLabel.font = FONTSIZESBOLD(77/2);
    _priceLabel.textColor = ORANGE;
    [self addSubview:_priceLabel];
    //rmb
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_big_right"]];
    [self addSubview:_rmbImageView];
    //本月提成
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = @"本月提成";
    _nameLabel.font = FONTSIZESBOLD(30/2);
    _nameLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_nameLabel];

}
- (void)setSubViewLayout{
    //价格
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(56/2);
    }];
    //rmb
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_priceLabel.mas_left).with.offset(-28/2);
        make.bottom.mas_equalTo(_priceLabel.mas_bottom).with.offset(-10);
    }];
    //本月提成
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(_priceLabel.mas_bottom).with.offset(20/2);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载提成
- (void)loadRoyaltyWithRoyalty:(NSString *)royaltyString{
    _priceLabel.text = royaltyString;
}
@end
