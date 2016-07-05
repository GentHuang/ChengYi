//
//  TTCNewUserViewControllerAddressDragView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/28.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCNewUserViewControllerAddressDragView.h"
#import "TTCNewUserViewControllerAddressDragViewCell.h"
@interface TTCNewUserViewControllerAddressDragView()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (assign, nonatomic) BOOL isShow;
@property (assign, nonatomic) int selectedIndex;
@property (assign, nonatomic) CGFloat imageHeight;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) NSArray *dataArray;
@end
@implementation TTCNewUserViewControllerAddressDragView
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
    [_tableView registerClass:[TTCNewUserViewControllerAddressDragViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:_tableView];
    __block TTCNewUserViewControllerAddressDragView *selfView = self;
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfView getHeaderData];
    }];
    //上拉刷新
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [selfView getFooterData];
    }];
}
- (void)setSubViewLayout{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
//下拉刷新
- (void)getHeaderData{
   //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"开户地址下拉" object:nil];
}
//上拉刷新
- (void)getFooterData{
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"开户地址上拉" object:nil];
}
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
    TTCNewUserViewControllerAddressDragViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
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
    NSString *addString = _dataArray[indexPath.row];
    CGRect rect = [addString boundingRectWithSize:CGSizeMake(630/2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONTSIZESBOLD(30/2)} context:nil];
    return rect.size.height+10;
}
//UITableViewDelegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCNewUserViewControllerAddressDragViewCell *selectedCell = (TTCNewUserViewControllerAddressDragViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.addressString = selectedCell.addressString;
    self.stringBlock(_addressString);
    [selectedCell isSelected:YES];
    _selectedIndex = (int)indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self packUpList];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [_tableView reloadData];
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
            make.height.mas_equalTo(150);
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
        _isShow = NO;
    }
}
//加载数组信息
- (void)loadWithDataArray:(NSArray *)dataArray{
    NSMutableArray *allDataArray = [NSMutableArray array];
    for (NSDictionary *dic in dataArray) {
        NSString *allAddr = [NSString stringWithFormat:@"%@%@",[dic.allValues firstObject],[dic.allKeys firstObject]];
        [allDataArray addObject:allAddr];
    }
    if (_dataArray.count == allDataArray.count && _dataArray.count > 6) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [_tableView.mj_footer resetNoMoreData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    _dataArray = allDataArray;
    [_tableView reloadData];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    _addressString = (NSString *)[_dataArray firstObject];
    self.stringBlock(_addressString);
}
@end
