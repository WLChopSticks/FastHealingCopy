//
//  FHBlackView.m
//  FastHealing
//
//  Created by 王 on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHBlackView.h"

@implementation FHBlackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        self.alpha = 0.7;
        
    }
    return self;
}

@end
