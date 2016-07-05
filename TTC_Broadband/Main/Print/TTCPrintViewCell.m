//
//  TTCPrintViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPrintViewCell.h"
#import "TTCPrintViewCellAccountBackView.h"
@interface TTCPrintViewCell()<UITextFieldDelegate>
@property (strong, nonatomic) TTCPrintViewCellAccountBackView *accountBackView;
@property (strong, nonatomic) UIView *detailBackView;
@property (strong, nonatomic) UILabel *orderIDLabel;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIButton *selectedButton;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIView *dLineView;
@property (strong, nonatomic) UILabel *priceNameLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *priceLabel;
@end
@implementation TTCPrintViewCell
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
    __block TTCPrintViewCell *selfView = self;
    //总计
    //背景
    _accountBackView = [[TTCPrintViewCellAccountBackView alloc] init];
    _accountBackView.hidden = YES;
    _accountBackView.backgroundColor = WHITE;
    _accountBackView.stringBlock = ^(NSString *buttonString){
        [selfView buttonPressed:buttonString];
    };
    [self.contentView addSubview:_accountBackView];
    //详情
    //背景
    _detailBackView = [[UIView alloc] init];
    _detailBackView.hidden = YES;
    _detailBackView.backgroundColor = WHITE;
    [self.contentView addSubview:_detailBackView];
    //发票项名称
    _orderIDLabel = [[UILabel alloc] init];
    _orderIDLabel.text = @"";
    _orderIDLabel.textColor = LIGHTDARK;
    _orderIDLabel.font = FONTSIZESBOLD(26/2);
    [_detailBackView addSubview:_orderIDLabel];
    //用户
    _userLabel = [[UILabel alloc] init];
    _userLabel.text = @"";
    _userLabel.textAlignment = NSTextAlignmentRight;
    _userLabel.textColor = [UIColor lightGrayColor];
    _userLabel.font = FONTSIZESBOLD(26/2);
    [_detailBackView addSubview:_userLabel];
    //下划线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_detailBackView addSubview:_lineView];
    //选择按钮
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectedButton.userInteractionEnabled = NO;
    [_selectedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedButton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
    [_selectedButton setImageEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    [_detailBackView addSubview:_selectedButton];
    //
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.text = @"";
    _typeLabel.textColor = [UIColor lightGrayColor];
    _typeLabel.font = FONTSIZESBOLD(26/2);
    [_detailBackView addSubview:_typeLabel];
    //时间
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.text = @"开始时间 2015-8-8";
    _dateLabel.textColor = [UIColor lightGrayColor];
    _dateLabel.font = FONTSIZESBOLD(26/2);
    [_detailBackView addSubview:_dateLabel];
    //下划线
    _dLineView = [[UIView alloc] init];
    _dLineView.backgroundColor = [UIColor lightGrayColor];
    [_detailBackView addSubview:_dLineView];
    //总金额
    _priceNameLabel = [[UILabel alloc] init];
    _priceNameLabel.text = @"总金额：";
    _priceNameLabel.textColor = [UIColor lightGrayColor];
    _priceNameLabel.font = FONTSIZESBOLD(26/2);
    [_detailBackView addSubview:_priceNameLabel];
    //rmb
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb1"]];
    [_detailBackView addSubview:_rmbImageView];
    //总计
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"100.00";
    _priceLabel.textColor = [UIColor orangeColor];
    _priceLabel.font = FONTSIZESBOLD(31/2);
    [_detailBackView addSubview:_priceLabel];
}
- (void)setSubViewLayout{
    //总计
    //背景
    [_accountBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //详情
    //背景
    [_detailBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //发票项名称
    [_orderIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60/2);
        make.top.mas_equalTo(35/2);
    }];
    //用户
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-60/2);
        make.top.mas_equalTo(_orderIDLabel.mas_top);
    }];
    //下划线
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderIDLabel.mas_bottom).with.offset(35/2);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    //选择按钮
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(153/2);
        make.height.mas_equalTo(188/2);
    }];
    //
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom).with.offset(40/2);
        make.left.mas_equalTo(_selectedButton.mas_right).with.offset(0);
    }];
    //时间
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectedButton.mas_centerY);
        make.left.mas_equalTo(_selectedButton.mas_right).with.offset(0);
    }];
    //下划线
    [_dLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_selectedButton.mas_bottom).with.offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    //总金额
    [_priceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dLineView.mas_bottom).with.offset(20/2);
        make.left.mas_equalTo(60/2);
    }];
    //rmb
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceNameLabel.mas_bottom).with.offset(-4);
        make.left.mas_equalTo(_priceNameLabel.mas_right);
    }];
    //总金额
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceNameLabel.mas_bottom).with.offset(0);
        make.left.mas_equalTo(_rmbImageView.mas_right).with.offset(2);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(NSString *)buttonString{
    self.stringBlock(buttonString);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//选择Cell类型
- (void)selectCellType:(CellType)type{
    switch (type) {
        case 0:
            [self useAccountType];
            break;
        case 1:
            [self useDetailType];
            break;
        default:
            break;
    }
}
//总计
- (void)useAccountType{
    _accountBackView.hidden = NO;
    _detailBackView.hidden = YES;
}
//详情
- (void)useDetailType{
    _accountBackView.hidden = YES;
    _detailBackView.hidden = NO;
}
//加载分组名称
- (void)loadTypeWithString:(NSString *)type{
    [_accountBackView loadTypeWithString:type];
}
//加载订单详情
- (void)loadWithInvcontid:(NSString *)invcontid keyno:(NSString *)keyno optime:(NSString *)optime fees:(NSString *)fees mName:(NSString *)mName{
    _userLabel.text = [NSString stringWithFormat:@"用户 %@",keyno];
    _orderIDLabel.text = mName;
    _dateLabel.text = [NSString stringWithFormat:@"开始时间 %@",optime];
    _priceLabel.text = fees;
}
//是否选择(详细)
- (void)isSelected:(BOOL)isSelected{
    _selectedButton.selected = isSelected;
}
//是否选择(全局)
- (void)isAllSelected:(BOOL)isAllSelected{
    [_accountBackView isAllSelected:isAllSelected];
}
//加载已选总额
- (void)loadSelectedPrice:(float)price{
    [_accountBackView loadSelectedPrice:price];
}
//是否下拉
- (void)isDrag:(BOOL)isDrag{
    [_accountBackView isDrag:isDrag];
}
@end
