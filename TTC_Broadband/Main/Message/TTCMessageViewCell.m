//
//  TTCMessageViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCMessageViewCell.h"

@interface TTCMessageViewCell()
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *setNameLabel;
@property (strong, nonatomic) UILabel *setDescLabel;
@property (strong, nonatomic) UIImageView *unreadImageView;
@end

@implementation TTCMessageViewCell
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
    //前头ICON
    _cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_TV"]];
    [self.contentView addSubview:_cellImageView];
    //高清电视体育频道
    _setNameLabel = [[UILabel alloc] init];
    _setNameLabel.text = @"高清电视体育频道";
    _setNameLabel.font = FONTSIZESBOLD(30/2);
    _setNameLabel.textColor = LIGHTDARK;
    [self.contentView addSubview:_setNameLabel];
    //介绍
    _setDescLabel = [[UILabel alloc] init];
    _setDescLabel.text = @"提供最热门的体育赛事，高清画质让你犹如身临其境，热血沸腾，现优惠促销，买半年送2个月";
    _setDescLabel.font = FONTSIZESBOLD(24/2);
    _setDescLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_setDescLabel];
    //是否已读
    _unreadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_img_unread"]];
    [self.contentView addSubview:_unreadImageView];
}
- (void)setSubViewLayout{
    //前头ICON
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(80/2);
        make.width.height.mas_equalTo(50);
    }];
    //高清电视体育频道
    [_setNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(37/2);
        make.left.mas_equalTo(_cellImageView.mas_right).with.offset(10);
    }];
    //介绍
    [_setDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_setNameLabel.mas_bottom).with.offset(22/2);
        make.left.mas_equalTo(_setNameLabel.mas_left);
        make.width.mas_equalTo(800/2);
    }];
    //是否已读
    [_unreadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(-100/2);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//是否已读
- (void)isUnread:(NSString *)isRead{
    if ([isRead isEqualToString:@"0"]) {
        _unreadImageView.hidden = NO;
    }else{
        _unreadImageView.hidden = YES;
    }
}
//加载图片
- (void)loadImage:(UIImage *)image{
    _cellImageView.image = image;
}
//加载名称,内容
- (void)loadTitleWithTitle:(NSString *)titleString content:(NSString *)contentString{
    _setNameLabel.text = titleString;
    _setDescLabel.text = contentString;
}
@end
