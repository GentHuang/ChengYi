//
//  TTCDebtViewCellSetHeaderView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCDebtViewCellSetHeaderView.h"

@interface TTCDebtViewCellSetHeaderView()
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UILabel *priceNameLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *dragButton;
@property (strong, nonatomic) UIButton *selectedButton;
@end

@implementation TTCDebtViewCellSetHeaderView
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    //选择按钮
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectedButton.userInteractionEnabled = NO;
    [_selectedButton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
    [_selectedButton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
    [self addSubview:_selectedButton];
    //用户
    _userLabel = [[UILabel alloc] init];
    _userLabel.textAlignment = NSTextAlignmentRight;
    _userLabel.text = @"用户ID 987654321";
    _userLabel.textColor = LIGHTDARK;
    _userLabel.font = FONTSIZESBOLD(26/2);
    [self addSubview:_userLabel];
    //下拉箭头
    _dragButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dragButton.selected = NO;
    [_dragButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_dragButton setImage:[UIImage imageNamed:@"udel_btn_dragDown_nol"] forState:UIControlStateNormal];
    [_dragButton setImage:[UIImage imageNamed:@"udel_btn_dragDown_sel"] forState:UIControlStateSelected];
    [_dragButton setImageEdgeInsets:UIEdgeInsetsMake(0, 120, 0, 0)];
    [self addSubview:_dragButton];
    //总金额
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"100.00";
    _priceLabel.textColor = ORANGE;
    _priceLabel.font = FONTSIZESBOLD(24/2);
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_priceLabel];
    //rmb
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb1"]];
    [self addSubview:_rmbImageView];
    //总金额
    _priceNameLabel = [[UILabel alloc] init];
    _priceNameLabel.text = @"总金额：";
    _priceNameLabel.textColor = [UIColor lightGrayColor];
    _priceNameLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_priceNameLabel];
}
- (void)setSubViewLayout{
    //选择按钮
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(60/2);
        make.width.height.mas_equalTo(56/2);
    }];
    //账单ID
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_selectedButton.mas_right).with.offset(20/2);
    }];
    //下拉箭头
    [_dragButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(200);
    }];
    //总金额
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-155/2);
    }];
    //rmb
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(1);
        make.right.mas_equalTo(_priceLabel.mas_left).with.offset(-8/2);
    }];
    //总金额
    [_priceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(_rmbImageView.mas_left).with.offset(-8/2);
    }];
}
#pragma mark - Event response
//点击下拉
- (void)buttonPressed{
    self.buttonBlock(nil);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载用户ID 总金额
- (void)loadUserID:(NSString *)userID arrearsun:(NSString *)arrearsun{
    _userLabel.text = [NSString stringWithFormat:@"用户 %@",userID];
    _priceLabel.text = arrearsun;
}
//选择
- (void)isSelected:(BOOL)isSelected{
    _selectedButton.selected = isSelected;
}
//是否收起
- (void)isPackUp:(BOOL)isPackUp{
    _dragButton.selected = isPackUp;
}
@end
