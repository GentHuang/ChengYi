//
//  TTCModifiedDataDragView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCModifiedDataDragView.h"
#import "TTCModifiedDataDragViewCell.h"
@interface TTCModifiedDataDragView()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (assign, nonatomic) BOOL isShow;
@property (assign, nonatomic) int selectedIndex;
@property (assign, nonatomic) CGFloat imageHeight;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) UIImageView *dragImageView;
@property (strong, nonatomic) UIView *progressPointView;
//临时
@property (strong, nonatomic) NSArray *dataArray;
@end
@implementation TTCModifiedDataDragView
#pragma mark - Init methods
- (void)initData{
    _dataArray = @[@"天河番禺区",@"天河客运站",@"广州市死哈的哦啊胡搜帝豪谁都爱好是滴哦",@"啊实打实大卡号十大科技和SD卡接啊圣诞节卡上",@"啊还SD卡金黄色空间的好看就阿訇是肯定哈客户端上开始",@"卡说假话的空间啊还是坎大哈开户送科技等哈看聚划算科技等哈看书"];
}
- (instancetype)init{
    if (self = [super init]) {
        [self initData];
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    _selectedIndex = 0;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    self.backgroundColor = [UIColor lightGrayColor];
    self.hidden = YES;
    self.isShow = NO;
    //tableView
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[TTCModifiedDataDragViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:_tableView];
    //dragImageView
    _dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_drag"]];
    _imageHeight = [UIImage imageNamed:@"pro_img_drag"].size.height;
    [self addSubview:_dragImageView];
    //下拉进度点
    _progressPointView = [[UIView alloc] init];
    _progressPointView.backgroundColor = [UIColor lightGrayColor];
    _progressPointView.layer.masksToBounds = YES;
    _progressPointView.layer.cornerRadius = 2;
    [_dragImageView addSubview:_progressPointView];
}
- (void)setSubViewLayout{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    //dragImageView
    [_dragImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
    }];
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //下拉进度点
    [_progressPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.centerX.mas_equalTo(_dragImageView.mas_centerX);
        make.width.height.mas_equalTo(4);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCModifiedDataDragViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadAddressWithString:_dataArray[indexPath.row]];
    if (_selectedIndex == indexPath.row) {
        [cell isSelected:YES];
    }else{
        [cell isSelected:NO];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}
//UITableViewDelegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCModifiedDataDragViewCell *selectedCell = (TTCModifiedDataDragViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.addressString = selectedCell.addressString;
    self.stringBlock(_addressString);
    [selectedCell isSelected:YES];
    _selectedIndex = (int)indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self packUpList];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [_tableView reloadData];
}
//UIScrollViewDelegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //滚动进度点
    CGFloat currY = scrollView.contentOffset.y;
    if (currY <= 8) {
        currY = 8;
    }else if(currY >= 65){
        currY = 65;
    }
    [_progressPointView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(currY);
    }];
    [self layoutIfNeeded];
}
#pragma mark - Other methods
//弹出View
- (void)dragDownList{
    if (_isShow == NO) {
        //将下拉列表放置到最前
        [self.superview bringSubviewToFront:self];
        self.hidden = NO;
        _isShow = YES;
        //下拉动画
        [UIView beginAnimations:@"DragDown" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_imageHeight);
        }];
        [self layoutIfNeeded];
        [UIView commitAnimations];
    }
}
//收起View
- (void)packUpList{
    if (_isShow == YES) {
        //收起动画
        [UIView beginAnimations:@"PackUp" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self layoutIfNeeded];
        [UIView commitAnimations];
        //隐藏
        //    self.hidden = YES;
        _isShow = NO;
    }
}
@end
