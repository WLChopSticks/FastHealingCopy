//
//  FHWeatherView.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHWeatherView.h"

#import "UIView+Extension.h"

#import "Masonry.h"



@interface FHWeatherView ()

//separateView
@property (nonatomic, weak) UIView *separateView;
//底部视图
@property (nonatomic, weak) UIView *botomView;

@end

@implementation FHWeatherView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
    
        [self setupUI];
        //设置背景色
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    return self;
}

#pragma mark 添加子视图View
- (void)setupUI{
    //添加子View 设置约束
    [self creatSeparateView];
    [self.separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(self.height * 0.1);
        make.width.offset(1);
        make.height.offset(self.height * 0.8);
        
    }];
    
    [self.tempLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
//        make.left.equalTo(self.separateView.mas_right).offset(25);
//        make.right.equalTo(self.mas_right).offset(-25);
        make.centerX.equalTo(self.mas_centerX).offset(self.width / 4.0);
        make.width.offset(120);
        
        
    }];
    
    [self.weatherPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
       
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.width.equalTo(self.weatherPicture.mas_height);
        make.left.equalTo(self.mas_left).offset(8);
//        make.width.offset(42);
//        make.height.offset(30);
        
    }];
    
    [self.weatherLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.weatherPicture.mas_right).offset(20);
        make.centerY.equalTo(self.weatherPicture.mas_centerY);
        make.width.offset(36);
    }];
    
    [self.positionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.separateView.mas_left).offset(-8);
        make.centerY.equalTo(self.weatherPicture.mas_centerY);
        make.left.equalTo(self.weatherLable.mas_right).offset(8);
        
    }];
    
    [self.positionButton addTarget:self action:@selector(didClickPositionButton) forControlEvents:UIControlEventTouchUpInside];

}
- (void)didClickPositionButton{

    if ([self.delegate respondsToSelector:@selector(ClickPositionButton:)]) {
        
        [self.delegate ClickPositionButton:self];
        
    }
    
}

//分割线
- (void)creatSeparateView{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:self.bounds];
    self.botomView = bottomView;
    [self addSubview:bottomView];
    
    //添加分割线
    UIView *sepView = [[UIView alloc] init];
    sepView.backgroundColor = [UIColor blackColor];
    sepView.alpha = 0.2;
    self.separateView = sepView;
    [self.botomView addSubview:self.separateView];
    
    //添加 温度Lable
    [self.botomView addSubview:self.tempLable];
    
    //添加 天气图片
    [self.botomView addSubview:self.weatherPicture];
    
    //添加天气Lable
    [self.botomView addSubview:self.weatherLable];
    
    //添加地理UIButton
    [self.botomView addSubview:self.positionButton];
    
}


#pragma mark 子视图懒加载

-(UILabel *)tempLable{
    if (_tempLable == nil) {
        //添加 温度Lable
        _tempLable = [[UILabel alloc] init];
        [_tempLable setFont:[UIFont systemFontOfSize:17]];
        _tempLable.numberOfLines = 0;
        _tempLable.textAlignment = NSTextAlignmentCenter;
        
        _tempLable.text = @"周二 01月19日 (-5℃)";
        
    }
    return _tempLable;
}
- (UIImageView *)weatherPicture{
    if (_weatherPicture == nil) {
        _weatherPicture = [[UIImageView alloc] init];
        
        _weatherPicture.image = [UIImage imageNamed:@"mai"];
    }
    return _weatherPicture;
}
- (UILabel *)weatherLable{

    if (_weatherLable == nil) {
        _weatherLable = [[UILabel alloc] init];
        _weatherLable.text = @"晴";
        [_weatherLable setFont:[UIFont systemFontOfSize:17.0]];
        _weatherLable.adjustsFontSizeToFitWidth = YES;
        _weatherLable.numberOfLines = 0;
        _weatherLable.textAlignment = NSTextAlignmentCenter;
        //添加地理UIButton
        [self.botomView addSubview:self.positionButton];
    }
    return _weatherLable;
}
- (UIButton *)positionButton{
    
    if (_positionButton == nil) {
        _positionButton = [[UIButton alloc] init];
        _positionButton.titleLabel.numberOfLines = 0;
        [_positionButton.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        _positionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _positionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_positionButton setTitle:@"北京" forState:UIControlStateNormal];
        [_positionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _positionButton;
}




@end
