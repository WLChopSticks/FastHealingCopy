//
//  FHResetPasswordViewController.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHResetPasswordViewController.h"
#import "UITextField+Extension.h"

@interface FHResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation FHResetPasswordViewController
- (IBAction)saveBtnClick {
    FHLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.accountField setLeftViewWithImageName:@"shouji"];
    [self.pwdField setLeftViewWithImageName:@"login_verification"];
    
    [self.pwdField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self valueChange];
}

- (void)valueChange{
    self.saveBtn.enabled = self.accountField.text.length > 0 && self.pwdField.text.length > 0;
}



@end
