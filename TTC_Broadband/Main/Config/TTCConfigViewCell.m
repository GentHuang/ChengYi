//
//  TTCConfigViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCConfigViewCell.h"

@interface TTCConfigViewCell()
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *arrowImageView;
@end
@implementation TTCConfigViewCell
#pragma mark - Init methods
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma mark - Getters and setters
- (void)createUI{
    //图片
    _cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"config_img1"]];
    [self.contentView addSubview:_cellImageView];
    //nameLabel
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"设备安全锁";
    _nameLabel.textColor = LIGHTDARK;
    _nameLabel.font = FONTSIZESBOLD(33/2);
    [self.contentView addSubview:_nameLabel];
    //arrowImageView
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_btn_arrow"]];
    [self.contentView addSubview:_arrowImageView];
}
- (void)setSubViewLayout{
    //图片
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(63/2);
    }];
    //nameLabel
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(_cellImageView.mas_right).with.offset(30/2);
    }];
    //arrowImageView
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(-100/2);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//标题
- (void)loadTitleName:(NSString *)title{
    _nameLabel.text = title;
}
//图片
- (void)loadImage:(UIImage *)image{
    _cellImageView.image = image;
}
@end
