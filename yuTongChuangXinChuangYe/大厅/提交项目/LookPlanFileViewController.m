//
//  LookPlanFileViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "LookPlanFileViewController.h"

@interface LookPlanFileViewController ()
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation LookPlanFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.filePath]]];
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight)];
        _webView.scalesPageToFit=YES;
        [self.view addSubview:_webView];
    }
    return _webView;
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
