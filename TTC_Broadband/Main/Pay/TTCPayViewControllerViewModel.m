//
//  TTCPayViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPayViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerArrearOutputModel.h"
#import "TTCUserLocateViewControllerArrearOutputArreardetsModel.h"
#import "TTCPayViewControllerModel.h"
#import "TTCPayViewControllerOutputModel.h"
#import "TTCPayViewControllerOrderModel.h"
#import "TTCPayViewControllerOrderOutputModel.h"
#import "TTCPayViewControllerOrderOutputOrderinfosModel.h"
#import "TTCShoppingCarViewControllerModel.h"
//微信支付结果
#import "TTCQRPayViewOrderPayResultModel.h"
//Tool
#import "WXApi.h"  // 微信支付头文件
#import "WXApiObject.h" // 回调头文件
#import "payRequsestHandler.h" // 签名相关头文件
@interface TTCPayViewControllerViewModel()<UIApplicationDelegate,
UIAlertViewDelegate, WXApiDelegate>
@property (assign, nonatomic) int arrearTaskCount;
@property (assign, nonatomic) int curArrearTaskCount;
@property (assign, nonatomic) int orderTaskCount;
@property (assign, nonatomic) int curOrderTaskCount;
@property (strong, nonatomic) SellManInfo *sellManInfo;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@end

@implementation TTCPayViewControllerViewModel
- (void)initData{
    _sellManInfo = [SellManInfo sharedInstace];
    _customerInfo = [CustomerInfo shareInstance];
}
//初始化
- (instancetype)init{
    if (self = [super init]) {
        [self initData];
        [self addObserver];
    }
    return self;
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"curArrearTaskCount" context:nil];
    [self removeObserver:self forKeyPath:@"curOrderTaskCount" context:nil];
}
//缴纳欠费
- (void)payArrearsWithArray:(NSArray *)dataArray{
    //初始化
    _curArrearTaskCount = 0;
    self.arrearTaskCount = (int)dataArray.count;
    _dataOrderArray = [NSMutableArray array];
    //发送缴纳请求
    for (TTCUserLocateViewControllerArrearOutputModel *outputModel in dataArray) {
        [[NetworkManager sharedManager] GET:kPayArrearsAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"Mname":_sellManInfo.name,@"clientpwd":_sellManInfo.password,@"keyno":outputModel.keyno,@"permark":outputModel.permark,@"fees":outputModel.arrearsun,@"isorder":@"N",@"Deptname":_sellManInfo.depName,@"Uname":_customerInfo.custname} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
            NSLog(@"%@ %@",operation,responseObject);
            TTCPayViewControllerModel *vcModel = [[TTCPayViewControllerModel alloc] init];
            [vcModel setValuesForKeysWithDictionary:responseObject];
            TTCPayViewControllerOutputModel *outputModel = vcModel.output;
            //支付成功的订单信息
            if (outputModel.orderid.length > 0) {
                [_dataOrderArray addObject:outputModel.orderid];
            }
            self.curArrearTaskCount ++;
        } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
            _failMSG = @"网络开小差了哦";
            NSLog(@"%@",error);
        }];
    }
}
//马上订购
- (void)productOrderWithModel:(TTCProductDetailViewControllerModel *)dataModel keyno:(NSString *)keyno count:(NSString *)count success:(SuccessBlock)successBlock fail:(FailBlock)fail{
    //keyno转换格式
    NSRange range = [keyno rangeOfString:@" "];
    if (range.location != NSNotFound) {
        keyno = [keyno substringFromIndex:(range.location+1)];
    }
    //订购请求
    [[NetworkManager sharedManager] GET:kProductOrderAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"clientpwd":_sellManInfo.password,@"custid":_customerInfo.custid,@"keyno":keyno,@"ordertype":dataModel.type,@"salescode":dataModel.code,@"count":count,@"proname":dataModel.title,@"permark":dataModel.permark,@"Deptname":_sellManInfo.depName,@"Mname":_sellManInfo.name,@"Uname":_customerInfo.custname} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        _dataOrderArray = [NSMutableArray array];
        //获取数据
        TTCPayViewControllerOrderModel *orderModel = [[TTCPayViewControllerOrderModel alloc] init];
        [orderModel setValuesForKeysWithDictionary:responseObject];
        //判断是否存在流水号冲突
        NSRange range = [orderModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            NSLog(@"%@",responseObject);
            [self productOrderWithModel:dataModel keyno:keyno count:count success:^(NSMutableArray *resultArray) {
            } fail:^(NSError *error) {
            }];
            return;
        }
        TTCPayViewControllerOrderOutputModel *outputModel = orderModel.output;
        if (outputModel.orderinfos.count > 0) {
            //支付成功的订单信息
            [_dataOrderArray addObject:outputModel.orderid];
        }
        if (_dataOrderArray.count > 0) {
            successBlock(nil);
        }else{
            _failMSG = outputModel.message;
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        _failMSG = @"网络开小差了哦";
        NSLog(@"%@",error);
    }];
}
//购物车支付
- (void)carPayWithArray:(NSArray *)dataArray sucess:(SuccessBlock)successBlock fail:(FailBlock)fail{
    //初始化请求字符串
    NSString *keynoString = @"";
    NSString *orderTypeString = @"";
    NSString *salesCodeString = @"";
    NSString *countString = @"";
    NSString *pnameString = @"";
    NSString *permarkString = @"";
    TTCShoppingCarViewControllerModel *carModel;
    for (int i = 0; i < dataArray.count; i ++) {
        carModel = (TTCShoppingCarViewControllerModel *)dataArray[i];
        //组合请求字符串
        if (i == 0) {
            keynoString = [NSString stringWithFormat:@"%@",carModel.keyno];
            orderTypeString = [NSString stringWithFormat:@"%@",carModel.type];
            salesCodeString = [NSString stringWithFormat:@"%@",carModel.code];
            countString = [NSString stringWithFormat:@"%@",carModel.count];
            pnameString = [NSString stringWithFormat:@"%@",carModel.title];
            permarkString = [NSString stringWithFormat:@"%@",carModel.permark];
            
        }else{
            keynoString = [keynoString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.keyno]];
            orderTypeString = [orderTypeString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.type]];
            salesCodeString = [salesCodeString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.code]];
            countString = [countString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.count]];
            pnameString = [pnameString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.title]];
            permarkString = [permarkString stringByAppendingString:[NSString stringWithFormat:@",%@",carModel.permark]];
            
        }
    }
    //订购请求
    [[NetworkManager sharedManager] GET:kProductOrderAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"clientpwd":_sellManInfo.password,@"custid":_customerInfo.custid,@"keyno":keynoString,@"ordertype":orderTypeString,@"salescode":salesCodeString,@"count":countString,@"proname":pnameString,@"permark":permarkString,@"Deptname":_sellManInfo.depName,@"Mname":_sellManInfo.name,@"Uname":_customerInfo.custname} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        _dataOrderArray = [NSMutableArray array];
        //获取数据
        TTCPayViewControllerOrderModel *orderModel = [[TTCPayViewControllerOrderModel alloc] init];
        [orderModel setValuesForKeysWithDictionary:responseObject];
        TTCPayViewControllerOrderOutputModel *outputModel = orderModel.output;
        if (outputModel.orderinfos.count > 0) {
            //支付成功的订单信息
            [_dataOrderArray addObject:outputModel.orderid];
            for (int i = 0; i < outputModel.orderinfos.count; i ++) {
                TTCPayViewControllerOrderOutputOrderinfosModel *infoModel = outputModel.orderinfos[i];
                TTCShoppingCarViewControllerModel *insideCarModel = dataArray[i];
                insideCarModel.price = [NSString stringWithFormat:@"%.02f",[infoModel.price floatValue]];
            }
        }
        //检测是否获取到支付订单
        if (_dataOrderArray.count > 0) {
            for (int i = 0; i < dataArray.count; i ++) {
                TTCShoppingCarViewControllerModel *carModel = (TTCShoppingCarViewControllerModel *)dataArray[i];
                //删除数据库
                [[FMDBManager sharedInstace] deleteModelInDatabase:[TTCShoppingCarViewControllerModel class] withDic:@{@"id_conflict":carModel.id_conflict,@"keyno":carModel.keyno}];
                NSLog(@"%@   %@",carModel.id_conflict,carModel.keyno);
            }
            successBlock(nil);
        }else{
            _failMSG = outputModel.message;
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        _failMSG = @"网络开小差了哦";
        NSLog(@"%@",error);
    }];
}
//确定订单
- (void)sureOrderWithOrderArray:(NSArray *)orderArray carArray:(NSArray *)carArray payway:(NSString *)payway{
    if (orderArray.count > 0) {
        //初始化
        _curOrderTaskCount = 0;
        _orderTaskCount = (int)orderArray.count;
        //确定订单
        for (int i = 0; i < orderArray.count; i ++) {
            NSString *orderID = orderArray[i];
            [[NetworkManager sharedManager] GET:kSureOrderAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"clientpwd":_sellManInfo.password,@"orderid":orderID,@"payway":payway,@"bankaccno":@"",@"payreqid":@"121",@"paycode":@"23"} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
                if ([[responseObject valueForKey:@"status"] isEqualToString:@"0"]) {
                    self.curOrderTaskCount ++;
                }else{
                    _failMSG = [responseObject valueForKey:@"message"];
                    NSRange range = [@"失败" rangeOfString:_failMSG];
                    if (range.location != NSNotFound) {
                        self.curOrderTaskCount ++;
                    }else{
                        self.sureFailBlock(nil);
                        _curOrderTaskCount = 0;
                        return;
                    }
                }
            } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        //检测是否获取到支付订单
        if (orderArray.count > 0 && carArray.count > 0) {
            for (int i = 0; i < carArray.count; i ++) {
                TTCShoppingCarViewControllerModel *carModel = (TTCShoppingCarViewControllerModel *)carArray[i];
                //删除数据库
                [[FMDBManager sharedInstace] deleteModelInDatabase:[TTCShoppingCarViewControllerModel class] withDic:@{@"id_conflict":carModel.id_conflict,@"keyno":carModel.keyno}];
            }
        }
    }else{
        //确定订单失败
        _curOrderTaskCount = 0;
        _failMSG = @"支付失败";
        self.sureFailBlock(nil);
    }
}
#pragma mark   修改后使用Web支付
//使用网页支付
- (void)sendPayWebViewWithOrderID:(NSString*)orderID OrderName:(NSString *)orderName orderPrice:(NSString *)orderPrice sucess:(SuccessBlock)successBlock fail:(FailBlock)fail{
    //money=%@&orderno=%@&proname=%@
    NSString *urlString =[NSString stringWithFormat:KGetWeiXinPayAPI@"money=%@&orderno=%@&proname=%@",orderPrice,orderID,orderName];
    
     urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //  [[NetworkManager sharedManager]GET:KGetWeiXinPayAPI parameters:@{@"money":orderPrice,@"orderno":orderID,@"proname":orderName}
    
    [[NetworkManager sharedManager]GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation , id responseObject) {
        _PayQRWebViewString = [NSString stringWithFormat:@"%@",responseObject];
        successBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation , NSError * error) {
        NSLog(@"%@",error);
        fail(nil);
    }];
    
}
//查询支付情况
- (void)queryPayResultWithOderID:(NSString*)OrderID sucess:(SuccessBlock)successBlock fail:(FailBlock)fail{
    //拼接字符串
    NSString *urlString = [NSString stringWithFormat:KGetWeiXinPayResultAPI,OrderID];
    //姓名地址类型 如果有中文 中文转码
    if ([self iSContentChineseCharacter:OrderID]) {
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    //除去空格
    if ([urlString rangeOfString:@" "].location != NSNotFound ) {
        urlString = [urlString  stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    NSLog(@"url ====  %@",urlString);
    [[NetworkManager sharedManager]GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation , id responseObject) {
        TTCQRPayViewOrderPayResultModel *PayResultModel = [[TTCQRPayViewOrderPayResultModel alloc]init];
        NSDictionary *dic = [responseObject firstObject];
        [PayResultModel setValuesForKeysWithDictionary:dic];
        if ([PayResultModel.paysuccess isEqualToString:@"1"]) {
             successBlock(nil);
        }else {
           fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation , NSError * error) {
        NSLog(@"%@",error);
        fail(nil);
    }];
    
}
//微信支付
- (void)sendPayWithOrderName:(NSString *)orderName orderPrice:(NSString *)orderPrice{
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demoWithOrderName:orderName orderPrice:orderPrice];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}
#pragma mark - Event response
//添加观察者
- (void)addObserver{
    //观察欠费请求是否完成
    [self addObserver:self forKeyPath:@"curArrearTaskCount" options:NSKeyValueObservingOptionNew context:nil];
    //观察确定订单请求是否完成
    [self addObserver:self forKeyPath:@"curOrderTaskCount" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"curArrearTaskCount"]) {
        if (_curArrearTaskCount == _arrearTaskCount && _curArrearTaskCount != 0) {
            //欠费请求完成
            self.paySuccessBlock(nil);
        }
    }else if ([keyPath isEqualToString:@"curOrderTaskCount"]) {
        if (_curOrderTaskCount == _orderTaskCount) {
            //确定订单请求完成
            self.sureSuccessBlock(nil);
        }
    }
}
//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}
#pragma mark 后台生成订单,并且返回支付链接，以提供APP生成二维码

- (void)sendPayCreateQRcodeWithOrderName:(NSString *)orderName orderPrice:(NSString *)orderPrice OrderID:(NSString*)orderID Success:(SuccessBlock)success Fail:(FailBlock)fail;
{
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    //初始化签名对象
    //获取到实际调起微信支付的参数后，
    //把价格转换成分
    NSString *stringPrice = [NSString stringWithFormat:@"%d",[orderPrice intValue]*100];
    NSMutableDictionary *dict = [req sendPay_demoWithOrderName:[orderName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] orderPrice:stringPrice];
    //按微信规则生成二维码信息
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        fail(nil);
        NSLog(@"%@\n\n",debug);
    }else{
        
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        [dict setValue:orderID forKey:@"orderID"];
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        BOOL b = [WXApi sendReq:req];
        NSLog(@"%d",b);
        if([WXApi sendReq:req]==0){
            _PayQRString = [NSString stringWithFormat:PAYURL@"sign=%@&appid=%@&mch_id=%@&product_id=%@&time_stamp=%@&nonce_str=%@",[dict objectForKey:@"sign"],APP_ID,MCH_ID,orderID,stamp,[dict objectForKey:@"noncestr"]];
            NSLog(@"%@",_PayQRString);
            success(nil);
        }
    }
}
//判断是否含有中文
- (BOOL)iSContentChineseCharacter:(NSString*)string {
    //判断是否含有中文
    for (int i = 0; i<[string length]; i++) {
        int a = [string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff)
        {
            return YES;
        }
    }
    return NO;
}
@end
