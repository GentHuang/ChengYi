//
//  TTCAddAddressViewControllerCell.m
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCAddAddressViewControllerCell.h"
#import "TTCAddAddressViewControllerCellTopView.h"
#import "TTCAddAddressViewControllerCellOtherView.h"

@interface TTCAddAddressViewControllerCell()
@property (strong, nonatomic) TTCAddAddressViewControllerCellTopView *topView;
@property (strong, nonatomic) TTCAddAddressViewControllerCellOtherView *otherView;
@end

@implementation TTCAddAddressViewControllerCell
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
    //顶部视图
    _topView = [[TTCAddAddressViewControllerCellTopView alloc] init];
    _topView.hidden = YES;
    [self.contentView addSubview:_topView];
    //其他视图
    _otherView = [[TTCAddAddressViewControllerCellOtherView alloc] init];
    _otherView.hidden = YES;
    [self.contentView addSubview:_otherView];
}
- (void)setSubViewLayout{
    //顶部视图
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //其他视图
    [_otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}
#pragma mark - Event response
#pragma mark - Data request
#pragma mark - Protocol methods
#pragma mark - Other methods
//选择Cell模式
- (void)selectCellModel:(CellMode)cellMode{
    switch (cellMode) {
        case 0:
            [self selectTopViewMode];
            break;
        case 1:
            [self selectOtherViewMode];
            break;
        default:
            break;
    }
}
//顶部模式
- (void)selectTopViewMode{
    _topView.hidden = NO;
    _otherView.hidden = YES;
}
//其他模式
- (void)selectOtherViewMode{
    _topView.hidden = YES;
    _otherView.hidden = NO;
}
//加载住宅地址 片区 可安装业务 住宅状态
- (void)loadAddress:(NSString *)addressString area:(NSString *)areaString business:(NSString *)businessString status:(NSString *)statusString{
    [_otherView loadAddress:addressString area:areaString business:businessString status:statusString];
}
//加载业务区
- (void)loadArea:(NSString *)areaString{
    [_topView loadArea:areaString];
}
//收起键盘
- (void)packUpKeyBoard{
    [_topView packUpKeyBoard];
}
@end
