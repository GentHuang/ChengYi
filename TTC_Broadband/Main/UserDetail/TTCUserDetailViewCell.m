//
//  TTCUserDetailViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserDetailViewCell.h"
//Model
#import "TTCUserLocateViewControllerUserProductOutputProsModel.h"
//View
#import "TTCUserDetailSecondView.h"
#import "TTCUserDetailFirstView.h"
//优化部分
#import "TTCUserDetailTabeleView.h"

//Macro
#define kButtonTag 70000
#define KSpaceWidth 8
@interface TTCUserDetailViewCell()
@property (strong, nonatomic) UIView *otherBackView;
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *businessNumLabel;
@property (strong, nonatomic) UILabel *deviceNumLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *businessNameLabel;
@property (strong, nonatomic) UIButton *dragButton;
@property (strong, nonatomic) UIView *labelView;
@property (strong, nonatomic) UILabel *definitionLabel;
@property (strong, nonatomic) UILabel *mainSecondLabel;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) TTCUserDetailSecondView *secondView;
@property (strong, nonatomic) TTCUserDetailFirstView *firstView;
//展开部分使用tabelView来替代
@property (strong, nonatomic) TTCUserDetailTabeleView *extendtableView;



@property (strong, nonatomic) UILabel *spaceLabel;
//临时
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation TTCUserDetailViewCell
#pragma mark - Init methods
- (void)initData{
    _dataArray = @[@"主机",@"高清"];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initData];
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
    self.contentView.backgroundColor = WHITE;
    __block TTCUserDetailViewCell *selfView = self;
    //第一种模式
    _firstView = [[TTCUserDetailFirstView alloc] init];
    _firstView.hidden = YES;
    _firstView.stringBlock = ^(NSString *string){
        [selfView firstButtonPressed:string];
    };
    [self.contentView addSubview:_firstView];
    //第二种模式
    _secondView = [[TTCUserDetailSecondView alloc] init];
    _secondView.hidden = YES;
    _secondView.stringBlock = ^(NSString *string){
        [selfView secondButtonPressed:string];
    };
    [self.contentView addSubview:_secondView];
    //其他模式
    //背景
    _otherBackView = [[UIView alloc] init];
    _otherBackView.hidden = YES;
    [self.contentView addSubview:_otherBackView];
    //cellImageView
//    _cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"udel_img_simulate"]];
    _cellImageView = [[UIImageView alloc]init];
    _cellImageView.image = [UIImage imageNamed:@"udel_img_simulate"];
    [_otherBackView addSubview:_cellImageView];
    //businessNumLabel
    _businessNumLabel = [[UILabel alloc] init];
    _businessNumLabel.text = @"102265489099";
    _businessNumLabel.hidden = YES;
    _businessNumLabel.textColor = [UIColor lightGrayColor];
    _businessNumLabel.font = FONTSIZESBOLD(24/2);
    [_otherBackView addSubview:_businessNumLabel];
    //智能卡号
    _deviceNumLabel = [[UILabel alloc] init];
    _deviceNumLabel.text = @"设备编号:4384729374298374923(型号C-D2)";
    _deviceNumLabel.textColor = [UIColor lightGrayColor];
    _deviceNumLabel.font = FONTSIZESBOLD(24/2);
    [_otherBackView addSubview:_deviceNumLabel];
    //0-标清 1-高清
    _definitionLabel = [[UILabel alloc] init];
    _definitionLabel.text = @"在用";
    _definitionLabel.textColor = WHITE;
    _definitionLabel.textAlignment = NSTextAlignmentCenter;
    _definitionLabel.font = FONTSIZESBOLD(24/2);
    _definitionLabel.backgroundColor = DARKBLUE;
    //add
//    _definitionLabel.backgroundColor = [UIColor orangeColor];
    _definitionLabel.layer.masksToBounds = YES;
    _definitionLabel.layer.cornerRadius = 3;
    [_otherBackView addSubview:_definitionLabel];
    //0-主机 1-副机
    _mainSecondLabel = [[UILabel alloc] init];
    _mainSecondLabel.text = @"主机";
    _mainSecondLabel.textColor = WHITE;
    _mainSecondLabel.textAlignment = NSTextAlignmentCenter;
    _mainSecondLabel.font = FONTSIZESBOLD(24/2);
    _mainSecondLabel.backgroundColor = DARKBLUE;
    _mainSecondLabel.layer.masksToBounds = YES;
    _mainSecondLabel.layer.cornerRadius = 3;
    [_otherBackView addSubview:_mainSecondLabel];
    
    
    //空白
    _spaceLabel = [[UILabel alloc] init];
    _spaceLabel.textColor = WHITE;
    _spaceLabel.textAlignment = NSTextAlignmentCenter;
    _spaceLabel.font = FONTSIZESBOLD(24/2);
    _spaceLabel.backgroundColor = DARKBLUE;
    //add
    _spaceLabel.backgroundColor = [UIColor grayColor];
    _spaceLabel.layer.masksToBounds = YES;
    _spaceLabel.layer.cornerRadius = 3;
    [_otherBackView addSubview:_spaceLabel];
    //
    //客户类型
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.text = @"普通";
    _typeLabel.textColor = WHITE;
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    _typeLabel.font = FONTSIZESBOLD(24/2);
    _typeLabel.backgroundColor = DARKBLUE;
    
    //add
    _typeLabel.backgroundColor = [UIColor grayColor];
    _typeLabel.layer.masksToBounds = YES;
    _typeLabel.layer.cornerRadius = 3;
    [_otherBackView addSubview:_typeLabel];
    
    //开通时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"开通时间:2015-9-10";
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = FONTSIZESBOLD(24/2);
    [_otherBackView addSubview:_timeLabel];
    //businessNameLabel
    _businessNameLabel = [[UILabel alloc] init];
    _businessNameLabel.textColor = [UIColor lightGrayColor];
    _businessNameLabel.text = @"模拟业务";
    _businessNameLabel.textAlignment = NSTextAlignmentCenter;
    _businessNameLabel.font = FONTSIZESBOLD(24/2);
    _businessNameLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _businessNameLabel.layer.borderWidth = 0.5;
    _businessNameLabel.layer.masksToBounds = YES;
    _businessNameLabel.layer.cornerRadius = 4;
    [_otherBackView addSubview:_businessNameLabel];
    _businessNameLabel.hidden= YES;
    
    //dragButton
    _dragButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dragButton setBackgroundImage:[UIImage imageNamed:@"udel_btn_dragDown_nol"] forState:UIControlStateNormal];
    [_dragButton setBackgroundImage:[UIImage imageNamed:@"udel_btn_dragDown_sel"] forState:UIControlStateSelected];
    [_otherBackView addSubview:_dragButton];
#if 0
    //套餐详情背景
    _labelView = [[UIView alloc] init];
    _labelView.backgroundColor = CLEAR;
    [_otherBackView addSubview:_labelView];
#else
    _extendtableView =[[TTCUserDetailTabeleView alloc]init];
    _extendtableView.backgroundColor =[UIColor greenColor];
    [_otherBackView addSubview:_extendtableView];
#endif
    
    
    
    //下划线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1];
    [_otherBackView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)setSubViewLayout{
    //第一种模式
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //第二种模式
    [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //其他模式
    //背景
    [_otherBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //CellImageView
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(59/2);
        make.left.mas_equalTo(66/2);
        make.width.height.mas_equalTo(152/2);
    }];
    //bussinessNumLabel
    [_businessNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_cellImageView.mas_top).with.offset(10);
        make.left.mas_equalTo(_cellImageView.mas_right).with.offset(80/2);
    }];
    //智能卡号
    [_deviceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_cellImageView.mas_top).with.offset(10);
        make.left.mas_equalTo(_businessNumLabel.mas_left);
    }];
    //0-主机 1-副机
    [_mainSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_deviceNumLabel.mas_centerY);
        make.left.mas_equalTo(370);
        make.width.mas_equalTo(90/2);
        make.height.mas_equalTo(40/2);
    }];
    //0-标清 1-高清
    [_definitionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_deviceNumLabel.mas_centerY);
        make.left.mas_equalTo(_mainSecondLabel.mas_right).with.offset(2);
        make.width.mas_equalTo(90/2);
        make.height.mas_equalTo(40/2);
    }];
    //客户类型
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_deviceNumLabel.mas_centerY);
        make.left.mas_equalTo(370);
        make.height.mas_equalTo(40/2);
    }];
    //空白label
    [_spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_deviceNumLabel.mas_centerY);
        make.left.equalTo(_typeLabel.mas_left);
        make.height.mas_equalTo(40/2);
    }];
    //开通时间
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_deviceNumLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(_businessNumLabel.mas_left);
    }];
    //businessNameLabel
    [_businessNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(75/2);
        make.right.mas_equalTo(-60/2);
        make.width.mas_equalTo(135/2);
        make.height.mas_equalTo(40/2);
    }];
    //dragButton
    [_dragButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_businessNameLabel.mas_bottom).with.offset(-16/2);
//        make.centerY.equalTo(_otherBackView);
        make.right.mas_equalTo(-87/2);
    }];
    
#if 0
    //套餐详情背景
    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(267/2);
        make.left.right.mas_equalTo(0);
    }];
#else
    [_extendtableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(267/2);
        make.left.right.mas_equalTo(0);
    }];
#endif
}
#pragma mark - Event response
//第一种模式按钮点击
- (void)firstButtonPressed:(NSString *)string{
    self.firstStringBlock(string);
}
//第二种模式按钮点击
- (void)secondButtonPressed:(NSString *)string{
    self.secondStringBlock(string);
}
//续订按钮
- (void)buyButtonPressed:(UIButton *)button{
    self.cellIndexBlock(0,(button.tag - kButtonTag));
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//业务图片
- (void)loadCellImageView:(UIImage *)image{
    _cellImageView.image = image;
}
//业务编号
- (void)loadBusinessNumLabel:(NSString *)businessNumString{
    _businessNumLabel.text = businessNumString;
}
//智能卡号
- (void)loadDeviceNumLabel:(NSString *)deviceNumString{
    _deviceNumLabel.text = deviceNumString;
}
//用户状态
- (void)loadTimeLabel:(NSString *)timeString{
    switch ([timeString intValue]) {
        case 0:
            timeString = @"已报装";
            break;
        case 1:
            timeString = @"已派工";
            break;
        case 2:
            timeString = @"正使用";
            break;
        case 3:
            timeString = @"停用";
            break;
        case 4:
            timeString = @"已迁移";
            break;
        case 5:
            timeString = @"注销";
            break;
        case 6:
            timeString = @"已整转";
            break;
        case 7:
            timeString = @"已申请销户";
            break;
        case 8:
            timeString = @"已退网审核";
            break;
        case 9:
            timeString = @"已退网结算";
            break;
        default:
            break;
    }
    _timeLabel.text = [NSString stringWithFormat:@"用户状态：%@",timeString];
}
//业务名称
- (void)loadBusinessNameLabel:(NSString *)businessNameString{
    int businessType = [businessNameString intValue];
    _businessNameLabel.hidden= YES;
    switch (businessType) {
        case 0:{
            _mainSecondLabel.hidden = YES;
            _definitionLabel.hidden = NO;
            _businessNameLabel.text = @"模拟业务";
            [_typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(370);
            }];
            [_spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(_typeLabel.mas_left);
                make.right.equalTo(_typeLabel.mas_right).offset(KSpaceWidth);
            }];
            
        }
            break;
        case 1:{
            _mainSecondLabel.hidden = NO;
            _definitionLabel.hidden = NO;
            _businessNameLabel.text = @"数字业务";
            [_typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(4+370+90);
            }];
            [_spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(_typeLabel.mas_left);
                make.right.equalTo(_typeLabel.mas_right).offset(KSpaceWidth);
            }];
       _cellImageView.image = [UIImage imageNamed:@"icon_digital"];
        }
            break;
        case 2:{
            _mainSecondLabel.hidden = YES;
            _definitionLabel.hidden = YES;
            _businessNameLabel.text = @"宽带业务";
            _cellImageView.image = [UIImage imageNamed:@"icon_Broadband"];
            [_typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(370);
            }];
            [_spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(_typeLabel.mas_left);
                make.right.equalTo(_typeLabel.mas_right).offset(KSpaceWidth);
            }];
        }
            break;
        case 3:{
            _mainSecondLabel.hidden = YES;
            _definitionLabel.hidden = YES;
            _businessNameLabel.text = @"互动业务";
            _cellImageView.image = [UIImage imageNamed:@"icon_interactive"];
            [_typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(370);
            }];
            [_spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(_typeLabel.mas_left);
                make.right.equalTo(_typeLabel.mas_right).offset(KSpaceWidth);
            }];
        }
            break;
        case 4:{
            _mainSecondLabel.hidden = YES;
            _definitionLabel.hidden = NO;
            _businessNameLabel.text = @"智能业务";
            [_typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(370);
            }];
            [_spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(_typeLabel.mas_left);
                make.right.equalTo(_typeLabel.mas_right).offset(KSpaceWidth);
            }];
        }
            break;
        default:
            break;
    }
}
//选择Cell
- (void)selected:(BOOL)isSelected{
    _dragButton.selected = isSelected;
}
//创建标签
- (void)loadTypeLabel:(NSArray *)typeArray{
    for (int i = 0; i < typeArray.count; i ++) {
        UILabel *typeLabel = [[UILabel alloc] init];
        typeLabel.text = typeArray[i];
        typeLabel.textColor = LIGHTDARK;
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.font = FONTSIZESBOLD(24/2);
        typeLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        typeLabel.layer.borderWidth = 0.5;
        typeLabel.layer.masksToBounds = YES;
        typeLabel.layer.cornerRadius = 4;
        [_otherBackView addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_businessNumLabel.mas_centerY);
            make.left.mas_equalTo(_businessNumLabel.mas_right).with.offset(i*(110/2)+30/2);
            make.width.mas_equalTo(90/2);
            make.height.mas_equalTo(40/2);
        }];
    }
}
//创建详细套餐
- (void)loadDetailSetWithArray:(NSArray *)setArray{
    
    NSLog(@"数组的数据== %zd",setArray.count);
    
#if 1
    CGFloat CellHeight = 110/2*setArray.count;
    [_extendtableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CellHeight);
    }];
    [_extendtableView loadDataWithArray:setArray];
#else
    
    if (setArray.count > 0) {
        //清空旧数据
        [self deleteSubView:_labelView];
        //添加详情
        UIView *lastView;
        TTCUserLocateViewControllerUserProductOutputProsModel *prosModel;
        for (int i = 0; i < setArray.count; i ++) {
            prosModel = setArray[i];
            for (int j = 0; j < 5; j ++) {
                if (j == 0) {
                    //上划线
                    UIView *lineView = [[UIView alloc] init];
                    lineView.backgroundColor = LIGHTGRAY;
                    [_labelView addSubview:lineView];
                    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(i*(110/2));
                        make.left.mas_equalTo(_businessNumLabel.mas_left);
                        make.right.mas_equalTo(0);
                        make.height.mas_equalTo(1);
                    }];
                    //名称
                    UILabel *allLabel = [[UILabel alloc] init];
                    allLabel.text = prosModel.pname;
                    allLabel.textColor = [UIColor lightGrayColor];
                    allLabel.font = FONTSIZESBOLD(24/2);
                    [_labelView addSubview:allLabel];
                    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(lineView.mas_bottom).with.offset(47/2);
                        make.left.mas_equalTo(lineView.mas_left);
                    }];
                    lastView = allLabel;
                }else if(j == 1){
                    //0-顺延 1-不顺延
                    UILabel *allLabel = [[UILabel alloc] init];
                    switch ([prosModel.ispostpone intValue]) {
                        case 0:{
                            allLabel.text = @"不顺延";
                            allLabel.backgroundColor = DARKBLUE;
                            allLabel.textColor = [UIColor colorWithRed:255/255.0 green:180/255.0 blue:0/255.0 alpha:1.0];
                        }
                            break;
                        case 1:{
                            allLabel.text = @"顺延";
                            allLabel.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
                            allLabel.backgroundColor = DARKBLUE;
                        }
                            break;
                        default:{
                            allLabel.text = @"";
                            allLabel.backgroundColor = WHITE;
                        }
                            break;
                    }
//                    allLabel.textColor = WHITE;
                    allLabel.textAlignment = NSTextAlignmentCenter;
                    allLabel.font = FONTSIZESBOLD(24/2);
                    allLabel.backgroundColor = WHITE;
                    allLabel.layer.masksToBounds = YES;
                    allLabel.layer.cornerRadius = 3;
                    [_labelView addSubview:allLabel];
                    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(lastView.mas_centerY);
                        make.left.mas_equalTo(270);
                        make.width.mas_equalTo(90/2);
                        make.height.mas_equalTo(40/2);
                    }];
                    lastView = allLabel;
                    //00 在用   01停用
                    UILabel *useLabel = [[UILabel alloc] init];
                    if (prosModel.stoptype.length > 0) {
                        //停用
                        useLabel.text = prosModel.stoptype;
                    }else{
                        //在用
                        if ([prosModel.prodstatus isEqualToString:@"00"]) {
                            useLabel.text = @"在用";
                            useLabel.textColor = [UIColor colorWithRed:85/255.0 green:174/255.0 blue:73/255.0 alpha:1.0];
                            useLabel.backgroundColor = LIGHTGRAY;
                        }else if([prosModel.prodstatus isEqualToString:@"01"]){
                            useLabel.text = @"预约";
                            useLabel.textColor = [UIColor colorWithRed:85/255.0 green:174/255.0 blue:73/255.0 alpha:1.0];
                            useLabel.backgroundColor = LIGHTGRAY;
                        }else if([prosModel.prodstatus isEqualToString:@"10"]){
                            useLabel.text = @"停用";
                            useLabel.textColor = RED;
                            useLabel.backgroundColor = LIGHTGRAY;
                        }else if([prosModel.prodstatus isEqualToString:@"20"]){
                            useLabel.text = @"退订";
                            useLabel.textColor = RED;
                            useLabel.backgroundColor = LIGHTGRAY;
                        }else{
                            useLabel.text = @"";
                            useLabel.backgroundColor = WHITE;
                        }
                    }
//                    useLabel.textColor = RED;//WHITE
                    useLabel.textAlignment = NSTextAlignmentCenter;
                    useLabel.font = FONTSIZESBOLD(24/2);
                    useLabel.backgroundColor = WHITE;
                    useLabel.layer.masksToBounds = YES;
                    useLabel.layer.cornerRadius = 3;
                    [_labelView addSubview:useLabel];
                    [useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(lastView.mas_centerY);
                        make.left.mas_equalTo(lastView.mas_right).with.offset(2);
                        make.width.mas_equalTo(90/2);
                        make.height.mas_equalTo(40/2);
                    }];
                    lastView = useLabel;
                }else if(j == 2 || j == 3){
                    //开通时间 结束时间
                    UILabel *allLabel = [[UILabel alloc] init];
                    if (j == 2) {
                        NSRange range = [prosModel.stime rangeOfString:@"T"];
                        NSString *stime = [prosModel.stime substringToIndex:range.location];
                        allLabel.text = [NSString stringWithFormat:@"开通时间 %@",stime];
                    }else{
                        NSRange range = [prosModel.etime rangeOfString:@"T"];
                        NSString *etime = [prosModel.etime substringToIndex:range.location];
                        allLabel.text = [NSString stringWithFormat:@"结束时间 %@",etime];
                    }
                    allLabel.textColor = [UIColor lightGrayColor];
                    allLabel.font = FONTSIZESBOLD(24/2);
                    [_labelView addSubview:allLabel];
                    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(lastView.mas_centerY);
                        make.left.mas_equalTo((j-1)*(300/2)+220);
                    }];
                    lastView = allLabel;
                }else if(j == 4){
                    //续订按钮
                    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    buyButton.tag = i+kButtonTag;
                    [buyButton setTitle:@"续订" forState:UIControlStateNormal];
                    [buyButton setTitleColor:WHITE forState:UIControlStateNormal];
                    [buyButton addTarget:self action:@selector(buyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [buyButton setBackgroundColor:DARKBLUE];
                    buyButton.titleLabel.font = FONTSIZESBOLD(30/2);
                    buyButton.layer.masksToBounds = YES;
                    buyButton.layer.cornerRadius = 3;
                    [_labelView addSubview:buyButton];
                    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(lastView.mas_centerY);
                        make.right.mas_equalTo(-60/2);
                        make.width.mas_equalTo(110/2);
                        make.height.mas_equalTo(60/2);
                    }];
                    lastView = buyButton;
                }
            }
        }
        _labelView.backgroundColor = WHITE;
        [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(lastView.mas_bottom).with.offset(10);
        }];
    }
     
#endif
}
//清空子控件
- (void)deleteSubView:(UIView *)view{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}
//选择CellType
- (void)selecteCellType:(CellType)type{
    switch (type) {
        case 0:
            [self useFirstType];
            break;
        case 1:
            [self useSecondType];
            break;
        case 2:
            [self useOtherType];
            break;
        default:
            break;
    }
}
//使用第一种模式
- (void)useFirstType{
    _firstView.hidden = NO;
    _secondView.hidden = YES;
    _otherBackView.hidden = YES;
}
//使用第二种模式
- (void)useSecondType{
    _firstView.hidden = YES;
    _secondView.hidden = NO;
    _otherBackView.hidden = YES;
}
//使用其他模式
- (void)useOtherType{
    _firstView.hidden = YES;
    _secondView.hidden = YES;
    _otherBackView.hidden = NO;
}
//加载价格(第二种模式)
- (void)loadPriceWithArray:(NSArray *)dataArray{
    [_secondView loadPriceWithArray:dataArray];
}
//加载用户高清标清
- (void)loadDefinitionLabelWithString:(NSString *)string{
    switch ([string intValue]) {
        case 0:{
            _definitionLabel.text = @"标清";
//            _definitionLabel.backgroundColor = DARKBLUE;
            _definitionLabel.backgroundColor = [UIColor orangeColor];
        }
            break;
        case 1:{
            _definitionLabel.text = @"高清";
//            _definitionLabel.backgroundColor = DARKBLUE;
            //add
            _definitionLabel.backgroundColor = GREENLIGHT;
        }
            break;
        default:{
            _definitionLabel.text = @"";
            _definitionLabel.backgroundColor = WHITE;
        }
            break;
    }
}
//加载主副机
- (void)loadMainSecondWithString:(NSString *)string{
    switch ([string intValue]) {
        case 0:{
            _mainSecondLabel.text = @"主机";
            _mainSecondLabel.backgroundColor = DARKBLUE;
        }
            break;
        case 1:{
            _mainSecondLabel.text = @"副机";
            _mainSecondLabel.backgroundColor = DARKBLUE;
        }
            break;
        default:{
            _mainSecondLabel.text = @"";
            _mainSecondLabel.backgroundColor = WHITE;
        }
            break;
    }
}
//加载客户类型
- (void)loadTypeWithString:(NSString *)typeString{
    _typeLabel.text = [NSString stringWithFormat:@"  %@",typeString];
}
@end
