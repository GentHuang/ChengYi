//
//  TTCShoppingCarCell.h
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    kHeaderType,
    kOtherType,
    kFooterType
    
}CellType;

@protocol TTCShoppingCarCellDelegate <NSObject>

@optional
// 发送按钮状态改变通知
- (void) changeCellBottonSelectedButton:(UIButton *)button;

@end

@interface TTCShoppingCarCell : UITableViewCell
// 是否全部取消选择
@property (assign, nonatomic,getter=isAllSelectCancel) BOOL isAllSelectCancel;
@property (weak, nonatomic) id<TTCShoppingCarCellDelegate>cellDelegate;

//选择Cell类型
- (void)selectCellType:(CellType)type;
//加载产品详情
- (void)loadWithImage:(NSString *)smallimg title:(NSString *)title contents:(NSString *)contents price:(NSString *)price count:(NSString *)count;
//加载总价
- (void)loadAllPrice:(NSString *)allPrice;
//加载用户名字 营销人员名字
- (void)loadUserName:(NSString *)name sellName:(NSString *)sellName;
// 获取列表的IndexPath
- (void) selectBtnTagWithIndex:(NSIndexPath *)indexPath;
// 改变按钮的状态
- (void) btnStatusWithAllChoseButtonWithFlag:(BOOL) btnFlag;


@end
