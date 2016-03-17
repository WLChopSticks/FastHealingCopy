//
//  FHTabBarController.m
//  FastHealing
//
//  Created by 王 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHTabBarController.h"
#import "FHTabBar.h"
#import "FHNavigationController.h"


@interface FHTabBarController ()<FHTabBarDelegate>

@end

@implementation FHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //初始化控制器
//    MMBHomeViewController *homeVc = [[MMBHomeViewController alloc] init];
//    [self addCHildVc:homeVc title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
//    MMBMessageCenterViewController *messageCenterVc = [[MMBMessageCenterViewController alloc] init];
//    [self addCHildVc:messageCenterVc title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
//    
//    
//    MMBDiscoverViewController *discoverVc = [[MMBDiscoverViewController alloc] init];
//    [self addCHildVc:discoverVc title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
//    
//    MMBProfileViewController *profileVc = [[MMBProfileViewController alloc] init];
//    [self addCHildVc:profileVc title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    FHTabBar *tabBar = [[FHTabBar alloc] init];
    tabBar.delegate = self;
    //利用KVC把系统的tabBar 换成自己的.
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

//tabBar的代理方法 点击加号按钮,弹出发微博页面
- (void)tabBarDidClickPlusButton:(FHTabBar *)tabBar{
//    MMBComposeViewController *vc = [[MMBComposeViewController alloc] init];
//    MMBNavigationController *nav = [[MMBNavigationController alloc] initWithRootViewController:vc];
    //    vc.view.backgroundColor = [UIColor whiteColor];
  //  [self presentViewController:nav animated:YES completion:nil];
}

/**
 *  添加一个自控制器
 *
 *  @param childVc       自控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)addCHildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    //childVc.tabBarItem.title = title;     // 设置tabbar的文字
    //childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//设置图片渲染方式为原始状态
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = FHColor(123, 123, 123);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    //设置随机色
    //childVc.view.backgroundColor = MMBRandomColor;
    //先给外面传进来的小控制器 包装 一个导航控制器
    FHNavigationController *nav = [[FHNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
