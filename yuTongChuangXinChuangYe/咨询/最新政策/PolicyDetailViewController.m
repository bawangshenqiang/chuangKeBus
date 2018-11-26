//
//  PolicyDetailViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "PolicyDetailViewController.h"
#import <WebKit/WebKit.h>
#import "SearchNumbersDetailBottomView.h"
#import "LoginViewController.h"

@interface PolicyDetailViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView     *webView;

@property(strong, nonatomic)UIProgressView *progressView;
@property(nonatomic,strong)SearchNumbersDetailBottomView *bottomView;
@property(nonatomic,assign)BOOL collected;
@property(nonatomic,assign)int collects;//收藏数

@property(nonatomic,strong)CustomSharedView *sharedView;
@property(nonatomic,strong)NSString *shareUrl;
@property(nonatomic,strong)NSString *shareTitle;
@property(nonatomic,strong)NSString *shareContent;
@end

@implementation PolicyDetailViewController


-(void)getUrlData:(NSString *)url{
    NSString *path = url;//@"https://www.jianshu.com/p/f31e39d3ce41"
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [self.webView loadRequest:request];
    self.shareUrl=url;
    if ([self.shareUrl containsString:@"app"]) {
        self.shareUrl=[self.shareUrl stringByReplacingOccurrencesOfString:@"app" withString:@"detail"];
    }
}
-(void)getData{
    
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]!=nil) {
        user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"policyId":@(self.policyId)};
    [TDHttpTools policyDeatilWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            self.shareTitle=dic[@"data"][@"title"];
            self.shareContent=dic[@"data"][@"description"];
            
            [self getUrlData:dic[@"data"][@"url"]];
            self.collected=[dic[@"data"][@"collected"] boolValue];
            [self.bottomView.praiseBtn setSelected:self.collected];
            self.collects=[dic[@"data"][@"collects"] intValue];
            self.bottomView.countLab.text=[NSString stringWithFormat:@"%d",self.collects];
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    self.title=@"政策";
    
    self.shareTitle=@"";
    self.shareContent=@"";
    self.shareUrl=@"";
    
    
    [self initView];
    
    [self getData];
}

- (void)initView{
    
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.progressView];
    
    self.bottomView=[[SearchNumbersDetailBottomView alloc]initWithFrame:CGRectMake(0, kTableViewHeight-50, kScreenWidth, 50)];
    [self.bottomView.praiseBtn setImage:[UIImage imageNamed:@"systemhall_collect"] forState:UIControlStateNormal];
    [self.bottomView.praiseBtn setImage:[UIImage imageNamed:@"systemhall_collect_nor"] forState:UIControlStateSelected];
    self.bottomView.interestBtn.hidden=YES;
    [self.view addSubview:self.bottomView];
    WS(weakSelf);
    //实际是收藏按钮
    [self.bottomView setPraiseBtnBlock:^{
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            [weakSelf collectAPolicy];
        }
    }];
    
    [self.bottomView setSharedBtnBlock:^{
        weakSelf.sharedView=[[CustomSharedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
        weakSelf.sharedView.url=weakSelf.shareUrl;
        weakSelf.sharedView.title=weakSelf.shareTitle;
        weakSelf.sharedView.content=weakSelf.shareContent;
    }];
}
-(void)collectAPolicy{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"policyId":@(self.policyId)};
    [TDHttpTools collectPolicyWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            self.bottomView.praiseBtn.selected=!self.bottomView.praiseBtn.isSelected;
            int count=[self.bottomView.countLab.text intValue];
            if (self.bottomView.praiseBtn.isSelected) {
                self.bottomView.countLab.text=[NSString stringWithFormat:@"%d",count+1];
            }else{
                if (count>0) {
                    self.bottomView.countLab.text=[NSString stringWithFormat:@"%d",count-1];
                }
            }
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight-50) configuration:configuration];
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
