//
//  FHSickSimultaneousController.h
//  dcDemo
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHSickSimultaneousController : UITableViewController

@property (nonatomic, assign) NSInteger ci2_id;

@property (nonatomic, copy) void (^blockSelected) (NSArray *);

@end
