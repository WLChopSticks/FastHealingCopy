//
//  FHApplyForHelpController.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHApplyForHelpController.h"
#import "Masonry.h"
#import "FHChooseDiseaseController.h"

#define margin 10

@interface FHApplyForHelpController ()

@property (strong, nonatomic) FHChooseDiseaseController *chooseDiseaseVC;

@end

@implementation FHApplyForHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置UI布局
    [self decorateUI];
    
}


//设置UI布局
- (void)decorateUI {
    self.title = @"选择疾病";
//    self.view.backgroundColor = [UIColor greenColor];
    //设置背景颜色
        self.view.backgroundColor = FHColor(250, 250, 250);
    
    //添加提示label
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"请选择疾病类型:";
    tipLabel.font = [UIFont systemFontOfSize:18];
    tipLabel.textColor = FHPublicBenefitColor;
    [self.view addSubview:tipLabel];
    
    //添加collectionviewController
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    CGFloat itemW = (FHScreenSize.width - 5 * margin) / 2;
    layout.itemSize = CGSizeMake(itemW, itemW);
    layout.sectionInset = UIEdgeInsetsMake(margin * 2, margin * 2, margin * 2, margin * 2);
    FHChooseDiseaseController *chooseDiseaseVC = [[FHChooseDiseaseController alloc]initWithCollectionViewLayout:layout];
    self.chooseDiseaseVC = chooseDiseaseVC;
    [self.view addSubview:chooseDiseaseVC.view];
    [self addChildViewController:chooseDiseaseVC];
    chooseDiseaseVC.collectionView.backgroundColor = [UIColor clearColor];
    

    
    //添加约束
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(margin * 8);
        make.left.equalTo(self.view.mas_left).offset(margin);
    }];
    
    [chooseDiseaseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.width.mas_equalTo(FHScreenSize.width);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.6);
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
