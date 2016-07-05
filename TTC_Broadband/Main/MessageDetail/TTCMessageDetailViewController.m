//
//  TTCMessageDetailViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCMessageDetailViewController.h"
#import "TTCNavigationController.h"
#import "TTCMessageDetailProductView.h"
#import "TTCProductDetailViewController.h"
//add
#import "TTCTabbarController.h"
//ViewModel
#import "TTCMessageDetailViewControllerViewModel.h"
@interface TTCMessageDetailViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *setNameLabel;
@property (strong, nonatomic) UIWebView *setDescView;
@property (strong, nonatomic) UIImageView *topImageView;
@property (strong, nonatomic) TTCMessageDetailViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) UIView *TitlebackgroundView;
@property (strong, nonatomic) TTCMessageDetailProductView *JumpProductDetailView;
@end
@implementation TTCMessageDetailViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCMessageDetailViewControllerViewModel alloc] init];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self getData];
    [self setSubViewLayout];
    [self sendIsRead];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    //隐藏tabbar
        TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
        TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
        [tab hideBar];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
    [tab showBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    //scrollView
    _scrollView = [[UIScrollView alloc] init];
//    _scrollView.userInteractionEnabled = YES;
    [self.view addSubview:_scrollView];
    //ContentView
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = WHITE;
    [_scrollView addSubview:_contentView];
    
    //title背景颜色
    _TitlebackgroundView = [[UIView alloc]init];
    _TitlebackgroundView.backgroundColor = LIGHTGRAY;
    [_contentView addSubview:_TitlebackgroundView];
    //图片
    _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noticeIcon"]];//msg_img_new1 msg_img3
    [_TitlebackgroundView addSubview:_topImageView];
//    [_contentView addSubview:_topImageView];
    //系统公告
    _setNameLabel = [[UILabel alloc] init];
    _setNameLabel.text = _titleString;
    _setNameLabel.font = FONTSIZESBOLD(30/2);
    _setNameLabel.textColor = LIGHTDARK;
    [_contentView addSubview:_setNameLabel];
    //内容
    _setDescView = [[UIWebView alloc] init];
    _setDescView.opaque = NO;
    _setDescView.backgroundColor = WHITE;
    if (_content.length > 0) {
//        加载产品详情
//        NSString *contentString = [NSString stringWithFormat:@"%@",_content];
//        contentString = [contentString stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\""HTML5URL];
//        NSLog(@"网页===%@",contentString);
//        [_setDescView loadHTMLString:contentString baseURL:[NSURL URLWithString:HTML5URL]];
        
        [_setDescView loadHTMLString:_content baseURL:[NSURL URLWithString:HTML5URL]];

    }
    [_contentView addSubview:_setDescView];
    //跳转产品详情页面
    _JumpProductDetailView = [[TTCMessageDetailProductView alloc]init];
    _JumpProductDetailView.backgroundColor = LIGHTGRAY;
    __block TTCMessageDetailViewController *seflVC =self;
    _JumpProductDetailView.buttonClick = ^(UIButton *button){
        [seflVC pressProductView:seflVC.aboutitemid];
    };
    [_contentView addSubview:_JumpProductDetailView];
    [self.view addSubview:_JumpProductDetailView];

    
}
- (void)setSubViewLayout{
    //scrollView
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);//-TAB_HEIGHT
    }];
    //title背景颜色
    [_TitlebackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(25+37/2);
        make.width.equalTo(_contentView);
    }];
    //图片
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(37/2);//37/2
       make.left.mas_equalTo(100/2);
    }];
    //系统公告
    [_setNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(37/2);
        make.left.mas_equalTo(_topImageView.mas_right).with.offset(9);
    }];
    //内容
    [_setDescView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TitlebackgroundView.mas_bottom).with.offset(22/2);
        make.left.mas_equalTo(_topImageView.mas_left);
        make.width.mas_equalTo(1333/2);
        make.height.mas_equalTo(850);
    }];
    //ContentView
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_scrollView.mas_left);
        make.width.mas_equalTo(_scrollView.mas_width);
        make.bottom.mas_equalTo(_setDescView.mas_bottom);
    }];
    //购买
    [_JumpProductDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(_scrollView.mas_left);
        make.width.mas_equalTo(_scrollView.mas_width);
        make.top.mas_equalTo(_contentView.mas_bottom).offset(5);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"消息"];
}
#pragma mark - Event response
#pragma mark - Network request
//发送已读
- (void)sendIsRead{
    [_vcViewModel sendIsReadWithMid:_mid];
}
//跳转详情界面
- (void)pressProductView:(NSString *)productID {
    TTCProductDetailViewController *detailVC = [[TTCProductDetailViewController alloc] init];
    detailVC.id_conflict = productID;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)getData {
    __block TTCMessageDetailProductView *productView = _JumpProductDetailView;
    __block TTCMessageDetailViewControllerViewModel *VCmodel = _vcViewModel;
    [_vcViewModel getProductById:_aboutitemid success:^(NSMutableArray *resultArray) {
        [productView reloadDataWithString:VCmodel.ProductModel.title PriceString:VCmodel.ProductModel.price];
        
    } fail:^(NSError *error) {
        _JumpProductDetailView.hidden = YES;
    }];
    
}
#pragma mark - Protocol methods
#pragma mark - Other methods
@end
