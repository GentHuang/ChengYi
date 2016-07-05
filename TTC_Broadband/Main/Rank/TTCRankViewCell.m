//
//  TTCRankViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCRankViewCell.h"
//Macro
#define kLabelTag 15000
@interface TTCRankViewCell()
@property (strong, nonatomic) UIImageView *rankImageView;
@property (strong, nonatomic) UIView *rankBackView;
@property (strong, nonatomic) UILabel *rankLabel;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) CGFloat progress;
//add 名词
//@property (strong, nonatomic) UILabel *rankNumberLable;
@end

@implementation TTCRankViewCell
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
    //图片
    _rankImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rank_img_1"]];
    [self.contentView addSubview:_rankImageView];
    //排名背景
    _rankBackView = [[UIView alloc] init];
    _rankBackView.backgroundColor = DARKBLUE;
    _rankBackView.layer.masksToBounds = YES;
    _rankBackView.layer.cornerRadius = 11;
    [self.contentView addSubview:_rankBackView];
    //排名
    _rankLabel = [[UILabel alloc] init];
    _rankLabel.text = @"第1名";
    _rankLabel.textColor = WHITE;
    _rankLabel.font = FONTSIZESBOLD(30/2);
    [_rankBackView addSubview:_rankLabel];
    //头像
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_avatar"]];
    [self.contentView addSubview:_avatarImageView];
    //add
    //排名数字
    _rankNumberLable = [[UILabel alloc]init];
    _rankNumberLable.text = @"第1名";
    _rankNumberLable.textColor = [UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0];
    _rankNumberLable.textAlignment = NSTextAlignmentCenter;
    _rankNumberLable.font = FONTSIZESBOLD(30/2);
    [self.contentView addSubview:_rankNumberLable];
    //创建信息列表
    for (int i = 0, labelCount = 0; i < 2; i ++) {
        for (int j = 0; j < 2; j ++) {
            if (i == 0 && j == 1) {
                _progressView = [[UIProgressView alloc] init];
                _progressView.progress = 0;
                _progressView.trackTintColor = WHITE;
                [self.contentView addSubview:_progressView];
                [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
                    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(90/2+(i%2)*(40/2));
                         make.left.mas_equalTo(327/2+(j%2)*(300/2));
                        make.height.mas_equalTo(20/2);
                        make.width.mas_equalTo(600/2);
                    }];
                }];
            }else{
                //名字
                UILabel *allLabel = [[UILabel alloc] init];
                allLabel.tag = labelCount + kLabelTag;
                allLabel.text = @"张三";
                allLabel.textColor = [UIColor lightGrayColor];
                allLabel.font = FONTSIZESBOLD(24/2);
                //add
                allLabel.hidden = YES;
                if (i == 0 && j == 0) {
                    allLabel.textColor = LIGHTDARK;
                    allLabel.font = FONTSIZESBOLD(30/2);
                    //add
                    allLabel.hidden = NO;
                }
                [self.contentView addSubview:allLabel];
                [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(90/2+(i%2)*(40/2));
                    make.left.mas_equalTo(327/2+(j%2)*(300/2));
                }];
                labelCount++;
            }
        }
    }
}
- (void)setSubViewLayout{
    //图片
    [_rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(60/2);
    }];
    //排名背景
    [_rankBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(60/2);
        make.size.mas_equalTo(_rankImageView);
    }];
    //排名
    [_rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_rankBackView);
    }];
    //头像
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_rankImageView.mas_right).with.offset(50/2);
        make.width.height.mas_equalTo(136/2);
    }];
    //add
    //排名序号
    [_rankNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-60/2);
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
            [self useImageViewType];
            break;
        case 1:
            [self useNumType];
            break;
        default:
            break;
    }
}
//图片模式
- (void)useImageViewType{
    _rankImageView.hidden = NO;
    _rankBackView.hidden = YES;
}
//文字模式
- (void)useNumType{
    _rankImageView.hidden = YES;
    _rankBackView.hidden = NO;
}
//加载图片
- (void)loadImageView:(UIImage *)image{
    _rankImageView.image = image;
}
//加载排名
- (void)loadRankLabel:(int)rank{
    _rankLabel.text = [NSString stringWithFormat:@"%d",rank];
}
//加载进度条
- (void)loadProgressViewColor:(UIColor *)color Progress:(CGFloat)progress{
    _progress = progress;
    _progressView.progressTintColor = color;
    if(_progressView.progress < progress){
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(addProgress) userInfo:nil repeats:YES];
    }
}
//加载过程
- (void)addProgress{
    if (_progressView.progress >= _progress) {
        [_timer invalidate];
    }
    _progressView.progress += 0.01;
}
//加载信息
- (void)loadInformation:(NSArray *)dataArray{
    for (int i = 0; i < dataArray.count; i ++) {
        UILabel *allLabel = (UILabel *)[self viewWithTag:(i+kLabelTag)];
        allLabel.text = dataArray[i];
        NSLog(@"%@",dataArray);
    }
}
//add
//显示排行榜前面的四名
- (void)showRankNumerText:(NSInteger)row {
    _rankNumberLable.text = [NSString stringWithFormat:@"第%zd名",(row+1)];
}
@end
