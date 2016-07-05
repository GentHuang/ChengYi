//
//  TTCDebtViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCDebtViewCell.h"
#import "TTCDebtViewCellAccountBackView.h"
#import "TTCDebtViewCellSetHeaderView.h"
//Model
#import "TTCUserLocateViewControllerArrearOutputArreardetsModel.h"
//Macro
#define kTapTag 34000
#define kButtonTag 35000
@interface TTCDebtViewCell()<UITextFieldDelegate>
@property (strong, nonatomic) TTCDebtViewCellAccountBackView *accountBackView;
@property (strong, nonatomic) TTCDebtViewCellSetHeaderView *setHeaderBackView;
@property (strong, nonatomic) UIView *detailTypeBackView;
@property (strong, nonatomic) UIView *labelView;
@end
@implementation TTCDebtViewCell
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
    self.clipsToBounds = YES;
    __block TTCDebtViewCell *selfView = self;
    //总计
    //背景
    _accountBackView = [[TTCDebtViewCellAccountBackView alloc] init];
    _accountBackView.hidden = YES;
    _accountBackView.backgroundColor = WHITE;
    _accountBackView.buttonBlock = ^(UIButton *button){
        [selfView buttonPress];
    };
    [self.contentView addSubview:_accountBackView];
    //套餐详情
    //背景
    _detailTypeBackView = [[UIView alloc] init];
    [self.contentView addSubview:_detailTypeBackView];
    //头部
    _setHeaderBackView = [[TTCDebtViewCellSetHeaderView alloc] init];
    _setHeaderBackView.backgroundColor = WHITE;
    _setHeaderBackView.buttonBlock = ^(UIButton *button){
        [selfView buttonPress];
    };
    [_detailTypeBackView addSubview:_setHeaderBackView];
    //套餐详情背景
    _labelView = [[UIView alloc] init];
    _labelView.backgroundColor = WHITE;
    _labelView.userInteractionEnabled = YES;
    [_detailTypeBackView addSubview:_labelView];
}
- (void)setSubViewLayout{
    //总计
    //背景
    [_accountBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //套餐详情
    //背景
    [_detailTypeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //头部
    [_setHeaderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(133/2);
    }];
    //套餐详情背景
    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_setHeaderBackView.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
}
#pragma mark - Event response
//点击下拉
- (void)buttonPress{
    self.buttonBlock(0,0);
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
            [self useSetDetailType];
            break;
        default:
            break;
    }
}
//总计
- (void)useAccountType{
    _accountBackView.hidden = NO;
    _detailTypeBackView.hidden = YES;
}
//套餐详情
- (void)useSetDetailType{
    _accountBackView.hidden = YES;
    _detailTypeBackView.hidden = NO;
}
//加载总价
- (void)loadPrice:(NSString *)price{
    [_accountBackView loadPrice:price];
}
//创建详细套餐
- (void)loadDetailSetWithArray:(NSArray *)setArray{
    //清空旧数据
    [self deleteSubView:_labelView];
    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(setArray.count*(82/2));
    }];
    //添加详情
    TTCUserLocateViewControllerArrearOutputArreardetsModel *arrearModel;
    for (int i = 0; i < setArray.count; i ++) {
        arrearModel = setArray[i];
        //背景
        UIView *backView = [[UIView alloc] init];
        backView.userInteractionEnabled = YES;
        backView.tag = i + kTapTag;
        [_labelView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(i*(82/2));
            make.height.mas_equalTo(82/2);
            make.left.right.mas_equalTo(0);
        }];
        //上划线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = LIGHTGRAY;
        [backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        //套餐名称
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = arrearModel.pname;
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = FONTSIZESBOLD(26/2);
        [backView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lineView.mas_top).with.offset(82/4);
            make.left.mas_equalTo(60/2);
        }];
        //开始和结束日期
        UILabel *dateLabel = [[UILabel alloc] init];
        NSRange range = [arrearModel.stime rangeOfString:@"T"];
        NSString *stime = [arrearModel.stime substringToIndex:range.location];
        range = [arrearModel.etime rangeOfString:@"T"];
        NSString *etime = [arrearModel.etime substringToIndex:range.location];
        dateLabel.text = [NSString stringWithFormat:@"时间  %@ 至 %@",stime,etime];
        dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.font = FONTSIZESBOLD(26/2);
        [backView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.left.mas_equalTo(titleLabel.mas_right).with.offset(20/2);
        }];
        //总金额
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.text = arrearModel.fees;
        priceLabel.textColor = ORANGE;
        priceLabel.font = FONTSIZESBOLD(24/2);
        priceLabel.textAlignment = NSTextAlignmentRight;
        [backView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.right.mas_equalTo(-155/2);
        }];
        //rmb
        UIImageView *rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb1"]];
        [backView addSubview:rmbImageView];
        [rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.right.mas_equalTo(priceLabel.mas_left).with.offset(-8/2);
        }];
        //总金额
        UILabel *priceNameLabel = [[UILabel alloc] init];
        priceNameLabel.text = @"金额：";
        priceNameLabel.textColor = [UIColor lightGrayColor];
        priceNameLabel.font = FONTSIZESBOLD(24/2);
        [backView addSubview:priceNameLabel];
        [priceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.right.mas_equalTo(rmbImageView.mas_left).with.offset(-8/2);
        }];
    }
}
//清空子控件
- (void)deleteSubView:(UIView *)view{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}
//选择
- (void)isSelected:(BOOL)isSelected{
    [_setHeaderBackView isSelected:isSelected];
}
//是否收起
- (void)isPackUp:(BOOL)isPackUp{
    [_setHeaderBackView isPackUp:isPackUp];
}
//加载用户ID 总金额
- (void)loadUserID:(NSString *)userID arrearsun:(NSString *)arrearsun{
    [_setHeaderBackView loadUserID:userID arrearsun:arrearsun];
}
//加载已选欠费
- (void)loadTotalPrice:(NSString *)totalPrice{
    [_accountBackView loadTotalPrice:totalPrice];
}
//加载总额名称，是否隐藏已选欠费，按钮名称
- (void)loadPriceNameWithPriceName:(NSString *)priceName hide:(BOOL)isHide buttonTitle:(NSString *)buttonTitle{
    [_accountBackView loadPriceNameWithPriceName:priceName hide:isHide buttonTitle:buttonTitle];
}

@end
