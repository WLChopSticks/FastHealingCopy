//
//  FHSetingModel.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSetingModel.h"
#import "MJExtension.h"

@implementation FHSetingModel

+ (NSArray *)settingAndHelp{
    
    return [FHSetingModel mj_objectArrayWithFilename:@"SettingAndHelpModel.plist"];
}
@end
