//
//  VideoDetailViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "VideoDetailViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Head_BusinessCourse.h"
#import "IntroduceCell_video.h"
#import "IntroduceWebviewCell_video.h"
#import "IntroduceWebviewModel.h"
#import "CatalogModel_video.h"
#import "CatalogCell_video.h"
#import "CommentModel_video.h"
#import "CommentCell_video.h"
#import "StarProjectCell_HallFirst.h"
#import "CourseModel_video.h"
#import "CommentBottomView.h"
#import "SJDropdownMenu.h"
#import "StarCourseModel_Serve.h"
#import "LoginViewController.h"

@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SJDropdownMenuDelegate>
@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)AVPlayerViewController *avPlayerVC;
@property(nonatomic,strong)UIButton *playBtn;
/** segment选中标示 */
@property(nonatomic,assign)NSInteger index;
/** 介绍的model */
@property(nonatomic,strong)IntroduceWebviewModel *model;
@property(nonatomic,assign)CGFloat cellHight;

@property(nonatomic,strong)CommentBottomView *commentSubmitView;

@property(nonatomic,strong)SJDropdownMenu *choseStyle;

@property(nonatomic,assign)int page;
/** 视频播放地址 */
@property(nonatomic,strong)NSString *webVideoPath;

@property(nonatomic,strong)CustomSharedView *sharedView;
@property(nonatomic,strong)NSString *shareUrl;
@property(nonatomic,strong)NSString *shareTitle;
@property(nonatomic,strong)NSString *shareContent;

@end

@implementation VideoDetailViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)getData{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]!=nil) {
        user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"courseId":@(self.courseId),@"size":@(1),@"page":@(_page)};
    [TDHttpTools courseDetailWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        //NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            
            self.webVideoPath=dic[@"data"][@"video"];
            
            self.model.urlString=dic[@"data"][@"url"];
            //
            [self.view addSubview:self.tableView];
            
            self.shareUrl=dic[@"data"][@"url"];
            if ([self.shareUrl containsString:@"app"]) {
                self.shareUrl=[self.shareUrl stringByReplacingOccurrencesOfString:@"app" withString:@"detail"];
            }
            self.shareTitle=dic[@"data"][@"title"];
            self.shareContent=dic[@"data"][@"description"];
            
            
            self.avPlayerVC.player=[[AVPlayer alloc]initWithURL:[NSURL URLWithString:self.webVideoPath]];
            [self.avPlayerVC.player play];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
-(void)getNewDataWith:(NSInteger)index{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]!=nil) {
        user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"courseId":@(self.courseId),@"size":@(10),@"page":@(_page)};
    [self.dataArr removeAllObjects];
    [TDHttpTools courseDetailWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            
            self.webVideoPath=dic[@"data"][@"video"];
            
            switch (index) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    for (NSDictionary *dict in dic[@"data"][@"items"]) {
                        CatalogModel_video *model=[[CatalogModel_video alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
                    }
                }
                    break;
                case 2:
                {
                    for (NSDictionary *dict in dic[@"data"][@"comments"][@"records"]) {
                        CommentModel_video *model=[[CommentModel_video alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
                    }
                }
                    break;
                case 3:
                {
                    for (NSDictionary *dict in dic[@"data"][@"relates"]) {
                        StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
                    }
                }
                    break;
                default:
                    break;
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
-(void)getMoreDataWith:(NSInteger)index{
    _page=_page+1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]!=nil) {
        user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"courseId":@(self.courseId),@"size":@(10),@"page":@(_page)};
    
    [TDHttpTools courseDetailWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            
            switch (index) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    [self.dataArr removeAllObjects];
                    for (NSDictionary *dict in dic[@"data"][@"items"]) {
                        CatalogModel_video *model=[[CatalogModel_video alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
                    }
                }
                    break;
                case 2:
                {
                    for (NSDictionary *dict in dic[@"data"][@"comments"][@"records"]) {
                        CommentModel_video *model=[[CommentModel_video alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
                    }
                }
                    break;
                case 3:
                {
                    [self.dataArr removeAllObjects];
                    for (NSDictionary *dict in dic[@"data"][@"relates"]) {
                        StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
                    }
                }
                    break;
                default:
                    break;
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
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];//kBackgroundColor;
    
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHeight) name:@"changeHeight" object:nil];
    
    self.model=[[IntroduceWebviewModel alloc]init];
    self.shareTitle=@"";
    self.shareContent=@"";
    self.shareUrl=@"";
    
    self.avPlayerVC =[[AVPlayerViewController alloc] init];
    
//    NSString *webVideoPath = @"";//http://v.cctv.com/flash/mp4video6/TMS/2011/01/05/cf752b1c12ce452b3040cab2f90bc265_h264818000nero_aac32-1.mp4
//    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
//
//    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
//
//    self.avPlayerVC.player = avPlayer;
    
    //是否显示媒体播放组件,默认为YES
    //self.avPlayerVC.showsPlaybackControls=NO;
    //设置播放器视图大小
    self.avPlayerVC.view.frame = CGRectMake(0, 0, kScreenWidth, 200);
    //特别注意:AVPlayerViewController不能作为局部变量被释放，否则无法播放成功
    //解决1.AVPlayerViewController作为属性
    //解决2:使用addChildViewController，AVPlayerViewController作为子视图控制器
    //[self addChildViewController:avPlayerVC];
    [self.view addSubview:self.avPlayerVC.view];
    
    //返回按钮
    [self initBackBtn];
    //收藏，转发，评论
    [self collectAndOtherBtn];
    
//    //
//    self.playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.playBtn.frame=CGRectMake(0, 0, 30, 30);
//    self.playBtn.center=CGPointMake(self.view.centerX, self.avPlayerVC.view.centerY);
//    [self.playBtn setImage:[UIImage imageNamed:@"introduction_broadcast"] forState:UIControlStateNormal];
//    [self.playBtn addTarget:self action:@selector(startPlay) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.playBtn];
    
    //
    self.header=[[Head_BusinessCourse alloc]init];
    self.header.frame=CGRectMake(0, 200, kScreenWidth, 40);
    self.header.bgColor=kBackgroundColor;
    self.header.selectedIndex=self.index;
    self.header.fixedTitles=@[@"介绍",@"目录",@"评论",@"相关课程"];
    WS(weakSelf);
    [self.header setTopSegmentChangeBlock:^(int index) {
        NSLog(@"index=%d",index);
        
        [weakSelf topHeadSelectClick:index];
    }];
    [self.view addSubview:self.header];
    
    
    
    [self getData];
    
    //评论里的发表按钮
    [self initCommentBottomView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewDataWith:weakSelf.index];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreDataWith:weakSelf.index];
        
    }];
    //[self.tableView.mj_header beginRefreshing];
}
-(void)initBackBtn{
    //
    UIButton *goback=[UIButton buttonWithType:UIButtonTypeCustom];
    goback.frame=CGRectMake(10, kStatusBarHeight+5, 20, 34);
    [goback setImage:[UIImage imageNamed:@"hall_return"] forState:UIControlStateNormal];
    [goback addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goback];
}
-(void)collectAndOtherBtn{
    //
    self.choseStyle=[[SJDropdownMenu alloc]init];
    self.choseStyle.frame=CGRectMake(kScreenWidth-95, kStatusBarHeight+5, 80, 34);
    [self.choseStyle.mainBtn setImage:[UIImage imageNamed:@"course_more"] forState:UIControlStateNormal];
    [self.choseStyle setMenuTitles:@[@"收藏",@"转发",@"评论"] images:@[@"introduction_collect_nor",@"introduction_repost",@"introduction_comment"] rowHeight:40];
    self.choseStyle.delegate = self;
    [self.view addSubview:self.choseStyle];
}
-(void)initCommentBottomView{
    if (self.commentSubmitView==nil) {
        self.commentSubmitView=[[CommentBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight-60-SafeAreaBottomHeight, kScreenWidth, 60)];
        self.commentSubmitView.hidden=YES;
        [self.view addSubview:self.commentSubmitView];
    }else{
        self.commentSubmitView.hidden=NO;
    }
    WS(weakSelf);
    [self.commentSubmitView setSubmitBtnBlock:^(NSString *string){
        //评论
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            [weakSelf commentACourse:string];
        }
    }];
}
-(void)commentACourse:(NSString *)string{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"courseId":@(self.courseId),@"comment":string};
    [TDHttpTools commentCourseWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            [self getNewDataWith:2];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)topHeadSelectClick:(int)index{
    self.index=index;
    if (index==2) {
        self.commentSubmitView.hidden=NO;
        self.tableView.frame=CGRectMake(0, self.header.bottom, kScreenWidth, kScreenHeight-300-SafeAreaBottomHeight);
    }else{
        self.commentSubmitView.hidden=YES;
        self.tableView.frame=CGRectMake(0, self.header.bottom, kScreenWidth, kScreenHeight-240-SafeAreaBottomHeight);
    }
//    if (index!=0) {
//
//    }
    [self getNewDataWith:index];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.bottom, kScreenWidth, kScreenHeight-240-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (self.index==0) {
//        return 2;
//    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.index==0) {
        return 1;
    }
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.index) {
        case 0:
        {
            /**
            if (indexPath.section==0) {
                NSString *cellID=@"cellid1";
                IntroduceCell_video *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell=[[IntroduceCell_video alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                return cell;
            }else{
                NSString *cellID=@"cellid2";
                IntroduceWebviewCell_video *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell=[[IntroduceWebviewCell_video alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.model=self.model;
                }
                
                
                
                return cell;
            }
            */
            
            NSString *cellID=@"cellid2";
            IntroduceWebviewCell_video *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[IntroduceWebviewCell_video alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                cell.model=self.model;
            }
            
            return cell;
        }
            break;
        case 1:
        {
            NSString *cellID=@"cellid3";
            CatalogCell_video *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[CatalogCell_video alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            }
            cell.titleLab.text=[NSString stringWithFormat:@"第%d课时",(int)indexPath.row+1];
            if (self.dataArr.count>0) {
                 cell.model=self.dataArr[indexPath.row];
            }
            
            if (indexPath.row==self.dataArr.count-1) {
                cell.line.hidden=YES;
            }
            return cell;
        }
            break;
        case 2:
        {
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
            break;
        default:
        {
            static NSString *cellId2=@"cellIdentifier2";
            StarProjectCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId2];
            if (!cell) {
                cell=[[StarProjectCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId2];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            if (self.dataArr.count>0) {
                cell.model_serve=self.dataArr[indexPath.row];
            }
            
            return cell;
        }
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.index) {
        case 0:
//            if (indexPath.section==0) {
//                return 60;
//            }else{
//                return self.model.cellHeight;
//            }
            //self.cellHight=self.model.cellHeight;
            NSLog(@"cell height === %f",self.model.cellHeight);
            return self.model.cellHeight;
            break;
        case 1:
            return 45;
            break;
        case 2:
        {
            CommentModel_video *model=self.dataArr[indexPath.row];
            CGFloat height;
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CommentCell_video class] contentViewWidth:kScreenWidth];
            return height;
        }
            break;
        default:
            return 100;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index==1) {
        //[tableView deselectRowAtIndexPath:indexPath animated:YES];
        CatalogModel_video *model=self.dataArr[indexPath.row];
        AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:model.urlString]];
        self.avPlayerVC.player=avPlayer;
        [self.avPlayerVC.player play];
    }else if (self.index==3){
        StarCourseModel_Serve *model=self.dataArr[indexPath.row];
        self.courseId=model.Id;
        [self getData];
        [self getNewDataWith:3];
    }
}
-(void)reloadHeight{
    if (self.index==0) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        //NSLog(@"reloadSections OVER");
    }
}
/** 重点：不加这个的话，webview显示不全 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView && self.index==0) {
        IntroduceWebviewCell_video *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell.webView setNeedsLayout];
    }
}
-(void)startPlay{
    [self.avPlayerVC.player play];
    self.playBtn.hidden=YES;
}
-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (self.index==0 && section==0) {
//        return 10;
//    }
    return 0.01;
}
- (void)dropdownMenu:(SJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    //NSLog(@"你选择了：%d",(int)number);
    if (number==2) {
        self.header.selectedIndex=2;
        self.header.fixedTitles=@[@"介绍",@"目录",@"评论",@"相关课程"];
        self.index=2;
        self.commentSubmitView.hidden=NO;
        self.tableView.frame=CGRectMake(0, self.header.bottom, kScreenWidth, kScreenHeight-300-SafeAreaBottomHeight);
        [self getNewDataWith:2];
    }else if (number==1){
        self.sharedView=[[CustomSharedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
        self.sharedView.url=self.shareUrl;
        self.sharedView.title=self.shareTitle;
        self.sharedView.content=self.shareContent;
    }else if (number==0){
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:loginNavi animated:YES completion:nil];
        }else{
            [self collectACourse];
        }
    }
}
-(void)collectACourse{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"courseId":@(self.courseId)};
    [TDHttpTools collectCourseWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
