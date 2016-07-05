//
//  TTCMeViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCMeViewCell.h"
#import "TTCMeViewCellHeaderView.h"

@interface TTCMeViewCell()
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *arrowImageView;
@property (strong, nonatomic) UILabel *isUsedLabel;
@property (strong, nonatomic) UIView *otherBackView;
@property (strong, nonatomic) TTCMeViewCellHeaderView *headerView;
@end

@implementation TTCMeViewCell
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
    __block TTCMeViewCell *selfView = self;
    //顶部模式
    _headerView = [[TTCMeViewCellHeaderView alloc] init];
    _headerView.hidden = YES;
    _headerView.stringBlock = ^(NSString *string){
        [selfView buttonPressed:string];
    };
    [self.contentView addSubview:_headerView];
    //其他模式
    _otherBackView = [[UIView alloc] init];
    _otherBackView.hidden = YES;
    [self.contentView addSubview:_otherBackView];
    //图片
    _cellImageView = [[UIImageView alloc] init];
    [_otherBackView addSubview:_cellImageView];
    //nameLabel
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"设备安全锁";
    _nameLabel.textColor = LIGHTDARK;
    _nameLabel.font = FONTSIZESBOLD(33/2);
    [_otherBackView addSubview:_nameLabel];
    //arrowImageView
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_btn_arrow"]];
    [_otherBackView addSubview:_arrowImageView];
    //已启用
    _isUsedLabel = [[UILabel alloc] init];
    _isUsedLabel.text = @"已启用";
    _isUsedLabel.textColor = [UIColor lightGrayColor];
    _isUsedLabel.font = FONTSIZESBOLD(33/2);
    [_otherBackView addSubview:_isUsedLabel];
}
- (void)setSubViewLayout{
    //顶部模式
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //其他模式
    //背景
    [_otherBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //图片
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(100/2);
    }];
    //nameLabel
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(_cellImageView.mas_right).with.offset(10);
    }];
    //arrowImageView
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(-100/2);
    }];
    //已启用
    [_isUsedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(_arrowImageView.mas_left).with.offset(-56/2);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(NSString *)string{
    self.stringBlock(string);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//标题
- (void)loadTitleName:(NSString *)title{
    _nameLabel.text = title;
}
//是否已启用
- (void)isUsed:(BOOL)isUsed{
    if (isUsed) {
        _isUsedLabel.text = @"已启用";
    }else{
        _isUsedLabel.text = @"未启用";
    }
}
//隐藏或显示已启用
- (void)hideIsUsed:(BOOL)hide{
    _isUsedLabel.hidden = hide;
}
//选择模式
- (void)selectCellType:(CellType)type{
    switch (type) {
        case 0:
            [self useFirstType];
            break;
        case 1:
            [self useOtherType];
            break;
        default:
            break;
    }
}
//顶部模式
- (void)useFirstType{
    _headerView.hidden = NO;
    _otherBackView.hidden = YES;
}
//其他模式
- (void)useOtherType{
    _headerView.hidden = YES;
    _otherBackView.hidden = NO;
}
//加载图片
- (void)loadCellImageWithImage:(UIImage *)image{
    _cellImageView.image = image;
}
@end
