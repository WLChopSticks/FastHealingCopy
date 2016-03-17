//
//  FHSickSimultaneousCell.h
//  dcDemo
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHSickSimultaneous.h"

@interface FHSickSimultaneousCell : UITableViewCell

@property (nonatomic, strong) FHSickSimultaneous *sickModel;

@property (nonatomic, copy) void (^blockSelected)();

//标记cell
- (void)maskThisCell;

@end
