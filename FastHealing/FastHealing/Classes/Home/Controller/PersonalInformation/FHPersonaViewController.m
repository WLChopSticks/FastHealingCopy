//
//  FHPersonaViewController.m
//  FastHealing
//
//  Created by 王 on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "UIView+Extension.h"
#import "FHPersonaViewController.h"
#import "Masonry.h"
#import "FHBlackView.h"
#import "FHWeatherPositionViewController.h"
#import "UIImageView+WebCache.h"
#import "HTFPopupWindow.h"
#import "FHUserViewModel.h"
#import "FHUser.h"
//除导航栏高德height
#define HEIGTH_WITHOUT_BAR (FHScreenSize.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))
//各个VIew 的高度比例
#define HEADER_HEIGHT_SCALE 1/6.0

#define MIDDLE_HEIGHT_SCALE 1/4.0

@interface FHPersonaViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, weak) UIView *headerView;//头像行
@property (nonatomic, weak) UIImageView *header;//头像
@property (nonatomic, weak) UITableView  *middleView;//tabView
@property (nonatomic, weak) UIView *bottomView;//下部text

@property (nonatomic, assign) NSInteger selectIndex;//选中的Cell
@property (nonatomic, weak) UIView *blackView;//蒙板
@property (nonatomic, weak) HTFPopupWindow *pickerView;//选择更改器
@property (nonatomic, weak) UIImageView *personGender;//性别Image

@property (nonatomic, assign) NSInteger firstNum;
@property (nonatomic, assign) NSInteger secondNum;
@property (nonatomic, assign) NSInteger threeNum;
@end

@implementation FHPersonaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0  blue:246/255.0  alpha:1];
    [self setupUI];
    
    self.title = @"个人信息";
    self.middleView.dataSource = self;
    self.middleView.delegate = self;
    [self setNav];

    [ FHNotificationCenter addObserver:self selector:@selector(requestBackCity:) name:@"setPosition" object:nil];

    
}
- (void)setNav{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [button setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(didBack) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)didBack{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil];
}

- (void)setupUI{

    [self creatchildrensView];
    
    //设置布局
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(CGRectGetMaxY(self.navigationController.navigationBar.frame));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.offset(HEIGTH_WITHOUT_BAR * HEADER_HEIGHT_SCALE);
        
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.offset( HEIGTH_WITHOUT_BAR * MIDDLE_HEIGHT_SCALE);
//        make.height.offset(self.middleView.height);
        
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    [self creatHeaderChildsView];
    
    [self creatBottomchildView];
    
    
    
}
#pragma mark creat child View
- (void)creatchildrensView{
    
    //创建头部
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.headerView = view;
    [self.view addSubview:view];
    //添加Cell
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = [UIColor whiteColor];
    
    tableView.scrollEnabled = NO;
    
    tableView.height = tableView.rowHeight * 3;
    
    self.middleView = tableView;
    self.middleView.height = tableView.height ;
    
    [self.view addSubview:tableView];
    
    //添加底部View
    UIView *bottom = [[UIView alloc] init];
    
    self.bottomView = bottom;
    
    self.bottomView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0  blue:246/255.0  alpha:1];;
    
    [self.view addSubview:bottom];
}
//创建headerView的子视图
- (void)creatHeaderChildsView{

    FHUser *user = [FHUserViewModel shareUserModel].user;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headerView.mas_top).offset(10);
        
        make.left.equalTo(self.headerView.mas_left).offset(10);
        
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-10);
        
        make.width.multipliedBy(1).equalTo(self.header.mas_height);
        
    }];
    [self.header sd_setImageWithURL:[NSURL URLWithString:user.head_photo] placeholderImage:[UIImage imageNamed:@"02"]];
    self.header.layer.cornerRadius = (HEIGTH_WITHOUT_BAR * HEADER_HEIGHT_SCALE - 20) * 0.5;
    self.header.layer.masksToBounds = NO;
    //性别
    [self.personGender mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.header.mas_top);
        
        make.left.equalTo(self.header.mas_right).offset(10);
        
        make.width.multipliedBy(1).equalTo(self.personGender.mas_height);
        
    }];
    
    UILabel *personLable = [self creatLableText:user.true_name ? user.true_name  : @"XXX" withFont:13.0 addedView:self.headerView];
    
    [personLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.personGender.mas_right).offset(10);
        
        make.centerY.equalTo(self.personGender.mas_centerY);
        
        make.right.equalTo(self.headerView.mas_right).offset(-20);
        
        make.height.equalTo(self.personGender.mas_height);
        
    }];
    
    UIImageView *idcard = [self creatImageViewWithImageName:@"login_idcard" andAddedView:self.headerView];
    
    [idcard mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.personGender.mas_bottom).offset(10);
        
        make.left.equalTo(self.header.mas_right).offset(10);
        
        make.width.multipliedBy(1).equalTo(self.personGender.mas_height);
        
        make.height.multipliedBy(1).equalTo(self.personGender.mas_height);
        
        
    }];
    
    UILabel *idcardLable = [self creatLableText:user.card_number ? user.card_number  : @"XXXXXX********XXXX"  withFont:13.0 addedView:self.headerView];
    
    [idcardLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(idcard.mas_right).offset(10);
        
        make.centerY.equalTo(idcard.mas_centerY);
        
        make.right.equalTo(self.headerView.mas_right).offset(-20);
        
        make.height.equalTo(self.personGender.mas_height);
        
    }];
    
    UIImageView *phone = [self creatImageViewWithImageName:@"shouji" andAddedView:self.headerView];
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(idcard.mas_bottom).offset(10);
        
        make.left.equalTo(self.header.mas_right).offset(10);
        
        make.height.multipliedBy(1).equalTo(self.personGender.mas_height);
        
        make.width.multipliedBy(1).equalTo(self.personGender.mas_height);
        
        make.bottom.equalTo(self.header.mas_bottom);
        
    }];
    
    UILabel *phoneLable = [self creatLableText:user.mobile_number ? user.mobile_number : @"1**********" withFont:13.0 addedView:self.headerView];
    
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(phone.mas_right).offset(10);
        
        make.centerY.equalTo(phone.mas_centerY);
        
        make.right.equalTo(self.headerView.mas_right).offset(-20);
        
        make.height.equalTo(self.personGender.mas_height);
        
    }];

    
}

- (UIImageView *)header{
    
    if (_header == nil) {
       _header = [self creatImageViewWithImageName:@"doctor_default" andAddedView:self.headerView];
    }
    return _header;
}
- (UIImageView *)personGender{
    
    if (_personGender == nil) {
        
        NSString *gender = @"login_boy";
        if ([[FHUserViewModel shareUserModel].user.gender isEqualToString:@"1"]) {
        }else{
            gender = @"login_girl";
        }
        _personGender = [self creatImageViewWithImageName: gender andAddedView:self.headerView];
    }
    return _personGender;
}

- (void)creatBottomchildView{
  
    UILabel *lableT = [[UILabel alloc] init];
    lableT.text = @"需要修改个人信息";
    lableT.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:lableT];
    lableT.textColor = [UIColor lightGrayColor];
    [lableT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView.mas_centerX);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-150);
        make.height.offset(34);
        make.width.offset(200);
        
    }];
    
    UILabel *lableB = [[UILabel alloc] init];
    lableB.text = @"客服电话:400-633-1113";
    lableB.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:lableB];
    lableB.textColor = [UIColor lightGrayColor];
    [lableB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.bottomView.mas_centerX);
        make.top.equalTo(lableT.mas_bottom);
        make.height.offset(34);
        make.width.offset(200);
    }];

    
}

#pragma mark 自定义创建 UIimageView  和 UIlable
- (UIImageView *)creatImageViewWithImageName:(NSString *)imageName andAddedView:(UIView *)view{
 
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.image = [UIImage imageNamed:imageName];
    
    [view addSubview:imageView];

    return imageView;
}

- (UILabel *)creatLableText:(NSString *)text withFont:(CGFloat)size addedView:(UIView *)view {

    UILabel *lable = [[UILabel alloc] init];
    lable.text = text;
    lable.font = [UIFont systemFontOfSize:size];
    [view addSubview:lable];
    return lable;
}

#pragma mark uitableView  datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button setImage:[UIImage imageNamed:@"login_arrow_right"] forState:UIControlStateNormal];
    cell.accessoryView = button;
    //获取数据
    FHUser *model = [FHUserViewModel shareUserModel].user;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"身高";
            cell.detailTextLabel.text =  [NSString stringWithFormat:@"%@(cm)",(model != nil? model.height : @"0")];
            [button addTarget:self action:@selector(selectHeight) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            cell.textLabel.text = @"体重";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@(kg)",(model != nil ? model.weight : @"0")];
            [button addTarget:self action:@selector(selectWeight) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            cell.textLabel.text = @"省份";
            cell.detailTextLabel.text = model.address ? model.address : @"中国";//@"北京市";
            [button addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row;
}
#pragma mark 弹出框设置
- (void)selectHeight{
    
    [self creatPickerSelectViewWith:@"设置身高(cm)"];
    
}
- (void)selectWeight{
     [self creatPickerSelectViewWith:@"选择体重(kg)"];
}
- (void)selectCity{
    
    FHBlackView *view = [[FHBlackView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    self.blackView = view;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    [view addGestureRecognizer:gesture];
    
    //添加View 替换View
    FHWeatherPositionViewController *positionVC = [[FHWeatherPositionViewController alloc] init];
    positionVC.title = @"中国";
    //添加 父子关系 引用 positionVC 的View
    [self addChildViewController:positionVC];
    
    CGFloat viewW = self.view.width * 4 / 5.0;
    CGFloat viewH = self.view.height * 3/5.0;
    CGFloat viewX = (self.view.width - viewW) / 2.0;
    CGFloat viewY = (self.view.height - viewH) / 2.0;
    
    HTFPopupWindow *positionView = [[HTFPopupWindow alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    positionView.titleLable.text = @"省份选择";
    positionView.middleView = positionVC.view;
    self.pickerView = positionView;
    
    [self.view addSubview:positionView];
    self.pickerView.valueblock = ^(NSInteger tag){
        if (!tag) {
            [self backViewClick];
        }
    };
    
}
//接受返回的城市
- (void)requestBackCity:(NSNotification *)noti{
    
    //更该模型
    [FHUserViewModel shareUserModel].user.address = noti.object;
    //释放
    [self backViewClick];
    //刷新
    [self.middleView reloadData];
}
//pickerView Window
- (void)creatPickerSelectViewWith:(NSString *)title{
    
    FHBlackView *view = [[FHBlackView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    self.blackView = view;
    //为遮罩添加手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    [view addGestureRecognizer:gesture];
    
    CGFloat viewW = self.view.width * 2 / 3.0;
    CGFloat viewH = self.view.height / 3.0;
    CGFloat viewX = (self.view.width - viewW) / 2.0;
    CGFloat viewY = (self.view.height - viewH) / 2.0;
    
    //自定义middleView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    //    picker.backgroundColor = [UIColor blueColor];
    pickerView.tintColor = [UIColor colorWithRed:126/255.0 green:202/255.0 blue:207/255.0 alpha:1];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    
    HTFPopupWindow *selectView  =  [[HTFPopupWindow alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    selectView.middleView = pickerView;
    selectView.titleLable.text = title;
    self.pickerView = selectView;

    [self.view addSubview:selectView];
    
    //按钮点击动作
    self.pickerView.valueblock = ^(NSInteger tag){
        if (tag) {
             NSString *value = [NSString stringWithFormat:@"%ld%ld%ld.0",(long)self.firstNum,(long)self.secondNum,(long)self.threeNum];
            //解决第一个字符是0的时显示
            if (self.firstNum == 0 && self.secondNum != 0) {
              value = [NSString stringWithFormat:@"%ld%ld.0",(long)self.secondNum,(long)self.threeNum];
            }else if (self.firstNum == 0 && self.secondNum == 0 ){
              value = [NSString stringWithFormat:@"%ld.0",(long)self.threeNum];
            }
            if (self.selectIndex == 0) {
                
                [FHUserViewModel shareUserModel].user.height = value;
                
            }else if (self.selectIndex == 1){
            
                [FHUserViewModel shareUserModel].user.weight = value;
            }else{
            
            }
            [self backViewClick];
            
            //刷新数据
             [self.middleView reloadData];
        }else{
            [self backViewClick];
        }
    };
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%ld",(long)row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //2.根据列数给相应label赋值
    if(component == 0)
    {
        self.firstNum = row;
    }
    else if(component == 1)
    {
        self.secondNum = row;
    }
    else{
        self.threeNum = row;
    }
}

//手势方法
- (void)backViewClick{
    
    [self.blackView removeFromSuperview];
    [self.pickerView removeFromSuperview];
    self.pickerView = nil;
    self.blackView = nil;

}



@end
