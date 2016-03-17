//
//  FHDoctorMessageVC.h
//  FastHealing
//
//  Created by 王 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHMyCollectionModel.h"

typedef void(^ActionDocBlock)(BOOL isAction);


@interface FHDoctorMessageVC : UIViewController
@property (strong, nonatomic) FHMyCollectionModel *collectionModel;
@property (copy, nonatomic) ActionDocBlock actionDocBlock;

@end
