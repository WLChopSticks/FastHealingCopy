//
//  FHDetailSick.h
//  dcDemo
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHDetailSick : NSObject

@property (nonatomic, copy) NSString *ci3_name;
@property (nonatomic, assign) NSInteger ci2_id;
@property (nonatomic, assign) NSInteger ci3_id;

+ (NSArray *)detailSickWithResponseDict:(NSDictionary *)dict;

@end
