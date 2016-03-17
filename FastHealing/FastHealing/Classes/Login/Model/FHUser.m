//
//  FHUser.m
//  FastHealing
//
//  Created by 王 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHUser.h"
#import "MJExtension.h"

@implementation FHUser

+ (instancetype)userWithDict:(NSDictionary *)dict {
    return [FHUser mj_objectWithKeyValues:dict];
}

@end
