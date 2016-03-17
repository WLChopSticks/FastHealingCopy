//
//  FHWeatherView.h
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FHWeatherPositionViewController.h"

@class FHWeatherView;

@protocol  FHWeatherViewDelegate <NSObject>

- (void)ClickPositionButton:(FHWeatherView *)weatherView;

@end

@interface FHWeatherView : UIView 

//Delegate property
@property (nonatomic, weak) id <FHWeatherViewDelegate> delegate;

//temperature Lable
@property (nonatomic, strong) UILabel *tempLable;

//weather Picture
@property (nonatomic, strong) UIImageView *weatherPicture;

//weather Lable
@property (nonatomic, strong) UILabel *weatherLable;

//position button
@property (nonatomic, strong) UIButton *positionButton;


@end
