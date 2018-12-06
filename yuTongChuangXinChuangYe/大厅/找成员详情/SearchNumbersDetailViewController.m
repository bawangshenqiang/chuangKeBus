//
//  SearchNumbersDetailViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SearchNumbersDetailViewController.h"
#import <WebKit/WebKit.h>
#import "SearchNumbersDetailBottomView.h"
#import "SearchNumbersViewController.h"
#import "LoginViewController.h"
#import "CaredMemberViewController.h"

@interface SearchNumbersDetailViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView     *webView;

@property(strong, nonatomic)UIProgressView *progressView;
@property(nonatomic,strong)SearchNumbersDetailBottomView *bottomView;
@property(nonatomic,assign)BOOL praised;
@property(nonatomic,assign)int praises;//点赞数
@property(nonatomic,assign)BOOL cared;
@property(nonatomic,assign)int cares;//感兴趣
@property(nonatomic,assign)BOOL editable;//是否可编辑

@property(nonatomic,strong)CustomSharedView *sharedView;
@property(nonatomic,strong)NSString *shareUrl;
@property(nonatomic,strong)NSString *shareTitle;
@property(nonatomic,strong)NSString *shareContent;
@end

@implementation SearchNumbersDetailViewController

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
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"teamId":@(self.Id)};
    [TDHttpTools teamDeatilWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            
            self.shareTitle=dic[@"data"][@"title"];
            self.shareContent=dic[@"data"][@"description"];
            
            [self getUrlData:dic[@"data"][@"url"]];
            self.praised=[dic[@"data"][@"praised"] boolValue];
            [self.bottomView.praiseBtn setSelected:self.praised];
            self.praises=[dic[@"data"][@"praises"] intValue];
            self.bottomView.countLab.text=[NSString stringWithFormat:@"%d",self.praises];
            self.cared=[dic[@"data"][@"cared"] boolValue];
            [self.bottomView.interestBtn setSelected:self.cared];
            self.cares=[dic[@"data"][@"cares"] intValue];
            self.bottomView.interestLab.text=[NSString stringWithFormat:@"%d",self.cares];
            self.editable=[dic[@"data"][@"editable"] boolValue];
            if (self.editable) {
                self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
                self.bottomView.interestBtn.userInteractionEnabled=NO;
            }else{
                self.navigationItem.rightBarButtonItem=nil;
                self.bottomView.interestBtn.userInteractionEnabled=YES;
            }
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
    self.title=@"找成员";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
    self.shareTitle=@"";
    self.shareContent=@"";
    self.shareUrl=@"";
    
    [self initView];
    
    [self getData];
}
//修改
-(void)rightBarClick{
    SearchNumbersViewController *searchVC=[SearchNumbersViewController new];
    searchVC.isRevise=YES;
    searchVC.teamId=(int)self.Id;
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)initView{
    
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.progressView];
    
    self.bottomView=[[SearchNumbersDetailBottomView alloc]initWithFrame:CGRectMake(0, kTableViewHeight-50, kScreenWidth, 50)];
    [self.view addSubview:self.bottomView];
    WS(weakSelf);
    [self.bottomView setPraiseBtnBlock:^{
        NSLog(@"点赞");
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            [weakSelf praiseATeam];
        }
    }];
    [self.bottomView setInterestBtnBlock:^{
        NSLog(@"感兴趣");
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            CaredMemberViewController *caredVC=[CaredMemberViewController new];
            caredVC.Id=weakSelf.Id;
            UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:caredVC];
            [caredVC setCallBackBlock:^{
                if (weakSelf.bottomView.interestBtn.isSelected==NO) {
                    weakSelf.bottomView.interestBtn.selected=YES;
                    int count=[weakSelf.bottomView.interestLab.text intValue];
                    weakSelf.bottomView.interestLab.text=[NSString stringWithFormat:@"%d",count+1];
                }
            }];
            [weakSelf presentViewController:navi animated:YES completion:nil];
            //[weakSelf caredATeam];
        }
    }];
    [self.bottomView setSharedBtnBlock:^{
        weakSelf.sharedView=[[CustomSharedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
        weakSelf.sharedView.url=weakSelf.shareUrl;
        weakSelf.sharedView.title=weakSelf.shareTitle;
        weakSelf.sharedView.content=weakSelf.shareContent;
    }];
}
-(void)praiseATeam{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"findTeamUserId":@(self.Id)};
    [TDHttpTools praiseFindTeamWithParams:param success:^(id response) {
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
-(void)caredATeam{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"findTeamUserId":@(self.Id)};
    [TDHttpTools caredFindTeamWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            if (self.bottomView.interestBtn.isSelected==NO) {
                self.bottomView.interestBtn.selected=YES;
                int count=[self.bottomView.interestLab.text intValue];
                self.bottomView.interestLab.text=[NSString stringWithFormat:@"%d",count+1];
            }
//            self.bottomView.interestBtn.selected=!self.bottomView.interestBtn.isSelected;
//            int count=[self.bottomView.interestLab.text intValue];
//            if (self.bottomView.interestBtn.isSelected) {
//                self.bottomView.interestLab.text=[NSString stringWithFormat:@"%d",count+1];
//            }else{
//                if (count>0) {
//                    self.bottomView.interestLab.text=[NSString stringWithFormat:@"%d",count-1];
//                }
//            }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
