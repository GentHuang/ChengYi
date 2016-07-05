//
//  TTCLockViewControllerCell.m
//  TTC_Broadband
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCLockViewControllerCell.h"

@interface TTCLockViewControllerCell()
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UISwitch *openSwitch;
@end

@implementation TTCLockViewControllerCell
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
    //nameLabel
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"设备安全锁";
    _nameLabel.textColor = LIGHTDARK;
    _nameLabel.font = FONTSIZESBOLD(33/2);
    [self.contentView addSubview:_nameLabel];
    //开关
    _openSwitch = [[UISwitch alloc] init];
    _openSwitch.on = NO;
    [_openSwitch addTarget:self action:@selector(switchPressed) forControlEvents:UIControlEventValueChanged];
    [_openSwitch setOnTintColor:DARKBLUE];
    [self.contentView addSubview:_openSwitch];
}
- (void)setSubViewLayout{
    //nameLabel
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(100/2);
    }];
    //开关
    [_openSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(-80/2);
    }];
}
#pragma mark - Event response
//点击开关
- (void)switchPressed{
    [_openSwitch setOn:!_openSwitch.on animated:YES];
    self.indexBlock(0);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//标题
- (void)loadTitleName:(NSString *)title{
    _nameLabel.text = title;
}
//开关状态
- (void)isON:(BOOL)isON{
    [_openSwitch setOn:isON animated:YES];
}
@end
