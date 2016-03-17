//
//  FHTabBar.h
//  FastHealing
//
//  Created by 王 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHTabBar;
@protocol FHTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(FHTabBar *)tabBar;
@end

@interface FHTabBar : UITabBar

@property (nonatomic,weak) id<FHTabBarDelegate> delegate;

@end
