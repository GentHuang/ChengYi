//
//  TTCNewCustomViewControllerDragViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/12/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCNewCustomViewControllerDragViewCell.h"
//Macro
#define kSelectedColor [UIColor colorWithRed:98/256.0 green:98/256.0 blue:98/256.0 alpha:1]
@interface TTCNewCustomViewControllerDragViewCell()
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UIView *selectedBackView;
@end

@implementation TTCNewCustomViewControllerDragViewCell
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
    self.contentView.backgroundColor = WHITE;
    //selectedBackView
    _selectedBackView = [[UIView alloc] init];
    _selectedBackView.userInteractionEnabled = NO;
    _selectedBackView.backgroundColor = kSelectedColor;
    [self.contentView addSubview:_selectedBackView];
    //addressLabel
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.userInteractionEnabled = NO;
    _addressLabel.textColor = [UIColor lightGrayColor];
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = FONTSIZESBOLD(30/2);
    [_selectedBackView addSubview:_addressLabel];
}
- (void)setSubViewLayout{
    //selectedBackView
    [_selectedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-3);
    }];
    //addressLabel
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectedBackView.mas_centerY);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//读取地址
- (void)loadAddressWithString:(NSString *)addressString{
    _addressLabel.text = addressString;
    _addressString = addressString;
}
//选中
- (void)isSelected:(BOOL) isSelected{
    if (isSelected) {
        _selectedBackView.backgroundColor = kSelectedColor;
        _addressLabel.textColor = WHITE;
    }else{
        _selectedBackView.backgroundColor = WHITE;
        _addressLabel.textColor = [UIColor lightGrayColor];
    }
}
@end
