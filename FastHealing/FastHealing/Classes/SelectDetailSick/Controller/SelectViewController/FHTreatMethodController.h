//
//  FHTreatMethodController.h
//  FastHealing
//
//  Created by 王 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHTreatMethodController : UITableViewController

@property (nonatomic, copy) void (^blockSelected) (NSInteger);

@end
