//
//  TTCUserDetailViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserDetailViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerOutputAddrsPermarksModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
#import "TTCUserLocateViewControllerUserProductOutputProsModel.h"
@implementation TTCUserDetailViewControllerViewModel
//获取地址信息
- (NSString *)getAddrsInfoWithModel:(TTCUserLocateViewControllerOutputAddrsModel *)model{
    return model.addrinfo;
}
//通过下标获取用户信息
- (NSArray *)getServcInfoWithArray:(NSArray *)dataArray index:(int)index{
    NSMutableArray *array = [NSMutableArray array];
    TTCUserLocateViewControllerOutputAddrsModel *addrsModel = (TTCUserLocateViewControllerOutputAddrsModel *)dataArray[index];
    for (TTCUserLocateViewControllerOutputAddrsPermarksModel *permarksModel in addrsModel.permarks) {
        for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servcModel in permarksModel.servs) {
            if (servcModel.keyno.length > 0) {
                [array addObject:servcModel];
            }
        }
    }
    return array;
}
- (NSArray *)getUserProductWithAddressArray:(NSArray *)addressArray productArray:(NSArray *)productArray sectionIndex:(int)sectionIndex rowIndex:(int)rowIndex{
    //获取全部的用户
    NSMutableArray *array = [NSMutableArray array];
    TTCUserLocateViewControllerOutputAddrsModel *addrsModel = (TTCUserLocateViewControllerOutputAddrsModel *)addressArray[sectionIndex];
    for (TTCUserLocateViewControllerOutputAddrsPermarksModel *permarksModel in addrsModel.permarks) {
        for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servcModel in permarksModel.servs) {
            if (servcModel.keyno.length > 0) {
                [array addObject:servcModel];
            }
        }
    }
    //获取对应的用户
    TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servcModel = array[rowIndex];
    //获取特定用户的全部产品
    NSMutableArray *prosArray = [NSMutableArray array];
    for (TTCUserLocateViewControllerUserProductOutputProsModel *prosModel in productArray) {
        if ([prosModel.keyno isEqualToString:servcModel.keyno] && [prosModel.permark isEqualToString:servcModel.permark]) {
            [prosArray addObject:prosModel];
        }
    }
    return prosArray;
}
//获取
//add
////查询开户状态
//- (void)getUserOpenAccountResultSearch:(NSString*)CustomID success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
//    _dataAccountResultArray = [NSMutableArray array];
//    [[NetworkManager sharedManager]GET:@"" parameters:@"" success:^(AFHTTPRequestOperation * operation, id responsObject) {
//        
//        
//    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
//        NSLog(@"%@",error);
//    }];
//
//}
@end
