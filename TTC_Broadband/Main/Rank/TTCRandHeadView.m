//
//  TTCRandHeadView.m
//  TTC_Broadband
//
//  Created by apple on 16/3/23.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCRandHeadView.h"
@interface TTCRandHeadView()
@property (strong, nonatomic) UIImageView *headImageView;

@end

@implementation TTCRandHeadView

- (instancetype)init {
    if (self = [super init]) {
        [self creatUI];

    }
    return self;
}
- (void)creatUI{
 //头部图片
    _headImageView = [[UIImageView alloc]init];
    _headImageView.contentMode  =UIViewContentModeScaleToFill;
    _headImageView.image  = [UIImage imageNamed:@"award"];//award
    [self addSubview:_headImageView];
    //头部图片
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo(471/2);
    }];
}


@end
