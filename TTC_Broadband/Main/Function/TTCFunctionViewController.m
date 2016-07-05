//
//  TTCFunctionViewController.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCFunctionViewController.h"
#import "TTCNavigationController.h"
@interface TTCFunctionViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *setNameLabel;
@property (strong, nonatomic) UILabel *setDescLabel;
@property (strong, nonatomic) UIImageView *topImageView;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) UIScrollView *startView;
@end
@implementation TTCFunctionViewController
#pragma mark - Init methods
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self setSubViewLayout];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    //scrollView
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    //ContentView
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = WHITE;
    [_scrollView addSubview:_contentView];
    //图片
    _topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"msg_img3"]];
    _topImageView.hidden = YES;
    [_contentView addSubview:_topImageView];
    //系统公告
    _setNameLabel = [[UILabel alloc] init];
    _setNameLabel.hidden = YES;
    _setNameLabel.text = @"系统公告";
    _setNameLabel.font = FONTSIZESBOLD(30/2);
    _setNameLabel.textColor = LIGHTDARK;
    [_contentView addSubview:_setNameLabel];
    //内容
    _setDescLabel = [[UILabel alloc] init];
    _setDescLabel.numberOfLines = 0;
    _setDescLabel.text = @"提供最热门的体育赛事，高清画质让你犹如身临其境，热血沸腾，现优惠促销，买半年送2个月";
    _setDescLabel.font = FONTSIZESBOLD(24/2);
    _setDescLabel.textColor = [UIColor lightGrayColor];
    [_contentView addSubview:_setDescLabel];
    //webView
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"fun"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [webView loadHTMLString:htmlCont baseURL:baseURL];
    [_contentView addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_contentView);
    }];
    
}
- (void)setSubViewLayout{
    //scrollView
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_PRODEL-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);
    }];
    //图片
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(37/2);
        make.left.mas_equalTo(100/2);
    }];
    //系统公告
    [_setNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(37/2);
        make.left.mas_equalTo(_topImageView.mas_right).with.offset(9);
    }];
    //内容
    [_setDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_setNameLabel.mas_bottom).with.offset(22/2);
        make.left.mas_equalTo(_topImageView.mas_left);
        make.width.mas_equalTo(1333/2);
    }];
    //ContentView
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_scrollView.mas_left);
        make.width.mas_equalTo(_scrollView.mas_width);
        make.height.mas_equalTo(1000);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"功能介绍"];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//获取套餐标题
- (void)loadSetName:(NSString *)setName{
    _setNameLabel.text = setName;
}
//获取套餐详情
- (void)loadSetDesc:(NSString *)setDesc{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:setDesc];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:8];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [setDesc length])];
    _setDescLabel.attributedText = attributedString;
    [_setDescLabel sizeToFit];
}

@end
