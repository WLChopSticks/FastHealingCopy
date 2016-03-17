//
//  FHHeaderView.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHHeaderView.h"
#import "SVProgressHUD.h"

@interface FHHeaderView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *lablesTR;


@end

@implementation FHHeaderView

+ (UIView *)headerView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    self.textView.delegate = self;
    self.textView.text = @"请输入";
    self.textView.textColor = [UIColor darkGrayColor];

    self.lablesTR.text = @"您还可以输入200个字";
    
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc]initWithString:self.lablesTR.text];
    NSRange range = [[hintString string] rangeOfString:@"200"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    self.lablesTR.attributedText = hintString;
}


- (IBAction)sendBtn:(id)sender {
    [self endEditing:YES];
    
    [SVProgressHUD showWithStatus:@"提交中" maskType:SVProgressHUDMaskTypeBlack];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        NSLog(@"%lu",(unsigned long)self.textView.text.length);
        if (self.textView.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入文字!"];
            return ;
        }
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    });

    
    
}



//开始编辑的时候
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (textView.tag == 0) {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
    
    return YES;
}


//textView应该改变的时候
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"%zd",range.location);
    
    
    if (range.location >= 200) {
        textView.tag = 1;
        
        return NO;
    }

    self.lablesTR.text = [NSString stringWithFormat:@"您还可以输入%zd个字", 200 - range.location];
    
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc]initWithString:self.lablesTR.text];
    NSString *str = [NSString stringWithFormat:@"%zd",200 - range.location];
    NSRange ranges = [[hintString string] rangeOfString:str];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:ranges];
    
    self.lablesTR.attributedText = hintString;
    
    return  YES;
}






@end
