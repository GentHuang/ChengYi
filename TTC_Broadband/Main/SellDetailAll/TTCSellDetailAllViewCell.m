//
//  TTCSellDetailAllViewCell.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/12/14.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailAllViewCell.h"

@interface TTCSellDetailAllViewCell()
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIView * dateBackView;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *typeLabel;

// add
@property (strong, nonatomic) UIImageView *NumiconImageview;
@property (strong, nonatomic) UIImageView *NameiconImageview;
@end
@implementation TTCSellDetailAllViewCell
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
    //日期背景
    _dateBackView = [[UIView alloc]init];
    _dateBackView.backgroundColor = [UIColor colorWithRed:249/256.0 green:249/256.0 blue:249/256.0 alpha:1];
    [self.contentView addSubview:_dateBackView];
    //分隔线
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_dateBackView addSubview:_lineView];
    
    //-----add icon----
    _NumiconImageview = [[UIImageView alloc]init];
//    _NumiconImageview.backgroundColor = [UIColor clearColor];
    _NumiconImageview.image = [UIImage imageNamed:@"icon_tranf"];
    [self.contentView addSubview:_NumiconImageview];
    //流水号
    _numLabel = [[UILabel alloc] init];
    _numLabel.text = @"流水号:";
    _numLabel.font = FONTSIZESBOLD(24/2);
    _numLabel.textColor = [UIColor colorWithRed:67/256.0 green:173/256.0 blue:230/256.0 alpha:1];
    [self.contentView addSubview:_numLabel];
    //日期时间
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.text = @"08-07 周五";
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.font = FONTSIZESBOLD(24/2);
    _dateLabel.textColor = [UIColor colorWithRed:67/256.0 green:173/256.0 blue:230/256.0 alpha:1];
    [self.contentView addSubview:_dateLabel];
    //圆形背景
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:239/256.0 alpha:1];
    //    _backView.layer.masksToBounds = YES;
    //    _backView.layer.cornerRadius = 130/4;
    [self.contentView addSubview:_backView];
    //价格
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"99.00";
    _priceLabel.textColor = ORANGE;
    _priceLabel.font = FONTSIZESBOLD(56/2);
    [self.contentView addSubview:_priceLabel];
    //rmb
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_small_right"]];
    [self.contentView addSubview:_rmbImageView];
    //客户姓名前面的icon
    _NameiconImageview = [[UIImageView alloc]init];
    _NameiconImageview.backgroundColor = [UIColor clearColor];
//    _NameiconImageview.image = [UIImage imageNamed:@"icon_man"];
    [self.contentView addSubview:_NameiconImageview];
    
    //客户名称
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"客户名称";
    _nameLabel.textColor = LIGHTDARK;
    _nameLabel.font = FONTSIZESBOLD(30/2);
    [self.contentView addSubview:_nameLabel];
    //操作类型
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.text = @"操作类型";
    _typeLabel.textColor = [UIColor lightGrayColor];
    _typeLabel.font = FONTSIZESBOLD(28/2);
    [self.contentView addSubview:_typeLabel];
}
- (void)setSubViewLayout{
    //日期背景
    [_dateBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(70/2);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    //流水号
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20/2);
        make.left.mas_equalTo(70/2);
    }];
    //----------add
    //流水号前面的icon
    [_NumiconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24/2);
        make.right.mas_equalTo(_numLabel.mas_left).offset(-2);
        make.width.height.mas_equalTo(26/2);
    }];
    
    //日期时间
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20/2);
        make.right.mas_equalTo(-53/2);
    }];
    //价格
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-60/2);
        make.right.mas_equalTo(-53/2);
    }];
    //rmb
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceLabel.mas_bottom).with.offset(-7);
        make.right.mas_equalTo(_priceLabel.mas_left).with.offset(-22/2);
    }];
    //add
    //客户姓名前面的icon
    [_NameiconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(20/2);
        make.width.height.mas_equalTo(50/2);
    }];
    //客户名称
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(70/2);
    }];
    //操作类型
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo(_nameLabel.mas_left);
    }];


}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//获取明细信息
- (void)loadWithOrdertype:(NSString *)ordertype factprice:(NSString *)factprice adddate:(NSString *)adddate uname:(NSString *)uname numerical:(NSString *)numerical{
    _priceLabel.text = [NSString stringWithFormat:@"%@",factprice];
    _dateLabel.text = adddate;
    switch ([ordertype intValue]) {
        case 0:
            _typeLabel.text = [NSString stringWithFormat:@"操作类型:%@",@"订购产品"];
            break;
        case 1:
            _typeLabel.text = [NSString stringWithFormat:@"操作类型:%@",@"订购套餐"];
            break;
        case 2:
            _typeLabel.text = [NSString stringWithFormat:@"操作类型:%@",@"充值"];
            break;
        case 3:
            _typeLabel.text = [NSString stringWithFormat:@"操作类型:%@",@"缴欠费"];
            break;
        default:
            break;
    }
    _nameLabel.text = [NSString stringWithFormat:@"客户姓名:%@",uname];
    _numLabel.text = [NSString stringWithFormat:@"流水号:%@",numerical];
}
//获取icon 图片
- (void)loadNumiconImageWithString:(NSString *)NumiconString NameiconImageWithString:(NSString*)nameiconString{
    //流水号前面的icon
    [_NumiconImageview sd_setImageWithURL:[NSURL URLWithString:NumiconString]];
    //名字前面的icon
    [_NameiconImageview sd_setImageWithURL:[NSURL URLWithString:nameiconString]];
    
}

@end
