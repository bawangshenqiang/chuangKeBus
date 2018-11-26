//
//  IntroduceWebviewCell_video.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "IntroduceWebviewCell_video.h"

@implementation IntroduceWebviewCell_video
-(void)setModel:(IntroduceWebviewModel *)model{
    _model=model;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.urlString]]];//@"http://118.25.54.108/provider/app/2"//_model.urlString
    //NSLog(@"_model.url:%@",_model.urlString);
}
-(WKWebView *)webView{
    if (!_webView) {
        _webView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _webView.backgroundColor=kBackgroundColor;
        _webView.scrollView.scrollEnabled=NO;
        _webView.navigationDelegate=self;
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        [self.contentView addSubview:_webView];
    }
    return _webView;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //WS(weakSelf);
    [webView evaluateJavaScript:@"document.documentElement.scrollHeight" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        //经过测试，发现高度差了16
        CGFloat height = heightStr.floatValue+16;
        NSLog(@"height====%f",height);
        if (height != _model.cellHeight) {
            
            _model.cellHeight = height;
            
            if (_model.cellHeight > 0) {
                
                self.webView.frame=CGRectMake(0, 0, kScreenWidth, height);
                NSLog(@"_model.cellHeight====%f",_model.cellHeight);
                // 刷新cell高度
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeHeight" object:nil];
            }
            
        }
    }];
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyAllow);
    }else {
        
        //如果是跳转一个新页面
        if (navigationAction.targetFrame == nil) {
            [webView loadRequest:navigationAction.request];
            
        }
        
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    // 获取内容高度
//    CGFloat height =  [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] intValue];//document.documentElement.scrollHeight
//    NSLog(@"height====%f",height);
//    // 防止死循环
//    if (height != _model.cellHeight) {
//
//        _model.cellHeight = height;
//
//        if (_model.cellHeight > 0) {
//
//            self.webView.frame=CGRectMake(0, 0, kScreenWidth, height);
//            NSLog(@"_model.cellHeight====%f",_model.cellHeight);
//            // 刷新cell高度
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeHeight" object:nil];
//        }
//
//    }
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
