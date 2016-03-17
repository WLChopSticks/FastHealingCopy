//
//  FHSelectTextView.h
//  dcDemo
//
//  Created by 王 on 16/1/19.
//  Copyright © 2016年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHSelectTextView : UIView

- (instancetype)initWithPlaceHolder:(NSString *)placeHolder;

- (void)createSelectButtonWithFirstString:(NSString *)firstStr secondString:(NSString *)secondStr;

@property (nonatomic, copy) void (^block)(NSInteger);

@property (nonatomic, weak) UILabel *placeHolder;

@property (nonatomic, weak) UILabel *amountLabel;

@end
