//
//  TTCAccountInfoViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCAccountInfoViewCell.h"

@interface TTCAccountInfoViewCell()
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *idLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *accountLabel;
@property (strong, nonatomic) UIImageView *cashImageView;
@end

@implementation TTCAccountInfoViewCell
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
    //账本名称
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"客户现金账本";
    _nameLabel.textColor = LIGHTDARK;
    _nameLabel.font = FONTSIZESBOLD(30/2);
    [self.contentView addSubview:_nameLabel];
    //账本ID
    _idLabel = [[UILabel alloc] init];
    _idLabel.text = @"账本ID 45678901";
    _idLabel.textColor = [UIColor lightGrayColor];
    _idLabel.font = FONTSIZESBOLD(24/2);
    [self.contentView addSubview:_idLabel];
    //现金图片
    _cashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_img1"]];
    [self.contentView addSubview:_cashImageView];
    //价钱
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"99.00";
    _priceLabel.textColor = ORANGE;
    _priceLabel.font = FONTSIZESBOLD(56/2);
    [self.contentView addSubview:_priceLabel];
    //rmb图标
    _rmbImageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_small_right"]];
    [self.contentView addSubview:_rmbImageView];
    //账户余额
    _accountLabel = [[UILabel alloc] init];
    _accountLabel.text = @"账本余额";
    _accountLabel.textColor = [UIColor lightGrayColor];
    _accountLabel.font = FONTSIZESBOLD(24/2);
    [self.contentView addSubview:_accountLabel];
    
}
- (void)setSubViewLayout{
    //账本名称
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50/2);
        make.left.mas_equalTo(63/2);
    }];
    //账本ID
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_nameLabel.mas_centerY);
        make.left.mas_equalTo(_nameLabel.mas_right).with.offset(55/2);
    }];
    //现金图片
    [_cashImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(30/2);
        make.left.mas_equalTo(_nameLabel.mas_left);
    }];
    //价钱
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY).with.offset(-5);
        make.right.mas_equalTo(-60/2);
    }];
    //rmb图标
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceLabel.mas_bottom).with.offset(-8);
        make.right.mas_equalTo(_priceLabel.mas_left).with.offset(-10);
    }];
    //账户余额
    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(_rmbImageView.mas_left).with.offset(-34/2);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//载入账本数据
- (void)loadAccountInfoWithFbfees:(NSString *)fbfees fbid:(NSString *)fbid fbname:(NSString *)fbname fbtype:(NSString *)fbtype{
    _priceLabel.text = fbfees;
    _idLabel.text = [NSString stringWithFormat:@"账本ID %@",fbid];
    _nameLabel.text = fbname;
    
}
@end
