//
//  TTCFirstPageBannerView.m
//  TTC_Broadband
//
//  Created by apple on 16/1/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCFirstPageBannerView.h"
#import "TTCFirstPageBannerViewCell.h"


@interface TTCFirstPageBannerView()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (assign, nonatomic) int currCount;
@property (assign, nonatomic) CGFloat lastX;
@property (assign, nonatomic) CGFloat pageX;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIPageControl *pageVC;
@end

@implementation TTCFirstPageBannerView
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
    _currCount = 3;
    //布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //修改item大小
    layout.itemSize = CGSizeMake(SCREEN_MAX_WIDTH, 358/2);
    //左右两个item的最小间距
    layout.minimumInteritemSpacing = 0;
    //上下两个item的最小间距
    layout.minimumLineSpacing = 0;
    //滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //CollectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.layer.borderWidth = 1;
    _collectionView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[TTCFirstPageBannerViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
    //pageVC
    _pageVC = [[UIPageControl alloc] init];
    _pageVC.backgroundColor = CLEAR;
    _pageVC.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageVC.currentPageIndicatorTintColor = BLUE;
    _pageVC.numberOfPages = 2;
    [self addSubview:_pageVC];
}
- (void)setSubViewLayout{
    //collectionView
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
    //pageVC
    [_pageVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-43/2);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(16/2);
    }];
}
#pragma mark - Event response
#pragma mark - Data request
#pragma mark - Protocol methods
//UICollectionViewDataSource Method
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_imageArray.count > 0) {
        return _currCount;
    }else{
        return 0;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TTCFirstPageBannerViewCell *cell = (TTCFirstPageBannerViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell loadImageViewWithImage:_imageArray[indexPath.item]];
    
    
    return cell;
}
//UICollectionViewDelegate Method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.stringBlock([NSString stringWithFormat:@"%lu",indexPath.item]);
}
//UIScrollViewDelegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //banner无限循环快速滑动
    CGFloat currX = scrollView.contentOffset.x;
    _pageX = currX-SCREEN_MAX_WIDTH;
    if ((currX - _lastX) >= 0) {
        //Banner右边区域的滑动
        if(currX > (_currCount-2)*SCREEN_MAX_WIDTH){
            _lastX = 0;
            [scrollView setContentOffset:CGPointMake(currX-(_currCount-2)*SCREEN_MAX_WIDTH, 0)];
        }
        //pageVC滑动
        if (currX < SCREEN_MAX_WIDTH) {
            _pageX = (_currCount-2)*SCREEN_MAX_WIDTH;
        }
    }else{
        //Banner左边区域的滑动
        if(currX > (_currCount-2)*SCREEN_MAX_WIDTH){
            _lastX = 0;
            [scrollView setContentOffset:CGPointMake(currX-(_currCount-2)*SCREEN_MAX_WIDTH, 0)];
        }else if (currX < SCREEN_MAX_WIDTH) {
            _lastX = _currCount*SCREEN_MAX_WIDTH;
            [scrollView setContentOffset:CGPointMake(currX+(_currCount-2)*SCREEN_MAX_WIDTH, 0)];
        }
        //pageVC滑动
        if (currX < SCREEN_MAX_WIDTH) {
            _pageX = (_currCount-2)*SCREEN_MAX_WIDTH;
        }else if (currX > (_currCount-2)*SCREEN_MAX_WIDTH){
            _pageX = 0;
        }
    }
    int currPage = (int)(_pageX/SCREEN_MAX_WIDTH);
    _pageVC.currentPage = currPage;
}
#pragma mark - Other methods
//添加Banner
- (void)loadBannerWithImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    _currCount = (int)_imageArray.count;
    _pageVC.numberOfPages = (_currCount-2);
    [_collectionView reloadData];
    [_collectionView setContentOffset:CGPointMake(SCREEN_MAX_WIDTH, 0)];
}
@end
