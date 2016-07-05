//
//  TTCProductLibDragView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/28.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCProductLibDragView.h"
#import "TTCProductLibDragViewCell.h"
@interface TTCProductLibDragView()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (assign, nonatomic) BOOL isShow;
@property (assign, nonatomic) int selectedIndex;
@property (assign, nonatomic) CGFloat imageHeight;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) UIImageView *dragImageView;
@property (strong, nonatomic) UIView *progressPointView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation TTCProductLibDragView
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
    [_tableView registerClass:[TTCProductLibDragViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:_tableView];
    //dragImageView
    _dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_drag"]];
    _dragImageView.hidden = YES;
    //    _imageHeight = [UIImage imageNamed:@"pro_img_drag"].size.height;
    _imageHeight = 150;
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
    if (_dataArray.count > 0) {
        return _dataArray.count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCProductLibDragViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_dataArray.count > 0) {
        [cell loadAddressWithString:_dataArray[indexPath.row]];
        if (_selectedIndex == indexPath.row) {
            [cell isSelected:YES];
        }else{
            [cell isSelected:NO];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
//UITableViewDelegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCProductLibDragViewCell *selectedCell = (TTCProductLibDragViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.addressString = selectedCell.addressString;
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
//加载用户数据
- (void)loadUserListWithArray:(NSArray *)dataArray permarkArray:(NSArray *)permarkArray{
    _dataArray = dataArray;
    
    NSMutableArray *permarNumArray = [NSMutableArray array];
    for (int i = 0; i < permarkArray.count; i ++) {
        NSString *permark = @"";
        switch ([permarkArray[i] intValue]) {
                //                0-模拟业务1-数字业务2-宽带业务3-互动业务4-智能
            case 0:
                permark = [NSString stringWithFormat:@"模拟 %@",dataArray[i]];
                break;
            case 1:
                permark = [NSString stringWithFormat:@"数字 %@",dataArray[i]];
                break;
            case 2:
                permark = [NSString stringWithFormat:@"宽带 %@",dataArray[i]];
                break;
            case 3:
                permark = [NSString stringWithFormat:@"互动 %@",dataArray[i]];
                break;
            case 4:
                permark = [NSString stringWithFormat:@"智能 %@",dataArray[i]];
                break;
            default:
                break;
        }
        [permarNumArray addObject:permark];
    }
    _dataArray = (NSArray *)permarNumArray;
    [_tableView reloadData];
}
@end
