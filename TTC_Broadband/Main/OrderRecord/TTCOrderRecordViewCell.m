//
//  TTCOrderRecordViewCell.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordViewCell.h"
#import "TTCOrderRecordViewCellSetHeaderView.h"
#import "TTCOrderRecordViewCellSetFooterView.h"
#import "TTCOrderRecordViewCellUserView.h"
#import "TTCOrderRecordViewCellSetDetailView.h"
#import "TTCOrderRecordViewCellSellDetailView.h"
@interface TTCOrderRecordViewCell()
@property (strong, nonatomic) TTCOrderRecordViewCellUserView *userView;
@property (strong, nonatomic) TTCOrderRecordViewCellSetHeaderView *setHeaderBackView;
@property (strong, nonatomic) TTCOrderRecordViewCellSetFooterView *setFooterBackView;
@property (strong, nonatomic) TTCOrderRecordViewCellSetDetailView *setDetailBackView;
@property (strong, nonatomic) TTCOrderRecordViewCellSellDetailView *sellDetailView;
@end
@implementation TTCOrderRecordViewCell
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
    __block TTCOrderRecordViewCell *selfView = self;
    //用户
    //背景
    _userView = [[TTCOrderRecordViewCellUserView alloc] init];
    _userView.hidden = YES;
    _userView.backgroundColor = WHITE;
    [self.contentView addSubview:_userView];
    //套餐头部
    //背景
    _setHeaderBackView = [[TTCOrderRecordViewCellSetHeaderView alloc] init];
    _setHeaderBackView.hidden = YES;
    _setHeaderBackView.backgroundColor = WHITE;
    [self.contentView addSubview:_setHeaderBackView];
    //套餐尾部
    //背景
    _setFooterBackView = [[TTCOrderRecordViewCellSetFooterView alloc] init];
    _setFooterBackView.hidden = YES;
    _setFooterBackView.backgroundColor = WHITE;
    [self.contentView addSubview:_setFooterBackView];
    //套餐详情
    //背景
    _setDetailBackView = [[TTCOrderRecordViewCellSetDetailView alloc] init];
    _setDetailBackView.hidden = YES;
    _setDetailBackView.backgroundColor = WHITE;
    _setDetailBackView.indexBlock = ^(NSInteger index){
        selfView.indexBlock(index);
    };
    [self.contentView addSubview:_setDetailBackView];
    //销售明细
    _sellDetailView = [[TTCOrderRecordViewCellSellDetailView alloc] init];
    _sellDetailView.hidden = YES;
    _sellDetailView.backgroundColor = WHITE;
    [self.contentView addSubview:_sellDetailView];
}
- (void)setSubViewLayout{
    //用户
    //背景
    [_userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //套餐头部
    //背景
    [_setHeaderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //套餐尾部
    //背景
    [_setFooterBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //套餐详情
    //背景
    [_setDetailBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //销售明细
    [_sellDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//选择Cell类型
- (void)selectCellType:(CellType)type{
    switch (type) {
        case 0:
            [self useUserType];
            break;
        case 1:
            [self useSetHeaderType];
            break;
        case 2:
            [self useSetDetailType];
            break;
        case 3:
            [self useSetFooterType];
            break;
        case 4:
            [self useSellDettailType];
            break;
        default:
            break;
    }
}
//用户
- (void)useUserType{
    _userView.hidden = NO;
    _setHeaderBackView.hidden = YES;
    _setFooterBackView.hidden = YES;
    _setDetailBackView.hidden = YES;
    _sellDetailView.hidden = YES;
    
}
//套餐头部
- (void)useSetHeaderType{
    _userView.hidden = YES;
    _setHeaderBackView.hidden = NO;
    _setFooterBackView.hidden = YES;
    _setDetailBackView.hidden = YES;
    _sellDetailView.hidden = YES;
    
}
//套餐详情
- (void)useSetDetailType{
    _userView.hidden = YES;
    _setHeaderBackView.hidden = YES;
    _setFooterBackView.hidden = YES;
    _setDetailBackView.hidden = NO;
    _sellDetailView.hidden = YES;
    
}
//套餐尾部
- (void)useSetFooterType{
    _userView.hidden = YES;
    _setHeaderBackView.hidden = YES;
    _setFooterBackView.hidden = NO;
    _setDetailBackView.hidden = YES;
    _sellDetailView.hidden = YES;
    
}
//销售明细
- (void)useSellDettailType{
    _userView.hidden = YES;
    _setHeaderBackView.hidden = YES;
    _setFooterBackView.hidden = YES;
    _setDetailBackView.hidden = YES;
    _sellDetailView.hidden = NO;
}
//加载用户名字
- (void)loadUserName:(NSString *)name{
    [_userView loadUserName:name];
}
//加载总金额 营销人员部门 姓名
- (void)loadPrice:(NSString *)price sellManDepName:(NSString *)depName name:(NSString *)name{
    [_setFooterBackView loadPrice:price sellManDepName:depName name:name];
}
//加载套餐详细内容
- (void)loadWithPname:(NSString *)pname createtime:(NSString *)createtime fees:(NSString *)fees count:(NSString *)count{
    [_setDetailBackView loadWithPname:pname createtime:createtime fees:fees count:count];
}
//加载业务流水号
- (void)loadOrderID:(NSString *)orderid{
    [_setHeaderBackView loadOrderID:orderid];
}
//加载套餐详细内容(销售明细)
- (void)loadWithTitle:(NSString *)title stime:(NSString *)stime price:(NSString *)price etime:(NSString *)etime{
    [_setDetailBackView loadWithTitle:title stime:stime price:price etime:etime];
}
//加载客户信息
- (void)loadWithDate:(NSString *)date keyno:(NSString *)keyno{
    [_sellDetailView loadWithDate:date keyno:keyno];
}
//加载支付状态
- (void)loadTypeLabelWithTypeString:(NSString *)typeString{
    [_setFooterBackView loadTypeLabelWithTypeString:typeString];
}
//显示前往支付
- (void)goToPay:(BOOL)isAll{
    [_setDetailBackView goToPay:isAll];
}
//加载业务受理时间
- (void)loadDateWithDateString:(NSString *)dateString{
    [_setHeaderBackView loadDateWithDateString:dateString];
}
@end
