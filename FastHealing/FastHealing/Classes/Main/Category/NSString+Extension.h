//
//  NSString+Extension.h
//  My-Microblog
//
//  Created by 王 on 15/12/07.
//  Copyright © 2015年 王. All rights reserved.


#import <UIKit/UIKit.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
@end
