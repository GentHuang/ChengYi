//
//  TTCPrintDetailViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
//新的打印SDK
#import "RemotePrinter.h"
@interface TTCPrintDetailViewControllerViewModel : NSObject
@property (assign, nonatomic) BOOL isConnect;
@property (strong, nonatomic) NSMutableArray *dataInfoArray;
@property (strong, nonatomic) NSMutableArray *dataBooknoArray;
@property (strong, nonatomic) NSString *failMSG;
@property (strong, nonatomic) NSString *invoString;
//添加状态
@property (strong, nonatomic) NSString * status;
//test 
@property (assign, nonatomic) BOOL connectTestprintStaus;

//连接打印机
- (void)connectToPrinterSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//获取本号
- (void)getbooknoByInvno:(NSString *)invno success:(SuccessBlock)success fail:(FailBlock)fail;
//打印发票
- (void)printInvoiceWithArray:(NSArray *)dataArray invno:(NSString *)invno bookno:(NSString *)bookno payway:(NSString *)payway success:(SuccessBlock)success fail:(FailBlock)fail;
//获取发票编号
- (void)getopernextinvoWithDepID:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd operid:(NSString *)operid loginname:(NSString *)loginname name:(NSString *)name areaid:(NSString *)areaid city:(NSString *)city success:(SuccessBlock)success fail:(FailBlock)fail;
//打印字符串
- (void)printStringWithInfoArray:(NSArray *)dataArray success:(SuccessBlock)success fail:(FailBlock)fail;
//关闭打印机
- (void)closePrinter;
@end
