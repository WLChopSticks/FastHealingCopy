//
//  FHDetailSick.m
//  dcDemo
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 王. All rights reserved.
//

#import "FHDetailSick.h"

@implementation FHDetailSick

+ (NSArray *)detailSickWithResponseDict:(NSDictionary *)dict {
    NSArray *responseArr = dict[@"data"];
    
    NSMutableArray *arrMu = [NSMutableArray array];
    
    for (NSDictionary *responseDict in responseArr) {
        FHDetailSick *model = [[FHDetailSick alloc]init];
        
        [model setValuesForKeysWithDictionary:responseDict];
        
        [arrMu addObject:model];
    }
    
    return arrMu.copy;
}

@end
