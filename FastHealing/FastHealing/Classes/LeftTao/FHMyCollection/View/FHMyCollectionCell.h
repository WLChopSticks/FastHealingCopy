//
//  FHMyCollectionCell.h
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FHMyCollectionModel;
@interface FHMyCollectionCell : UITableViewCell

/**
 *  创建关注医生的cell
 */
+ (instancetype)loadCellWith:(UITableView *)tableView;
//声明模型属性
@property (strong, nonatomic) FHMyCollectionModel *collectionModel;
@end





