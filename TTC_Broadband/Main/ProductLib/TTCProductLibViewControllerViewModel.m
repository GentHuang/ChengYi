//
//  TTCProductLibViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCProductLibViewControllerViewModel.h"
//Model
#import "TTCProductLibViewControllerModel.h"
#import "TTCProductLibViewControllerRowsModel.h"
#import "TTCProductLibViewTypeModel.h"
#import "TTCProductLibViewTypePclistModel.h"
#import "TTCProductLibViewTypePclistPclistModel.h"
//add
#import "TTCProductLibViewTypeHotSellModel.h"

@implementation TTCProductLibViewControllerViewModel
//获取产品列表数据
- (void)getProListWithItemID:(NSString *)itemid page:(int)page success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //下载数据itemid
    if (itemid==nil) {
        failBlock(nil);
        return;
    }
    //获取热销产品
    if ([itemid isEqualToString:@"热销"]) {
        [self getDataAHotSellProductsuccess:^(NSMutableArray *resultArray) {
            successBlock(nil);
        } fail:^(NSError *error) {
            failBlock(nil);
        }];
        return;
    }else {
    
    [[NetworkManager sharedManager] GET:kGetProListAPI parameters:@{@"itemid":itemid,@"row":@"20",@"page":[NSString stringWithFormat:@"%d",page]} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化数据
        if (page == 1) {
            _dataProductListArray = [NSMutableArray array];
        }
        TTCProductLibViewControllerModel *vcModel = [[TTCProductLibViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        if (page == 1) {
            //清空数据库
            [[FMDBManager sharedInstace] deleteModelInDatabase:[TTCProductLibViewControllerRowsModel class] withDic:@{@"itemid":itemid,@"page":[NSString stringWithFormat:@"%d",page]}];
        }
        for (TTCProductLibViewControllerRowsModel *rowsModel in vcModel.rows) {
            [_dataProductListArray addObject:rowsModel];
            rowsModel.page = page;
            rowsModel.itemid = itemid;
            if (page == 1) {
                //插入数据库
                [[FMDBManager sharedInstace] creatTable:rowsModel];
                [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:rowsModel withCheckNum:3];
            }
        }
        if (_dataProductListArray.count > 0) {
            //成功
            successBlock(nil);
        }else{
            //失败
            [[FMDBManager sharedInstace] selectModelArrayInDatabase:[TTCProductLibViewControllerRowsModel class] withDic:@{@"itemid":itemid,@"page":[NSString stringWithFormat:@"%d",page]} success:^(NSMutableArray *resultArray) {
                //数据库读取成功
                for (TTCProductLibViewControllerRowsModel *rowsModel in resultArray) {
                    [_dataProductListArray addObject:rowsModel];
                }
                if (_dataProductListArray.count > 0) {
                    successBlock(nil);
                }
            } fail:^(NSError *error) {
                //数据库读取失败
                failBlock(nil);
            }];
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        [[FMDBManager sharedInstace] selectModelArrayInDatabase:[TTCProductLibViewControllerRowsModel class] withDic:@{@"itemid":itemid,@"page":[NSString stringWithFormat:@"%d",page]} success:^(NSMutableArray *resultArray) {
            //数据库读取成功
            for (TTCProductLibViewControllerRowsModel *rowsModel in resultArray) {
                [_dataProductListArray addObject:rowsModel];
            }
            if (_dataProductListArray.count > 0) {
                successBlock(nil);
            }
        } fail:^(NSError *error) {
            //数据库读取失败
            failBlock(nil);
        }];
    }];
        
    }
}
//获取产品分类
- (void)getProductTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //下载数据
    [[NetworkManager sharedManager] GET:kGetProTypeAPI parameters:nil success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化数据
        _dataProductTypeArray = [NSMutableArray array];
        _dataProductTypeNameArray = [NSMutableArray array];
        _dataProductSubTypeArray = [NSMutableArray array];
        _dataProductSubTypeNameArray = [NSMutableArray array];
        _dataProductTypeImageArray  =[NSMutableArray array];
        //下载数据
        NSArray *responseArray = responseObject;
        for (NSDictionary *dic in responseArray) {
            TTCProductLibViewTypeModel *vcModel = [[TTCProductLibViewTypeModel alloc] init];
            [vcModel setValuesForKeysWithDictionary:dic];
            //一级目录
            [_dataProductTypeArray addObject:vcModel];
            [_dataProductTypeNameArray addObject:vcModel.title];
            [_dataProductTypeImageArray addObject:vcModel.img];
            for (TTCProductLibViewTypePclistModel *pclistModel in vcModel.pclist) {
                //二级目录
                [_dataProductSubTypeArray addObject:pclistModel];
                [_dataProductSubTypeNameArray addObject:pclistModel.title];
            }
        }
        if (_dataProductTypeArray.count > 0) {
            //成功
            success(nil);
        }else{
            //失败
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        fail(nil);
    }];
}
//根据下标返回对应的二级目录
- (void)getSubProTypeWithIndex:(int)index{
    _dataProductSubTypeArray = [NSMutableArray array];
    _dataProductSubTypeNameArray = [NSMutableArray array];
    TTCProductLibViewTypeModel *vcModel = _dataProductTypeArray[index];
    for (TTCProductLibViewTypePclistModel *pclistModel in vcModel.pclist) {
        //二级目录
        [_dataProductSubTypeArray addObject:pclistModel];
        [_dataProductSubTypeNameArray addObject:pclistModel.title];
    }
//    NSLog(@"二级目录:%@",_dataProductSubTypeNameArray);
}
//获取热销产品
- (void)getDataAHotSellProductsuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //
    [[NetworkManager sharedManager]GET:kGetHotSellAPI parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
       _dataProductListArray = [NSMutableArray array];
        TTCProductLibViewControllerModel *hotSellModel = [[TTCProductLibViewControllerModel alloc]init];
        [hotSellModel setValuesForKeysWithDictionary:responseObject];
        for (TTCProductLibViewControllerRowsModel *RowsModel in hotSellModel.rows) {
            [_dataProductListArray addObject:RowsModel];
        }
        success(nil);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error);
        fail(nil);
    }];

}
//获取热销产品
//- (void)getDataAHotSellProduct{
//    //
//    [[NetworkManager sharedManager]GET:kGetHotSellAPI parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
//        
//        TTCProductLibViewControllerModel *hotSellModel = [[TTCProductLibViewControllerModel alloc]init];
//        _dataProductListArray = [NSMutableArray array];
//        [hotSellModel setValuesForKeysWithDictionary:responseObject];
//        for (TTCProductLibViewControllerRowsModel *RowsModel in hotSellModel.rows) {
//            [_dataProductListArray addObject:RowsModel];
//        }
//        NSLog(@"====1111111111====");
//        
//    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
//        NSLog(@"%@",error);
//        
//    }];
//    NSLog(@"====33333====");
//    for (int i = 0; i<_dataProductListArray.count; i++) {
//        TTCProductLibViewControllerRowsModel *RowsModel =_dataProductListArray[i];
//        NSLog(@"热销产品%@",RowsModel.title);
//    }
//}


@end
