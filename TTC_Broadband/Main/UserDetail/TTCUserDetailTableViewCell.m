//
//  TTCUserDetailTableViewCell.m
//  TTC_Broadband
//
//  Created by apple on 16/5/25.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCUserDetailTableViewCell.h"
#import "TTCUserLocateViewControllerUserProductOutputProsModel.h"
@interface TTCUserDetailTableViewCell()
//线条
@property (strong, nonatomic) UIView *lineView;
//名称
@property (strong, nonatomic) UILabel *nameLabel;
//延顺
@property (strong, nonatomic) UILabel *DelayLabel;
//在用
@property (strong, nonatomic) UILabel *inUseLabel;
//开通时间
@property (strong, nonatomic) UILabel *OpenTimeLabel;
//结束时间
@property (strong, nonatomic) UILabel *EndTimeLabel;
//续订按钮
@property (strong, nonatomic) UIButton *renewButton;
//model
@property (strong, nonatomic) TTCUserLocateViewControllerUserProductOutputProsModel *prosModel;


@end

@implementation TTCUserDetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self CreateUI];
        [self setLayout];
    }
    return self;
}
- (void)CreateUI {
    //上划线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = LIGHTGRAY;
    [self.contentView addSubview:_lineView];
    //名称
    _nameLabel= [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_nameLabel];
    _nameLabel.font = FONTSIZESBOLD(24/2);
    //0-顺延 1-不顺延
    _DelayLabel = [[UILabel alloc] init];
    _DelayLabel.textAlignment = NSTextAlignmentCenter;
    _DelayLabel.font = FONTSIZESBOLD(24/2);
    _DelayLabel.backgroundColor = WHITE;
    _DelayLabel.layer.masksToBounds = YES;
    _DelayLabel.layer.cornerRadius = 3;
    [self.contentView addSubview:_DelayLabel];
    //00 在用   01停用
    _inUseLabel = [[UILabel alloc] init];
    _inUseLabel.textAlignment = NSTextAlignmentCenter;
    _inUseLabel.font = FONTSIZESBOLD(24/2);
    _inUseLabel.backgroundColor = WHITE;
    _inUseLabel.layer.masksToBounds = YES;
    _inUseLabel.layer.cornerRadius = 3;
    [self.contentView addSubview:_inUseLabel];

    //开始时间
    _OpenTimeLabel = [[UILabel alloc] init];
    _OpenTimeLabel.textColor = [UIColor lightGrayColor];
    _OpenTimeLabel.font = FONTSIZESBOLD(24/2);
    [self.contentView addSubview:_OpenTimeLabel];
    //结束时间
    _EndTimeLabel = [[UILabel alloc]init];
    _EndTimeLabel.textColor = [UIColor lightGrayColor];
    _EndTimeLabel.font = FONTSIZESBOLD(24/2);
    [self.contentView addSubview:_EndTimeLabel];
    //续订按钮
    _renewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_renewButton setTitle:@"续订" forState:UIControlStateNormal];
    [_renewButton setTitleColor:WHITE forState:UIControlStateNormal];
    [_renewButton addTarget:self action:@selector(buyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_renewButton setBackgroundColor:DARKBLUE];
    _renewButton.titleLabel.font = FONTSIZESBOLD(30/2);
    _renewButton.layer.masksToBounds = YES;
    _renewButton.layer.cornerRadius = 3;
    [self.contentView addSubview:_renewButton];
}
- (void)setLayout{
    //线条
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(298/2);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    //名称
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom).with.offset(47/2);
        make.left.mas_equalTo(_lineView.mas_left);

    }];
    //顺延
    [_DelayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(270);
        make.width.mas_equalTo(90/2);
        make.height.mas_equalTo(40/2);
    }];
    //停用在用
    [_inUseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_DelayLabel.mas_right).with.offset(2);
        make.width.mas_equalTo(90/2);
        make.height.mas_equalTo(40/2);
    }];
   //开始时间
    [_OpenTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(300/2+220);
    }];
   //结束时间
    [_EndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(300+220);
    }];
   //续订按钮
    [_renewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-60/2);
        make.width.mas_equalTo(110/2);
        make.height.mas_equalTo(60/2);
    }];
}
- (void)buyButtonPressed:(UIButton*)button {
    
//    if (self.delegate &&[self.delegate respondsToSelector:@selector(UserRenewBusinessButtonClick:)]) {
//        
//        [self.delegate UserRenewBusinessButtonClick:button];
//    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"续订" object:_prosModel userInfo:@{@"DetailModel":_prosModel}];
    
    
}

//详细套餐数据刷新
- (void)loadDetailSetWithModeString:(id)model{
    
    _prosModel = (TTCUserLocateViewControllerUserProductOutputProsModel*)model;
    //名称
    _nameLabel.text = _prosModel.pname;
    switch ([_prosModel.ispostpone intValue]) {
        case 0:{
            _DelayLabel.text = @"不顺延";
//            _DelayLabel.backgroundColor = DARKBLUE;
            _DelayLabel.textColor = [UIColor colorWithRed:255/255.0 green:180/255.0 blue:0/255.0 alpha:1.0];
        }
            break;
        case 1:{
            _DelayLabel.text = @"顺延";
            _DelayLabel.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
//            _DelayLabel.backgroundColor = DARKBLUE;
        }
            break;
        default:{
            _DelayLabel.text = @"";
            _DelayLabel.backgroundColor = WHITE;
        }
            break;
    }
    
    if (_prosModel.stoptype.length > 0) {
        //停用
        _inUseLabel.text = _prosModel.stoptype;
    }else{
        //在用
        if ([_prosModel.prodstatus isEqualToString:@"00"]) {
            _inUseLabel.text = @"在用";
            _inUseLabel.textColor = [UIColor colorWithRed:85/255.0 green:174/255.0 blue:73/255.0 alpha:1.0];
            _inUseLabel.backgroundColor = LIGHTGRAY;
        }else if([_prosModel.prodstatus isEqualToString:@"01"]){
            _inUseLabel.text = @"预约";
            _inUseLabel.textColor = [UIColor colorWithRed:85/255.0 green:174/255.0 blue:73/255.0 alpha:1.0];
            _inUseLabel.backgroundColor = LIGHTGRAY;
        }else if([_prosModel.prodstatus isEqualToString:@"10"]){
            _inUseLabel.text = @"停用";
            _inUseLabel.textColor = RED;
            _inUseLabel.backgroundColor = LIGHTGRAY;
        }else if([_prosModel.prodstatus isEqualToString:@"20"]){
            _inUseLabel.text = @"退订";
            _inUseLabel.textColor = RED;
            _inUseLabel.backgroundColor = LIGHTGRAY;
        }else{
            _inUseLabel.text = @"";
            _inUseLabel.backgroundColor = WHITE;
        }
    }
    
    //开通时间
    NSRange rangestime = [_prosModel.stime rangeOfString:@"T"];
    NSString *stime = [_prosModel.stime substringToIndex:rangestime.location];
    _OpenTimeLabel.text = [NSString stringWithFormat:@"开通时间 %@",stime];
    //结束时间
    NSRange rangeetime = [_prosModel.etime rangeOfString:@"T"];
    NSString *etime = [_prosModel.etime substringToIndex:rangeetime.location];
    _EndTimeLabel.text = [NSString stringWithFormat:@"结束时间 %@",etime];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
