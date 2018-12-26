//
//  AuditingLookDetailViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "AuditingLookDetailViewController.h"

#import <WebKit/WebKit.h>
@interface AuditingLookDetailViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView     *webView;

@property(strong, nonatomic)UIProgressView *progressView;

@end

@implementation AuditingLookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"预览";
    [self initView];
}
- (void)initView{
    
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.progressView];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [self.webView loadRequest:request];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == _webView) {
        
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            if (newprogress == 1) {
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            }else {
                self.progressView.hidden = NO;
                [self.progressView setProgress:newprogress animated:YES];
            }
        }
    }
}

#pragma mark - private
- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) configuration:configuration];
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    
    return _webView;
}

- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        self.progressView.tintColor = [UIColor orangeColor];
        self.progressView.trackTintColor = [UIColor whiteColor];
        
    }
    return _progressView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
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
