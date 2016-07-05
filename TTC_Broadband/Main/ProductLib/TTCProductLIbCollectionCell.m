//
//  TTCProductLIbCollectionCell.m
//  TTC_Broadband
//
//  Created by apple on 16/2/28.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCProductLIbCollectionCell.h"
//mac
#define KLabel_W 200

@interface TTCProductLIbCollectionCell()
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation TTCProductLIbCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
//        [self setSubViewLayout];
    }
    return self;
}

- (void)createUI {
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.backgroundColor =[UIColor orangeColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:18];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView);
    }];
}
- (void)reloadItemDataWithString :(NSString*)titleString {
    _nameLabel.text = titleString;
}

@end
