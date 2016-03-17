//
//  FHSickSimultaneous.h
//  dcDemo
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHSickSimultaneous : NSObject

@property (nonatomic, copy) NSString *complication_name;
@property (nonatomic, assign) NSInteger complication_id;

+ (NSArray *)sickSimultaneousWithResponseDict:(NSDictionary *)dict;

@end
