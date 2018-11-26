//
//  SystemMessageDetailViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SystemMessageDetailViewController.h"

@interface SystemMessageDetailViewController ()

@end

@implementation SystemMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    [self.view addSubview:webView];
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
