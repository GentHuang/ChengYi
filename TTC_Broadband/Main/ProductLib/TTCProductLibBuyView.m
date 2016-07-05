//
//  TTCProductLibBuyView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/27.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCProductLibBuyView.h"
#import "TTCProductLibDragView.h"
//Macro
#define kButtonTag 86000
#define kButtonYearTag 86100
@interface TTCProductLibBuyView()<UIGestureRecognizerDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property (assign, nonatomic) CGFloat price;
@property (assign, nonatomic) int orderCount;
@property (assign, nonatomic) int selectType;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *viewImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceNameLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *addressNameLabel;
@property (strong, nonatomic) UIView *addressBackView;
@property (strong, nonatomic) UIImageView *dragImageVIew;
@property (strong, nonatomic) UITapGestureRecognizer *addressTap;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) NSArray *buttonArray;
@property (strong, nonatomic) UITextField *countTextField;
@property (strong, nonatomic) UILabel *totalLabel;
@property (strong, nonatomic) UIImageView *totalRMBImageView;
@property (strong, nonatomic) UILabel *totalNameLabel;
@property (strong, nonatomic) UIButton *buyButton;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) TTCProductLibDragView *dragView;
@property (strong, nonatomic) UIActivityIndicatorView *progressView;
@property (strong, nonatomic) NSString *keyno;
@property (strong, nonatomic) NSString *permark;

//取消按钮
@property (strong, nonatomic) UIButton *cancelButton;
//购买年月
@property (strong, nonatomic) NSArray * databuyArray;
@end

@implementation TTCProductLibBuyView
#pragma mark - Init methods
- (void)initData{
    _buttonArray = @[[UIImage imageNamed:@"pro_btn_decrease"],[UIImage imageNamed:@"pro_btn_add"]];
    _databuyArray = @[@"3月",@"6月",@"1年",@"2年"];
}
- (instancetype)init{
    if(self = [super init]){
        [self initData];
        [self createUI];
        [self setSubViewLayout];
        [self addObserver];
    }
    return self;
}
- (void)dealloc{
    [_dragView removeObserver:self forKeyPath:@"addressString"];
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    self.orderCount = 1;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    //背景
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = WHITE;
    [self addSubview:_backView];
    //取消按钮
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_cancelButton];
    //    _cancelButton.backgroundColor = ORANGE;
    [_cancelButton setImage:[UIImage imageNamed:@"LayerClose"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelBuyView) forControlEvents:UIControlEventTouchUpInside];
    
    //viewImageView
    _viewImageView = [[UIImageView alloc] init];
    [_backView addSubview:_viewImageView];
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = BLACK;
    _titleLabel.text = @"Title";
    _titleLabel.font = FONTSIZES(30/2);
    [_backView addSubview:_titleLabel];
    //产品标准价(名字)
    _priceNameLabel = [[UILabel alloc] init];
    _priceNameLabel.text = @"产品标准价";
    _priceNameLabel.textColor = [UIColor lightGrayColor];
    _priceNameLabel.font = FONTSIZESBOLD(24/2);
    [_backView addSubview:_priceNameLabel];
    //￥图标
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_rmb"]];
    [_backView addSubview:_rmbImageView];
    //价格
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"";
    _priceLabel.textColor = ORANGE;
    _priceLabel.font = FONTSIZESBOLD(50/2);
    [_backView addSubview:_priceLabel];
    //选择用户
    _addressNameLabel = [[UILabel alloc] init];
    _addressNameLabel.text = @"选择用户";
    _addressNameLabel.textColor = [UIColor lightGrayColor];
    _addressNameLabel.font = FONTSIZESBOLD(24/2);
    [_backView addSubview:_addressNameLabel];
    //用户背景
    _addressBackView = [[UIView alloc] init];
    _addressBackView.layer.borderWidth = 0.5;
    _addressBackView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _addressBackView.layer.masksToBounds = YES;
    _addressBackView.layer.cornerRadius = 4;
    [_backView addSubview:_addressBackView];
    //用户列表
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.text = @"";
    _addressLabel.textColor = [UIColor lightGrayColor];
    _addressLabel.font = FONTSIZESBOLD(24/2);
    [_addressBackView addSubview:_addressLabel];
    //点击手势
    _addressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_addressBackView addGestureRecognizer:_addressTap];
    //下拉图标
    _dragImageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_btn_dragdown"]];
    [_addressBackView addSubview:_dragImageVIew];
    //创建增加和减少按钮
    for (int i = 0; i < _buttonArray.count; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setBackgroundImage:_buttonArray[i] forState:UIControlStateNormal];
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_addressBackView.mas_bottom).with.offset(25);
            make.left.mas_equalTo(_addressBackView.mas_left).with.offset(i*(180/2));
        }];
        if (i == 0) {
            //周期输入框
            _countTextField = [[UITextField alloc] init];
            _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
            _countTextField.delegate = self;
            _countTextField.textColor = LIGHTDARK;
            //add
            [_countTextField addTarget:self action:@selector(sureCountNum:) forControlEvents:UIControlEventEditingChanged];
            
            _countTextField.keyboardType = UIKeyboardTypeNumberPad;
            _countTextField.font = FONTSIZESBOLD(24/2);
            _countTextField.textAlignment = NSTextAlignmentCenter;
            _countTextField.layer.masksToBounds = YES;
            _countTextField.layer.cornerRadius = 5;
            _countTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _countTextField.layer.borderWidth = 0.5;
            [_backView addSubview:_countTextField];
            [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(allButton.mas_centerY);
                make.left.mas_equalTo(allButton.mas_right).with.offset(20/2);
                make.width.mas_equalTo(90/2);
                make.height.mas_equalTo(allButton.mas_height);
            }];
        }
    }
    //总计
    _totalLabel = [[UILabel alloc] init];
    _totalLabel.text = @"0.00";
    _totalLabel.textAlignment = NSTextAlignmentRight;
    _totalLabel.textColor = [UIColor orangeColor];
    _totalLabel.font = FONTSIZESBOLD(50/2);
    [_backView addSubview:_totalLabel];
    //rmb
    _totalRMBImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_small_left"]];
    [_backView addSubview:_totalRMBImageView];
    //总计
    _totalNameLabel = [[UILabel alloc] init];
    _totalNameLabel.textAlignment = NSTextAlignmentRight;
    _totalNameLabel.text = @"总计：";
    _totalNameLabel.textColor = [UIColor lightGrayColor];
    _totalNameLabel.font = FONTSIZESBOLD(24/2);
    [_backView addSubview:_totalNameLabel];
    
    //add
    //订购一年或者两年按钮
    for (int i = 0; i< _databuyArray.count; i++) {
        UIButton *Yearbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:Yearbutton];
        //        Yearbutton.backgroundColor = [UIColor orangeColor];
        Yearbutton.tag =kButtonYearTag+i;
        [Yearbutton setTitle:_databuyArray[i] forState:UIControlStateNormal];
        [Yearbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [Yearbutton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
        [Yearbutton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
        [Yearbutton addTarget:self action:@selector(yearButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        //图片和文字的位置
        Yearbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [Yearbutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [Yearbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [Yearbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_countTextField.mas_bottom).offset(35);
            make.left.mas_equalTo(_addressBackView.mas_left).with.offset(i*(160/2));
            make.width.mas_equalTo(130/2);
            make.height.mas_equalTo(44/2);
        }];
    }
    
    //马上订购
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.backgroundColor = DARKBLUE;
    [_buyButton addTarget:self action:@selector(buyOrAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_buyButton setTitle:@"马上订购" forState:UIControlStateNormal];
    _buyButton.titleLabel.font = FONTSIZESBOLD(31/2);
    _buyButton.layer.masksToBounds = YES;
    _buyButton.layer.cornerRadius = 4;
    [_backView addSubview:_buyButton];
    //加载等待
    _progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_progressView stopAnimating];
    [_buyButton addSubview:_progressView];
    //下拉列表
    _dragView = [[TTCProductLibDragView alloc] init];
    [self addSubview:_dragView];
}
- (void)setSubViewLayout{
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(456);//850/2
        make.height.mas_equalTo(736/2);//636
    }];
    //取消按钮
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView.mas_top);
        make.centerX.equalTo(_backView.mas_right);
        make.width.height.mas_equalTo(50/2);
    }];
    //ViewImageView
    [_viewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(38);//5
        make.width.height.mas_equalTo(90/2);
    }];
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_viewImageView.mas_top).with.offset(7);
        make.left.mas_equalTo(_viewImageView.mas_right).with.offset(28);
    }];
    //产品标准价(名字)
    [_priceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(25);
        make.left.mas_equalTo(_titleLabel.mas_left);
    }];
    //￥图片
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceNameLabel.mas_bottom).with.offset(-2);
        make.left.mas_equalTo(_priceNameLabel.mas_right).with.offset(42/2);
    }];
    //价格
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceNameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_rmbImageView.mas_right).with.offset(14/2);
    }];
    //选择用户
    [_addressNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceNameLabel.mas_left);
        make.top.mas_equalTo(_priceNameLabel.mas_bottom).with.offset(20);
    }];
    //用户背景
    [_addressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceNameLabel.mas_left);
        make.top.mas_equalTo(_addressNameLabel.mas_bottom).with.offset(10);
        make.width.mas_equalTo(323);
        make.height.mas_equalTo(54/2);
    }];
    //用户
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_addressBackView.mas_centerY);
        make.left.mas_equalTo(18/2);
    }];
    //下拉图标
    [_dragImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_addressBackView.mas_centerY);
        make.right.mas_equalTo(_addressBackView.mas_right).with.offset(-4);
    }];
    //总计
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_addressBackView.mas_bottom).with.offset(20);
        make.right.mas_equalTo(_addressBackView.mas_right);
    }];
    //rmb
    [_totalRMBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_totalLabel.mas_bottom).with.offset(-6);
        make.right.mas_equalTo(_totalLabel.mas_left).with.offset(-22/2);
    }];
    //总计
    [_totalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_totalLabel.mas_bottom).with.offset(-5);
        make.right.mas_equalTo(_totalRMBImageView.mas_left).with.offset(-3);
    }];
    //立即订购
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-31);
        make.centerX.mas_equalTo(_backView.mas_centerX);
        make.width.mas_equalTo(220/2);
        make.height.mas_equalTo(60/2);
    }];
    //下拉列表
    [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_addressBackView.mas_bottom).with.offset(0);
        make.left.right.mas_equalTo(_addressBackView);
    }];
    //加载等待
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_buyButton);
    }];
}
#pragma mark - Event response
//添加观察者
- (void)addObserver{
    //点击用户列表
    [_dragView addObserver:self forKeyPath:@"addressString" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"addressString"]) {
        //点击用户列表
        NSString *addressString = [change valueForKey:@"new"];
        [self loadAddressString:addressString];
        NSArray *dataArray = [addressString componentsSeparatedByString:@" "];
        _permark = [dataArray firstObject];
        _keyno = [dataArray lastObject];
        if ([_permark isEqualToString:@"模拟"]) {
            _permark = @"0";
        }else if ([_permark isEqualToString:@"数字"]) {
            _permark = @"1";
        }else if ([_permark isEqualToString:@"宽带"]) {
            _permark = @"2";
        }else if ([_permark isEqualToString:@"互动"]) {
            _permark = @"3";
        }else if ([_permark isEqualToString:@"智能"]) {
            _permark = @"4";
        }
    }
}
//点击隐藏
- (void)tapPressed:(UITapGestureRecognizer *)tap{
    [self hideBuyView];
    [_dragView packUpList];
}
//点击按钮（马上订购，加入购物车）
- (void)buyOrAddButtonPressed:(UIButton *)button{
    self.stringBlock(button.titleLabel.text);
}
//点击Tap
- (void)tapAction:(UITapGestureRecognizer *)tap{
    [_dragView dragDownList];
}
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    //如果点击这里则取消年份选择
//    for (int i = 0; i<_databuyArray.count; i++) {
//        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
//        buyButton.selected = NO;
//    }
    //如果点击这里则取消年份选择
    [self clearBuyYearSelectedStatus];
    
    if ((button.tag - kButtonTag)==0) {
        //减少周期
        if (self.orderCount > 1) {
            self.orderCount --;
        }
    }else{
        //增加周期
        self.orderCount ++;
    }
    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
}
//订购一年两年按钮
- (void)yearButtonPress:(UIButton*)button {
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.selected = NO;
        if (button.tag - kButtonYearTag ==i) {
            switch (i) {
                case 0:{
                    //购买3个月
                    self.orderCount =3;
                    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
                    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
                }
                    break;
                case 1:{
                    //购买6个月
                    self.orderCount =6;
                    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
                    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
                }
                    break;
                case 2:{
                    //购买12个月
                    self.orderCount =1*12;
                    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
                    
                    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
                }
                    break;
                case 3:{
                    //购买24个月
                    self.orderCount =2*12;
                    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
                    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
                }
                    break;
                default:
                    break;
            }
            
            
        }
    }
    button.selected = YES;
}
//取消按钮
- (void)cancelBuyView {
    [self hideBuyView];
}
#pragma mark - Data request
#pragma mark - Protocol methods
//UIGestureRecognizerDelegate Method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        [_dragView packUpList];
        return NO;
    }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }
    return YES;
}
#pragma mark - Other methods
//加载用户数据
- (void)loadUserListWithArray:(NSArray *)dataArray permarkArray:(NSArray *)permarkArray{
    [_dragView loadUserListWithArray:dataArray permarkArray:permarkArray];
}
//加载产品数据
- (void)loadTitle:(NSString *)title intro:(NSString *)intro price:(NSString *)price smallimg:(NSString *)smallimg firstUserKeyno:(NSString *)firstUserKeyno firstUserPermark:(NSString *)firstUserPermark{
    _price = [price floatValue];
    _titleLabel.text = title;
    _priceLabel.text = price;
    [_viewImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMGURL,smallimg]]];
    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(self.orderCount*[price floatValue])];
    if ([firstUserPermark isEqualToString:@"0"]) {
        firstUserPermark = @"模拟";
    }else if ([firstUserPermark isEqualToString:@"1"]) {
        firstUserPermark = @"数字";
    }else if ([firstUserPermark isEqualToString:@"2"]) {
        firstUserPermark = @"宽带";
    }else if ([firstUserPermark isEqualToString:@"3"]) {
        firstUserPermark = @"互动";
    }else if ([firstUserPermark isEqualToString:@"4"]) {
        firstUserPermark = @"智能";
    }
    [self loadAddressString:[NSString stringWithFormat:@"%@ %@",firstUserPermark,firstUserKeyno]];
}
//读取地址
- (void)loadAddressString:(NSString *)address{
    self.addressString = address;
    self.addressLabel.text = self.addressString;
}
//选择View模式
- (void)selectViewType:(ViewType)viewType{
    switch (viewType) {
        case 0:
            [self buyType];
            break;
        case 1:
            [self carType];
            break;
        default:
            break;
    }
    _selectType = viewType;
}
#pragma mark  textFieldDelegate
- (void)sureCountNum:(UITextField*)textField{
    NSLog(@"=== %@",textField.text);
    if (textField==_countTextField) {
        self.orderCount = (int)[textField.text intValue];
        _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
    }
}

//立即购买
- (void)buyType{
    //马上订购
    _buyButton.backgroundColor = DARKBLUE;
    [_buyButton setTitle:@"马上订购" forState:UIControlStateNormal];
    [_buyButton setImage:nil forState:UIControlStateNormal];
    //点击后值重新开
    self.orderCount = 1;
    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
    [self clearBuyYearSelectedStatus];
}
//加入购物车
- (void)carType{
    //加入购物车
    _buyButton.backgroundColor = ORANGE;
    [_buyButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [_buyButton setImage:[UIImage imageNamed:@"shoppingCart"] forState:UIControlStateNormal];
    //点击后值重新开
    self.orderCount = 1;
    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
    [self clearBuyYearSelectedStatus];
}
//显示
- (void)showBuyView{
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}
//隐藏
- (void)hideBuyView{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }];
    self.hidden = YES;
    //    self.orderCount = 1;
}
//首次加载等待
- (void)startDownload{
    [_buyButton setTitle:@"" forState:UIControlStateNormal];
    [_progressView startAnimating];
}
//首次加载成功
- (void)stopDownload{
    if (_selectType == kBuyType) {
        [_buyButton setTitle:@"马上订购" forState:UIControlStateNormal];
    }else{
        [_buyButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_buyButton setImage:[UIImage imageNamed:@"shoppingCart"] forState:UIControlStateNormal];
    }
    [_progressView stopAnimating];
}
//隐藏购买年份月份按钮
- (void)hiddeBUyYearOrMonthlyButton{
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.hidden = YES;
    }
}
//显示购买年份月份按钮
- (void)showBuyYearOrMonthlyButton {
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.hidden = NO;
    }
}
//取消购买年份按钮的选择
- (void)clearBuyYearSelectedStatus{
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.selected = NO;
    }
}
@end
