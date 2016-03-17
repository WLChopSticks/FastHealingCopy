//
//  FHHeadScrolView.h
//  FastHealing
//
//  Created by 王 on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeScrollViewBlock)(BOOL isInstroduct);


@interface FHHeadScrolView : UIView

@property (copy, nonatomic) ChangeScrollViewBlock scrollViewChangeBlock;

@end
