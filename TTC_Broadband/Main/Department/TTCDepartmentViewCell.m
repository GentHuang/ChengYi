//
//  TTCDepartmentViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//View
#import "TTCDepartmentViewCell.h"
@interface TTCDepartmentViewCell()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *arrowImageView;
@property (strong, nonatomic) UIImageView *pointImageView;
@end

@implementation TTCDepartmentViewCell
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
    //背景
    _backView = [[UIView alloc] init];
    [self.contentView addSubview:_backView];
    //圆点
    _pointImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"department_img1"]];
    [self.contentView addSubview:_pointImageView];
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"中山营业厅";
    _titleLabel.textColor = LIGHTDARK;
    _titleLabel.font = FONTSIZESBOLD(33/2);
    [_backView addSubview:_titleLabel];
    //箭头
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_btn_arrow"]];
    [_backView addSubview:_arrowImageView];
}
- (void)setSubViewLayout{
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //圆点
    [_pointImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(60/2);
    }];
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_pointImageView.mas_right).with.offset(10);
    }];
    //箭头
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-100/2);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载标题
- (void)loadTitleLabel:(NSString *)titleString{
    _titleLabel.text = titleString;
}
@end
