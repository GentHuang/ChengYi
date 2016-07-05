//
//  TTCProudcntLibExpandMenuView.m
//  TTC_Broadband
//
//  Created by apple on 16/2/28.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCProudcntLibExpandMenuView.h"
#import "TTCProductLIbCollectionCell.h"

//mac
#define KLabel_W 150
#define kButtonWidth 140
#define kButtonHeight 25
#define kButtonTag 1800
@interface TTCProudcntLibExpandMenuView()//<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (assign, nonatomic) int selectedIndex;
@property (strong, nonatomic) UIView *contentView;
@property (strong ,nonatomic) UIImageView *dragImageMenu;
@property (strong, nonatomic)  UIView *backView;
//@property (strong, nonatomic)  UIScrollView *backView;

//标题
@property (strong, nonatomic) UILabel *titlleLabel;
//线条
@property (strong, nonatomic) UILabel *UplinLbale;
@property (strong, nonatomic) UILabel *downlinLbale;
@property (assign, nonatomic) int buttonCount;
@property (assign, nonatomic) BOOL isShowMenu;
//@property (strong, nonatomic) NSArray *dataArray;
//@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation TTCProudcntLibExpandMenuView
-(instancetype)init {
    if (self = [super init]) {
        [self creatUI];
        [self setSubViewLayout];
    }
    return self;
}
- (void)creatUI {
    self.hidden = YES;
    
    self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.7];
    _backView = [[UIView alloc]init];
//    _backView = [[UIScrollView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    //titleLabel
    _titlleLabel = [[UILabel alloc]init];
    [_backView addSubview:_titlleLabel];
    _titlleLabel.textAlignment = NSTextAlignmentLeft;
    _titlleLabel.font = FONTSIZES(14);
    _titlleLabel.textColor =[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
    
    //线条
    _downlinLbale = [[UILabel alloc]init];
    _downlinLbale.backgroundColor = [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:0.9];
    [_backView addSubview:_downlinLbale];
    _UplinLbale = [[UILabel alloc]init];
    _UplinLbale.backgroundColor = [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:0.9];
    [_backView addSubview:_UplinLbale];
    //下拉箭头
    _dragImageMenu = [[UIImageView alloc]init];
    _dragImageMenu.contentMode = UIViewContentModeScaleToFill;
    _dragImageMenu.image = [UIImage imageNamed:@"SlideUp"];
    _dragImageMenu.userInteractionEnabled = YES;
    
    [_backView addSubview:_dragImageMenu];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture)];
    [_dragImageMenu addGestureRecognizer:tap];
    
    /*
    // 点击展开的collection
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.minimumLineSpacing = 20;
    //距离父视图边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //垂直滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(KLabel_W, 40);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.backgroundColor = WHITE;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    [_collectionView registerClass:[TTCProductLIbCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_backView addSubview:_collectionView];
     */
}
- (void)setSubViewLayout {
    //背景图片
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.right.mas_equalTo(self);
//        make.right.mas_equalTo(_dragImageMenu.mas_left).offset(-10);
        make.height.mas_equalTo(0);
    }];
    //线条
    [_UplinLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView).offset(0);
        make.width.mas_equalTo(_backView);
//        make.height.mas_equalTo(0.5);
    }];
    [_titlleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_top).offset(0.5);
        make.left.mas_equalTo(_backView.mas_left).offset(31);
//        make.height.mas_equalTo(88/2);
    }];
    
    //线条
    [_downlinLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titlleLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(_backView);
//        make.height.mas_equalTo(0.5);
    }];
    //收回菜单
    [_dragImageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backView).offset(-12);
        make.top.mas_equalTo(_backView).offset(0);
        make.width.mas_equalTo (119/2);
//        make.height.mas_equalTo(90/2);
    }];
    
    //
//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_TitleLabel.mas_bottom).offset(10);
//        make.left.mas_equalTo(_backView);
//        make.right.mas_equalTo(_dragImageMenu.mas_left).offset(-10);
//        make.bottom.mas_equalTo(_backView.mas_bottom);
    
//        make.edges.mas_equalTo(_backView);
//        make.size.mas_equalTo(_backView);
//    }];
    
}

/*
//刷新数据
- (void)getDataWithArray:(NSArray*)array  {
    
    _dataArray = array;
    [_Titlebutton setTitle:[NSString stringWithFormat:@"共有%zd个分类",array.count] forState:UIControlStateNormal];
    [_collectionView reloadData];
}
#pragma mark - delegate Method
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTCProductLIbCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell reloadItemDataWithString:_dataArray[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex  = (int)indexPath.row;
    self.hidden = YES;
}
*/
#pragma mark 换成button
//刷新
- (void)getDataWithArray:(NSArray *)array{
    //标题个数
    _titlleLabel.text = [NSString stringWithFormat:@"共有%zd个分类",array.count];
    //先清空数据
    [self deleteAllButton];
    _buttonCount = (int)array.count;
    UIView *lastView;
    for (int i = 0,j = 0; i < array.count; i ++,j++) {
        if (j==4) {
            j = 0;
        }
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [allButton setTitle:array[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        allButton.layer.borderColor = [[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] CGColor];
        allButton.layer.borderWidth = 0.6;
        allButton.layer.masksToBounds = YES;
        allButton.layer.cornerRadius = 5;
        allButton.titleLabel.font = FONTSIZES(12);
        [_backView addSubview:allButton];
        if (i < 4) {
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_titlleLabel.mas_bottom).with.offset(50/2);
                make.left.mas_equalTo(_titlleLabel.mas_left).with.offset(j*(kButtonWidth+49));
                make.width.mas_equalTo(kButtonWidth);
//                make.height.mas_equalTo(kButtonHeight);
            }];
            lastView = allButton;
        }else{
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).with.offset(40/2);
                make.left.mas_equalTo(_titlleLabel.mas_left).with.offset(j*(kButtonWidth+49));
                make.width.mas_equalTo(kButtonWidth);
//                make.height.mas_equalTo(kButtonHeight);
            }];
        }
        if (j == 3 || i == (array.count-1)) {
            lastView = allButton;
        }
    }
    //执行一次隐藏 优化动画效果
    [self paclUpMenu];
}
//删除所有按钮
- (void)deleteAllButton{
    if (_buttonCount > 0) {
        for (int i = 0; i < _buttonCount; i ++) {
            UIButton *allButton = (UIButton *)[self viewWithTag:(i+kButtonTag)];
            [allButton removeFromSuperview];
        }
    }
}
#pragma Event Respose
- (void)buttonPressed:(UIButton*)button {
    for (int i = 0; i<_buttonCount; i++) {
        UIButton *button = (UIButton*)[_backView viewWithTag:i+kButtonTag];
        button.selected = NO;
        button.backgroundColor = WHITE;
        button.layer.borderColor = [[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] CGColor];
    }
    button.selected = YES;
    button.backgroundColor =[UIColor colorWithRed:70/255.0 green:168/255.0 blue:238/255.0 alpha:1];
    button.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:168/255.0 blue:238/255.0 alpha:1]CGColor];
    self.selectedIndex = (int)(button.tag-kButtonTag);
    //选中隐藏
    self.hidden = YES;
    [self paclUpMenu];
}
//跟随选中
- (void)selectWithIndex:(NSInteger)index{
    for (int i =0; i<_buttonCount; i++) {
        UIButton *button = (UIButton*)[_backView viewWithTag:i+kButtonTag];
        button.backgroundColor = WHITE;
        button.layer.borderColor = [[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] CGColor];
        button.selected = NO;
    }
        UIButton *button = (UIButton*)[_backView viewWithTag:index+kButtonTag];
        button.selected = YES;
        button.backgroundColor =[UIColor colorWithRed:70/255.0 green:168/255.0 blue:238/255.0 alpha:1];
        button.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:168/255.0 blue:238/255.0 alpha:1]CGColor];
}
#pragma mark - Event response
- (void)tapgesture {
//    self.hidden = YES;
    [self paclUpMenu];
}
//弹出菜单
- (void)dragDownMenu {
    if (_isShowMenu==NO) {
        _isShowMenu = YES;
        [UIView animateWithDuration:0.4 animations:^{
            [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(300);
            }];
            //线条
            [_UplinLbale mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(0.5);
            }];
            [_titlleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(88/2);
            }];
                        //线条
            [_downlinLbale mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(0.5);
            }];
            //收回菜单
            [_dragImageMenu mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(90/2);
            }];
            if (_buttonCount > 0) {
                for (int i = 0; i < _buttonCount; i ++) {
                    UIButton *allButton = (UIButton *)[self viewWithTag:(i+kButtonTag)];
                    [allButton mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(kButtonHeight);

                    }];
                }
            }
            [_backView layoutIfNeeded];
        }];
//        [UIView commitAnimations];
    }
}
//隐藏菜单
- (void)paclUpMenu {
    [UIView animateWithDuration:0.4 animations:^{
        //将菜单放到最前面
        _isShowMenu = NO;
        [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        //线条
        [_UplinLbale mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [_titlleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        //线条
        [_downlinLbale mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        //收回菜单
        [_dragImageMenu mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        if (_buttonCount > 0) {
            for (int i = 0; i < _buttonCount; i ++) {
                UIButton *allButton = (UIButton *)[self viewWithTag:(i+kButtonTag)];
                [allButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                }];
            }
        }
    }];
    self.hidden = YES;
}
@end
