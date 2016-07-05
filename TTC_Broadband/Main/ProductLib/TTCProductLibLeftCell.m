//
//  TTCProductLibLeftCell.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/29.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCProductLibLeftCell.h"

@interface TTCProductLibLeftCell()
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UILabel *priceNameLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UIButton *buyButton;
@property (strong, nonatomic) UIButton *addButton;
@end

@implementation TTCProductLibLeftCell
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
    self.backgroundColor = WHITE;
    //cellImageView
    _cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_btn_boardband1"]];
    _cellImageView.hidden = YES;
    [self.contentView addSubview:_cellImageView];
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = BLACK;
    _titleLabel.text = @"";
    _titleLabel.font = FONTSIZES(30/2);
    [self.contentView addSubview:_titleLabel];
}
- (void)setSubViewLayout{
    //cellImageView
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(73/2);
        make.width.height.mas_equalTo(100/2);
    }];
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载标题
- (void)loadTitleWithTitle:(NSString *)titleString{
    _titleLabel.text = titleString;
}
@end
