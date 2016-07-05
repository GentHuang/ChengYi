//
//  TTCFirstPageBannerViewCell.m
//  TTC_Broadband
//
//  Created by apple on 16/1/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCFirstPageBannerViewCell.h"

@interface TTCFirstPageBannerViewCell()
@property (strong, nonatomic) UIImageView *bannerImageView;
@end

@implementation TTCFirstPageBannerViewCell
#pragma mark - Init methods
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    //bannerImageView
    _bannerImageView = [[UIImageView alloc] init];
    _bannerImageView.backgroundColor = WHITE;
    [self.contentView addSubview:_bannerImageView];
}
- (void)setSubViewLayout{
    //bannerImageView
    [_bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}
#pragma mark - Event response
#pragma mark - Data request
#pragma mark - Protocol methods
#pragma mark - Other methods
//获取图片
- (void)loadImageViewWithImage:(NSString *)imageString{
    [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BANNERIMGURL,imageString]]];
}
@end
