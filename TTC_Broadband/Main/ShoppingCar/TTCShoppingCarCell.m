//
//  TTCShoppingCarCell.m
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Cell
#import "TTCShoppingCarCell.h"
#import "TTCShoppingCarCellOtherView.h"
#import "TTCShoppingCarCellFooterView.h"
#import "TTCShoppingCarCellHeaderView.h"
@interface TTCShoppingCarCell()
@property (strong, nonatomic) TTCShoppingCarCellOtherView *otherBackView;
//@property (strong, nonatomic) TTCShoppingCarCellFooterView *footerBackView;
@property (strong, nonatomic) TTCShoppingCarCellHeaderView *hearderBackView;
// 选择按钮
@property (strong, nonatomic) UIButton *btnSelect;

@end
@implementation TTCShoppingCarCell

#pragma mark - Init methods
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return self;
}

- (void) createCell{
    
    [self createUI];
    [self setSubViewLayout];
}

#pragma mark - Life circle
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

#pragma mark - Getters and setters
- (void)createUI{
    
    [self.contentView addSubview:self.btnSelect];
    // 单选和多选的按钮
    self.btnSelect = [[UIButton alloc]init];
    self.btnSelect.selected = YES;
    [self.btnSelect setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:0];
    [self.btnSelect addTarget:self action:@selector(choseGoodsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnSelect];
    
    //顶部模式
    _hearderBackView = [[TTCShoppingCarCellHeaderView alloc] init];
    _hearderBackView.backgroundColor = WHITE;
    _hearderBackView.hidden = YES;
    [self.contentView addSubview:_hearderBackView];
    //其他模式
    _otherBackView = [[TTCShoppingCarCellOtherView alloc] init];
    _otherBackView.backgroundColor = WHITE;
    _otherBackView.hidden = YES;
    [self.contentView addSubview:_otherBackView];

}

- (void)setSubViewLayout{
    
    //顶部模式
    __weak __typeof (&*self)weaks = self;
    
    [_btnSelect mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.equalTo(weaks.contentView).offset(20);
        make.centerY.mas_equalTo(weaks.contentView.mas_centerY);
        make.width.equalTo(@60);
        make.bottom.top.equalTo(weaks.contentView);
    
    }];
    
    [_hearderBackView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.mas_equalTo(self.contentView);
    }];
    //其他模式
    [_otherBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weaks.contentView).with.offset(70);
        make.top.right.bottom.mas_equalTo(weaks.contentView);
//        make.edges.mas_equalTo(self.contentView);
    }];

}

#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
#pragma mark - selectBtnClick

- (void) choseGoodsBtnClick:(UIButton *)btn{
    
    
    if (self.btnSelect.selected) {
        
        self.btnSelect.selected = NO;
        [self.btnSelect setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:0];
    }
    else{
      
        self.btnSelect.selected = YES;
        [self.btnSelect setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:0];
    }
    
    // 发一个通知
    if ([self.cellDelegate respondsToSelector:@selector(changeCellBottonSelectedButton:)]) {
            
        [self.cellDelegate changeCellBottonSelectedButton:self.btnSelect];
    }
}

// 获取列表的IndexPath
- (void) selectBtnTagWithIndex:(NSIndexPath *)indexPath {
    
    self.btnSelect.tag = 100 + indexPath.row;

}

/**
 *  取消或者选中全选状态
 *
 *  @param button    订单单选按钮
 *  @param allButton 全选按钮
 */
- (void) btnStatusWithAllChoseButtonWithFlag:(BOOL) btnFlag{
    self.btnSelect.selected = btnFlag;
   [self.btnSelect setImage:btnFlag?[UIImage imageNamed:@"debt_btn_selected"]:[UIImage imageNamed:@"debt_btn_normal"] forState:0];
}

//选择Cell类型
- (void)selectCellType:(CellType)type{
    switch (type) {
        case 0:
            [self useHearderCellType];
            break;
        case 1:
            [self useOtherCellType];
            break;
        case 2:
            [self useFooterCellType];
            break;
        default:
            break;
    }
}


//顶部类型
- (void)useHearderCellType{
    _btnSelect.hidden = YES;
    _hearderBackView.hidden = NO;
    _otherBackView.hidden = YES;
//    _footerBackView.hidden = YES;
}
//其他类型
- (void)useOtherCellType{
    _btnSelect.hidden = NO;
    _hearderBackView.hidden = YES;
    _otherBackView.hidden = NO;
//    _footerBackView.hidden = YES;
}
//尾部类型
- (void)useFooterCellType{
    _btnSelect.hidden = NO;
    _hearderBackView.hidden = YES;
    _otherBackView.hidden = YES;
//    _footerBackView.hidden = NO;
}
//加载产品详情
- (void)loadWithImage:(NSString *)smallimg title:(NSString *)title contents:(NSString *)contents price:(NSString *)price count:(NSString *)count{
    [_otherBackView loadWithImage:smallimg title:title contents:contents price:price count:count];
}
//加载总价
- (void)loadAllPrice:(NSString *)allPrice{
//    [_footerBackView loadAllPrice:allPrice];
}
//加载用户名字 营销人员名字
- (void)loadUserName:(NSString *)name sellName:(NSString *)sellName{
    [_hearderBackView loadUserName:name sellName:sellName];
}
@end
