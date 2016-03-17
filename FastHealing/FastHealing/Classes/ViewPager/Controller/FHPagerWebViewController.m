//
//  FHPagerWebViewController.m
//  FastHealing
//
//  Created by 王 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHPagerWebViewController.h"
#import "UIWebView+AFNetworking.h"

@interface FHPagerWebViewController ()
@end

@implementation FHPagerWebViewController

- (void)loadView {
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门医生";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = (UIWebView *)self.view;
    NSURL *url =[NSURL URLWithString:self.URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request progress:nil success:nil failure:nil];
}


@end
