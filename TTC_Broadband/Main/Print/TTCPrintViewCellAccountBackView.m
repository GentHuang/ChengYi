//
//  TTCPrintViewCellAccountBackView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPrintViewCellAccountBackView.h"
@interface TTCPrintViewCellAccountBackView()
@property (strong, nonatomic) UILabel *accountNameLabel;
@property (strong, nonatomic) UIImageView *accountRMBImageView;
@property (strong, nonatomic) UILabel *accountLabel;
@property (strong, nonatomic) UIButton *accountButton;
@property (strong, nonatomic) UIButton *selectedButton;
@property (strong, nonatomic) UIButton *dragButton;
@property (strong, nonatomic) UILabel *typeLabel;
@end
@implementation TTCPrintViewCellAccountBackView
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
    self.clipsToBounds = NO;
    //选择按钮
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedButton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
    [_selectedButton setImageEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    [self addSubview:_selectedButton];
    //下拉按钮
    _dragButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dragButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_dragButton setImage:[UIImage imageNamed:@"print_btn_dragDown_nol"] forState:UIControlStateNormal];
    [_dragButton setImage:[UIImage imageNamed:@"print_btn_dragDown_sel"] forState:UIControlStateSelected];
    [_dragButton setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
    [self addSubview:_dragButton];
    //业务类
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.userInteractionEnabled = NO;
    _typeLabel.text = @"发票分组:1";
    _typeLabel.font = FONTSIZESBOLD(30/2);
    _typeLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_typeLabel];
    //勾选发票总额
    _accountNameLabel = [[UILabel alloc] init];
    _accountNameLabel.text = @"勾选发票总额：";
    _accountNameLabel.textAlignment = NSTextAlignmentRight;
    _accountNameLabel.textColor = [UIColor lightGrayColor];
    _accountNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_accountNameLabel];
    //RMB图片
    _accountRMBImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb"]];
    [self addSubview:_accountRMBImageView];
    //总价
    _accountLabel = [[UILabel alloc] init];
    _accountLabel.text = @"380.00";
    _accountLabel.textAlignment = NSTextAlignmentRight;
    _accountLabel.textColor = [UIColor lightGrayColor];
    _accountLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_accountLabel];
    //打印发票
    _accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _accountButton.layer.masksToBounds = YES;
    _accountButton.layer.cornerRadius = 3;
    _accountButton.backgroundColor = DARKBLUE;
    [_accountButton setTitle:@"打印发票" forState:UIControlStateNormal];
    [_accountButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _accountButton.titleLabel.font = FONTSIZESBOLD(31/2);
    [self addSubview:_accountButton];
}
- (void)setSubViewLayout{
    //选择按钮
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(153/2);
        make.top.bottom.mas_equalTo(0);
    }];
    //下拉按钮
    [_dragButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_selectedButton.mas_right);
        make.width.mas_equalTo(250/2);
        make.top.bottom.mas_equalTo(0);
    }];
    //业务类
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_selectedButton.mas_right).with.offset(0);
    }];
    //打印发票
    [_accountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-60/2);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(174/2);
        make.height.mas_equalTo(53/2);
    }];
    //总价
    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(_accountButton.mas_left).with.offset(-30/2);
    }];
    //RMB图片
    [_accountRMBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(1);
        make.right.mas_equalTo(_accountLabel.mas_left).with.offset(-16/2);
    }];
    //勾选发票总额
    [_accountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(_accountRMBImageView.mas_left).with.offset(-16/2);
    }];
    
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _accountButton) {
        //点击打印发票
        self.stringBlock(@"打印发票");
    }else if(button == _selectedButton){
        //点击选择按钮
        self.stringBlock(@"选择按钮");
    }else if(button == _dragButton){
        //点击下拉按钮
        self.stringBlock(@"下拉按钮");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载业务类型
- (void)loadTypeWithString:(NSString *)type{
    _typeLabel.text = type;
}
//是否选择(全局)
- (void)isAllSelected:(BOOL)isAllSelected{
    _selectedButton.selected = isAllSelected;
}
//加载已选总额
- (void)loadSelectedPrice:(float)price{
    _accountLabel.text = [NSString stringWithFormat:@"%.02f",price];
}
//是否下拉
- (void)isDrag:(BOOL)isDrag{
    _dragButton.selected = isDrag;
}
@end
