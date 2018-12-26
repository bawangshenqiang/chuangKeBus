//
//  HuaShanDetailViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HuaShanDetailViewController.h"
#import "HuaShanDetailBottomHeaderView.h"
#import <WebKit/WebKit.h>
#import "CommentModel_video.h"
#import "CommentCell_video.h"
#import "CommentBottomView.h"
#import "LoginViewController.h"
#import "PublishThemeViewController.h"

@interface HuaShanDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,
WKNavigationDelegate>

@property (nonatomic, strong) WKWebView     *webView;

@property (nonatomic, strong) UITableView   *tableView;

@property (nonatomic, strong) UIScrollView  *containerScrollView;

@property (nonatomic, strong) UIView        *contentView;

@property(strong, nonatomic)UIProgressView *progressView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)CommentBottomView *bottomView;
@property(nonatomic,strong)HuaShanDetailBottomHeaderView *headerView;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)BOOL praised;
@property(nonatomic,assign)int praises;//点赞数
@property(nonatomic,assign)BOOL collected;
@property(nonatomic,assign)int collects;//收藏数
@property(nonatomic,assign)int commentsize;//评论数
@property(nonatomic,assign)BOOL editable;//是否可编辑
@property(nonatomic,strong)UIButton *loadMoreBtn;

@property(nonatomic,strong)CustomSharedView *sharedView;
@property(nonatomic,strong)NSString *shareUrl;
@property(nonatomic,strong)NSString *shareTitle;
@property(nonatomic,strong)NSString *shareContent;
@end

@implementation HuaShanDetailViewController{
    CGFloat _lastWebViewContentHeight;
    CGFloat _lastTableViewContentHeight;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
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
//-(void)getData{
//
//    //
//    NSArray *arr=@[@{@"create_time":@"10:20:52",@"photo":@"",@"nickname":@"昵称1",@"detail":@"老师讲的真不错，细节知识点条理分明"},@{@"create_time":@"10:20:52",@"photo":@"",@"nickname":@"昵称2",@"detail":@"老师讲的真不错，细节知识点条理分明老师讲的真不错，细节知识点条理分明"},@{@"create_time":@"10:20:52",@"photo":@"",@"nickname":@"昵称3",@"detail":@"老师讲的真不错，细节知识点条理分明"},@{@"create_time":@"10:20:52",@"photo":@"",@"nickname":@"昵称4",@"detail":@"老师讲的真不错，细节知识点条理分明老师讲的真不错，细节知识点条理分明老师讲的真不错，细节知识点条理分明老师讲的真不错，细节知识点条理分明老师讲的真不错，细节知识点条理分明"},@{@"create_time":@"10:20:52",@"photo":@"",@"nickname":@"昵称5",@"detail":@"老师讲的真不错，细节知识点条理分明老师讲的真不错，细节知识点条理分明"},@{@"create_time":@"10:20:52",@"photo":@"",@"nickname":@"昵称6",@"detail":@"老师讲的真不错，细节知识点条理分明"}];
//    for (NSDictionary *dic in arr) {
//        CommentModel_video *model=[[CommentModel_video alloc]initWithDictionary:dic];
//        [self.dataArr addObject:model];
//    }
//    [self.tableView reloadData];
//}
-(void)refreshCommentTableView{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]!=nil) {
        user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"postId":@(self.postId),@"size":@(10),@"page":@(_page)};
    [TDHttpTools postDeatilWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataArr removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            self.shareTitle=dic[@"data"][@"title"];
            self.shareContent=dic[@"data"][@"description"];
            
            //[self getUrlData:dic[@"data"][@"url"]];
            self.praised=[dic[@"data"][@"praised"] boolValue];
            self.collected=[dic[@"data"][@"collected"] boolValue];
            [self.headerView.praiseBtn setSelected:self.praised];
            [self.headerView.collectBtn setSelected:self.collected];
            self.praises=[dic[@"data"][@"praises"] intValue];
            self.commentsize=[dic[@"data"][@"commentsize"] intValue];
            self.collects=[dic[@"data"][@"collects"] intValue];
            self.headerView.praiseLab.text=[NSString stringWithFormat:@"%d",self.praises];
            self.headerView.collectLab.text=[NSString stringWithFormat:@"%d",self.collects];
            self.headerView.commentLab.text=[NSString stringWithFormat:@"%d",self.commentsize];
            self.editable=[dic[@"data"][@"editable"] boolValue];
            if (self.editable) {
                self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
            }else{
                self.navigationItem.rightBarButtonItem=nil;
            }
            for (NSDictionary *dict in dic[@"data"][@"comments"][@"records"]) {
                CommentModel_video *model=[[CommentModel_video alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)getNewData{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]!=nil) {
        user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"postId":@(self.postId),@"size":@(10),@"page":@(_page)};
    [TDHttpTools postDeatilWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataArr removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            self.shareTitle=dic[@"data"][@"title"];
            self.shareContent=dic[@"data"][@"description"];
            
            [self getUrlData:dic[@"data"][@"url"]];
            self.praised=[dic[@"data"][@"praised"] boolValue];
            self.collected=[dic[@"data"][@"collected"] boolValue];
            [self.headerView.praiseBtn setSelected:self.praised];
            [self.headerView.collectBtn setSelected:self.collected];
            self.praises=[dic[@"data"][@"praises"] intValue];
            self.commentsize=[dic[@"data"][@"commentsize"] intValue];
            self.collects=[dic[@"data"][@"collects"] intValue];
            self.headerView.praiseLab.text=[NSString stringWithFormat:@"%d",self.praises];
            self.headerView.collectLab.text=[NSString stringWithFormat:@"%d",self.collects];
            self.headerView.commentLab.text=[NSString stringWithFormat:@"%d",self.commentsize];
            self.editable=[dic[@"data"][@"editable"] boolValue];
            if (self.editable) {
                self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
            }else{
                self.navigationItem.rightBarButtonItem=nil;
            }
            for (NSDictionary *dict in dic[@"data"][@"comments"][@"records"]) {
                CommentModel_video *model=[[CommentModel_video alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)getMoreData{
    _page=_page+1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]!=nil) {
        user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"postId":@(self.postId),@"size":@(10),@"page":@(_page)};
    [TDHttpTools postDeatilWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            NSArray *arr=dic[@"data"][@"comments"][@"records"];
            if (arr.count>0) {
                for (NSDictionary *dict in arr) {
                    CommentModel_video *model=[[CommentModel_video alloc]initWithDictionary:dict];
                    [self.dataArr addObject:model];
                }
            }else{
                [self.loadMoreBtn setTitle:@"已经到底了" forState:UIControlStateNormal];
                [self.tableView.mj_footer endRefreshing];
                return ;
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        });
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
    self.title=@"帖子详情";
    
    self.shareTitle=@"";
    self.shareContent=@"";
    self.shareUrl=@"";
    
    [self initValue];
    [self initView];
    [self addObservers];
    
    
    [self initCommentBottomView];
    
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewData];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
}
//修改
-(void)rightBarClick{
    PublishThemeViewController *publishVC=[PublishThemeViewController new];
    publishVC.isRevise=YES;
    publishVC.postId=(int)self.postId;
    [self.navigationController pushViewController:publishVC animated:YES];
}
-(void)initCommentBottomView{
    self.bottomView=[[CommentBottomView alloc]initWithFrame:CGRectMake(0, kTableViewHeight-60, kScreenWidth, 60)];
    [self.view addSubview:self.bottomView];
    WS(weakSelf);
    [self.bottomView setSubmitBtnBlock:^(NSString *string){
        NSLog(@"发表的内容:%@",string);
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            [weakSelf commentAPost:string];
            
        }
    }];
}
-(void)commentAPost:(NSString *)string{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"postId":@(self.postId),@"comment":string};
    [TDHttpTools commentPostWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            //[self getNewData];
            [self refreshCommentTableView];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)praiseAPost{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"postId":@(self.postId)};
    [TDHttpTools praisePostWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            self.headerView.praiseBtn.selected=!self.headerView.praiseBtn.isSelected;
            int count=[self.headerView.praiseLab.text intValue];
            if (self.headerView.praiseBtn.isSelected) {
                self.headerView.praiseLab.text=[NSString stringWithFormat:@"%d",count+1];
            }else{
                if (count>0) {
                    self.headerView.praiseLab.text=[NSString stringWithFormat:@"%d",count-1];
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
-(void)collectAPost{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"postId":@(self.postId)};
    [TDHttpTools collectPostWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            self.headerView.collectBtn.selected=!self.headerView.collectBtn.isSelected;
            int count=[self.headerView.collectLab.text intValue];
            if (self.headerView.collectBtn.isSelected) {
                self.headerView.collectLab.text=[NSString stringWithFormat:@"%d",count+1];
            }else{
                if (count>0) {
                    self.headerView.collectLab.text=[NSString stringWithFormat:@"%d",count-1];
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
- (void)initValue{
    _lastWebViewContentHeight = 0;
    _lastTableViewContentHeight = 0;
}

- (void)initView{
    [self.contentView addSubview:self.webView];
    [self.contentView addSubview:self.tableView];
    
    [self.view addSubview:self.containerScrollView];
    [self.containerScrollView addSubview:self.contentView];
    
    self.contentView.frame = CGRectMake(0, 0, self.view.width, kTableViewHeight * 2);
    self.webView.top = 0;
    self.webView.height = kTableViewHeight;
    self.tableView.top = self.webView.bottom;
    
    [self.view addSubview:self.progressView];
}


#pragma mark - Observers
- (void)addObservers{
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == _webView) {
        if ([keyPath isEqualToString:@"scrollView.contentSize"]) {
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
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
    }else if(object == _tableView) {
        if ([keyPath isEqualToString:@"contentSize"]) {
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }
}

- (void)updateContainerScrollViewContentSize:(NSInteger)flag webViewContentHeight:(CGFloat)inWebViewContentHeight{
    
    CGFloat webViewContentHeight = flag==1 ?inWebViewContentHeight :self.webView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    
    if (webViewContentHeight == _lastWebViewContentHeight && tableViewContentHeight == _lastTableViewContentHeight) {
        return;
    }
    
    _lastWebViewContentHeight = webViewContentHeight;
    _lastTableViewContentHeight = tableViewContentHeight;
    
    self.containerScrollView.contentSize = CGSizeMake(self.view.width, webViewContentHeight + tableViewContentHeight);
    
    CGFloat webViewHeight = (webViewContentHeight < kTableViewHeight) ?webViewContentHeight :kTableViewHeight ;
    CGFloat tableViewHeight = tableViewContentHeight < kTableViewHeight ?tableViewContentHeight :kTableViewHeight;
    self.webView.height = webViewHeight <= 0.1 ?0.1 :webViewHeight;
    self.contentView.height = webViewHeight + tableViewHeight;
    self.tableView.height = tableViewHeight;
    self.tableView.top = self.webView.bottom;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_containerScrollView != scrollView) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat webViewHeight = self.webView.height;
    CGFloat tableViewHeight = self.tableView.height;
    
    CGFloat webViewContentHeight = self.webView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    
    if (offsetY <= 0) {
        self.contentView.top = 0;
        self.webView.scrollView.contentOffset = CGPointZero;
        self.tableView.contentOffset = CGPointZero;
    }else if(offsetY < webViewContentHeight - webViewHeight){
        self.contentView.top = offsetY;
        self.webView.scrollView.contentOffset = CGPointMake(0, offsetY);
        self.tableView.contentOffset = CGPointZero;
    }else if(offsetY < webViewContentHeight){
        self.contentView.top = webViewContentHeight - webViewHeight;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.tableView.contentOffset = CGPointZero;
    }else if(offsetY < webViewContentHeight + tableViewContentHeight - tableViewHeight){
        self.contentView.top = offsetY - webViewHeight;
        self.tableView.contentOffset = CGPointMake(0, offsetY - webViewContentHeight);
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
    }else if(offsetY <= webViewContentHeight + tableViewContentHeight ){
        self.contentView.top = self.containerScrollView.contentSize.height - self.contentView.height;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.tableView.contentOffset = CGPointMake(0, tableViewContentHeight - tableViewHeight);
    }else {
        //do nothing
        NSLog(@"do nothing");
    }
}

#pragma mark - UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel_video *model=self.dataArr[indexPath.row];
    CGFloat height;
    height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CommentCell_video class] contentViewWidth:kScreenWidth];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID=@"cellid4";
    CommentCell_video *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[CommentCell_video alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.model=self.dataArr[indexPath.row];
    if (indexPath.row==self.dataArr.count-1) {
        cell.line.hidden=YES;
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, kScreenWidth, 30);
    [btn setTitle:@"加载更多" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    btn.backgroundColor=kBackgroundColor;
    [btn addTarget:self action:@selector(loadMoreData) forControlEvents:UIControlEventTouchUpInside];
    self.loadMoreBtn=btn;
    if (self.dataArr.count==0) {
        [self.loadMoreBtn setTitle:@"暂无评论内容" forState:UIControlStateNormal];
    }else if (self.dataArr.count<10){
        [self.loadMoreBtn setTitle:@"没有更多了" forState:UIControlStateNormal];
    }
    return btn;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    header.backgroundColor=kBackgroundColor;
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 30)];
    lab.text=@"全部评论";
    lab.font=[UIFont systemFontOfSize:13];
    lab.textColor=[UIColor colorWithHexString:@"#989898"];
    [header addSubview:lab];
//    UIButton *sort=[UIButton buttonWithType:UIButtonTypeCustom];
//    sort.frame=CGRectMake(kScreenWidth-85, 5, 70, 20);
//    sort.titleLabel.font=[UIFont systemFontOfSize:13];
//    [sort setTitle:@"时间正序" forState:UIControlStateNormal];
//    [sort setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
//    [sort setTitle:@"时间倒序" forState:UIControlStateSelected];
//    [sort setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateSelected];
//    [sort setImage:[UIImage imageNamed:@"project_preface"] forState:UIControlStateNormal];
//    [sort setImage:[UIImage imageNamed:@"project_reverseorder"] forState:UIControlStateSelected];
//    [sort addTarget:self action:@selector(sortData:) forControlEvents:UIControlEventTouchUpInside];
//    [header addSubview:sort];
    
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
//排序
-(void)sortData:(UIButton *)btn{
    btn.selected=!btn.isSelected;
    
}
//加载更多
-(void)loadMoreData{
    [self getMoreData];
}
#pragma mark - private
- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    
    return _webView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView=[self tableHeader];
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}

-(UIView *)tableHeader{
    HuaShanDetailBottomHeaderView *header=[[HuaShanDetailBottomHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.headerView=header;
    WS(weakSelf);
    [header setPraiseBtnBlock:^{
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            [weakSelf praiseAPost];
        }
    }];
    [header setCollectBtnBlock:^{
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            if (!self.editable) {
                [weakSelf collectAPost];
            }else{
                [SJTool showAlertWithText:@"自己发的帖子不能收藏"];
            }
        }
    }];
    [header setCommentBtnBlock:^{
        [weakSelf.bottomView.textView becomeFirstResponder];
    }];
    [header setSharedBtnBlock:^{
        weakSelf.sharedView=[[CustomSharedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
        weakSelf.sharedView.url=weakSelf.shareUrl;
        weakSelf.sharedView.title=weakSelf.shareTitle;
        weakSelf.sharedView.content=weakSelf.shareContent;
    }];
    return header;
}

- (UIScrollView *)containerScrollView{
    if (_containerScrollView == nil) {
        _containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight-60)];
        _containerScrollView.delegate = self;
        _containerScrollView.alwaysBounceVertical = YES;
    }
    
    return _containerScrollView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    
    return _contentView;
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

//键盘变化，移动UIView
-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    //NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    if (deltaY<0) {
        [UIView animateWithDuration:0.25f animations:^{
            [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY+SafeAreaBottomHeight, self.view.frame.size.width, self.view.frame.size.height)];
        }];
    }else{
        [UIView animateWithDuration:0.25f animations:^{
            [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY-(SafeAreaBottomHeight), self.view.frame.size.width, self.view.frame.size.height)];
        }];
    }
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObservers];
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
