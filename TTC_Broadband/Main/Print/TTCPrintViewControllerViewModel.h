//
//  TTCPrintViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCPrintViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *allPrintArray;
@property (strong, nonatomic) NSMutableArray *dataPrintArray;
@property (strong, nonatomic) NSMutableArray *dataGroupIDArray;
@property (assign, nonatomic) float allPrice;
@property (copy, nonatomic) SuccessBlock noPrintInfoSuccessBlock;
@property (copy, nonatomic) FailBlock noPrintInfoFailBlock;
//通过GroupID返回未打印发票数组
- (void)getNoPrintInfoWithGroupID:(NSString *)groupID dataArray:(NSArray *)dataArray;
//获取未打印发票信息
- (void)getNoInvoiceInfo;
@end
