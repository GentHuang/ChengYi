//
//  TTCProductLibCell.m
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCProductLibCell.h"

@interface TTCProductLibCell()
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UILabel *priceNameLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UIButton *buyButton;
@property (strong, nonatomic) UIButton *addButton;

@end

@implementation TTCProductLibCell
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
    [self.contentView addSubview:_cellImageView];
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = BLACK;
    _titleLabel.text = @"";
    _titleLabel.font = FONTSIZES(30/2);
    [self.contentView addSubview:_titleLabel];
    //描述
    _descLabel = [[UILabel alloc] init];
    _descLabel.hidden = YES;
    _descLabel.numberOfLines = 2;
    _descLabel.textColor = [UIColor lightGrayColor];
    _descLabel.text = @"";
    _descLabel.font = FONTSIZES(24/2);
    [self.contentView addSubview:_descLabel];
    //价钱名称
    _priceNameLabel = [[UILabel alloc] init];
    _priceNameLabel.hidden = YES;
    _priceNameLabel.textAlignment = NSTextAlignmentRight;
    _priceNameLabel.text = @"价格";
    _priceNameLabel.textColor = [UIColor lightGrayColor];
    _priceNameLabel.font = FONTSIZES(24/2);
    [self.contentView addSubview:_priceNameLabel];
    //价钱
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"0.00";
    _priceLabel.textColor = ORANGE;
    _priceLabel.font = FONTSIZESBOLD(40/2);
    [self.contentView addSubview:_priceLabel];
    //￥图片
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_rmb"]];
    [self.contentView addSubview:_rmbImageView];
    //马上订购
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _buyButton.backgroundColor = DARKBLUE;
    [_buyButton addTarget:self action:@selector(buyOrAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [_buyButton setTitle:@"马上订购" forState:UIControlStateNormal];
//    _buyButton.titleLabel.font = FONTSIZESBOLD(31/2);
//    _buyButton.layer.masksToBounds = YES;
//    _buyButton.layer.cornerRadius = 4;
    
    [_buyButton setImage:[UIImage imageNamed:@"checkoutnow"] forState:UIControlStateNormal];
    [self addSubview:_buyButton];
    //加入购物车
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton addTarget:self action:@selector(buyOrAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    _addButton.backgroundColor = ORANGE;
//    [_addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
//    _addButton.titleLabel.font = FONTSIZESBOLD(31/2);
//    _addButton.layer.masksToBounds = YES;
//    _addButton.layer.cornerRadius = 4;
//    [_addButton setImage:[UIImage imageNamed:@"shoppingCart"] forState:UIControlStateNormal];    
    //添加图片
    [_addButton setImage:[UIImage imageNamed:@"addCart"] forState:UIControlStateNormal];
    
    [self addSubview:_addButton];

}
- (void)setSubViewLayout{
    //cellImageView
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(30/2);
        make.width.height.mas_equalTo(100/2);
    }];
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(_cellImageView.mas_top).with.offset(34/2);
        make.centerY.mas_equalTo(_cellImageView.mas_centerY);
        make.left.mas_equalTo(_cellImageView.mas_right).with.offset(10);
    }];
    //描述
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_cellImageView.mas_bottom).with.offset(-25/2);
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.width.mas_equalTo(772/2);
    }];
    //价钱名称
    [_priceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-54/2);
        make.top.mas_equalTo(30/2);
    }];
    //价钱
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_priceNameLabel.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(-15);
    }];
    //￥图片
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceLabel.mas_bottom).with.offset(-5);
        make.right.mas_equalTo(_priceLabel.mas_left).with.offset(-22/2);
    }];
    //立即购买
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-54/2);
//        make.width.mas_equalTo(220/2);
//        make.height.mas_equalTo(60/2);
//        make.top.mas_equalTo(_priceLabel.mas_bottom).with.offset(2);
        
        make.right.mas_equalTo(-54/2);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(230/2);
        make.height.mas_equalTo(200/2);
        
    }];
    //加入购物车
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_buyButton.mas_top);
//        make.right.mas_equalTo(_buyButton.mas_left).with.offset(-10);
//        make.width.mas_equalTo(230/2);//220/2
//        make.height.mas_equalTo(60/2);
        
        make.right.mas_equalTo(_buyButton.mas_left).with.offset(-20);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(230/2);
        make.height.mas_equalTo(200/2);
        
    }];
}
#pragma mark - Event response
//点击立即购买和加入购物车
- (void)buyOrAddButtonPressed:(UIButton *)button{
    NSString *buttonString = @"";
    if (button == _buyButton) {
        //立即购买
        buttonString = @"立即购买";
    }else if(button == _addButton){
        //加入购物车
        buttonString = @"加入购物车";
    }
    self.buttonBlock(buttonString);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载信息
- (void)loadID:(NSString *)ID title:(NSString *)title img:(NSString *)img price:(NSString *)price type:(NSString *)type{
    _titleLabel.text = title;
    _descLabel.text = ID;
    if ([type isEqualToString:@"1"]) {
        _priceLabel.text = [NSString stringWithFormat:@"%@",price];
    }else{
        _priceLabel.text = [NSString stringWithFormat:@"%@/月",price];
    }
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMGURL,img]]];
}
@end
