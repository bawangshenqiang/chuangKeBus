//
//  HallFirstViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HallFirstViewController.h"
#import "CustomNavi.h"
#import "TableHeader_HallFirst.h"
#import "SectionHeader_HallFirst.h"
#import "HotImageCell_HallFirst.h"
#import "HotTitleCell_HallFirst.h"
#import "HuaShanTitleCell_HallFirst.h"
#import "StarProjectCell_HallFirst.h"
#import "GotoSearchThreeViewController.h"
#import "HuaShanListModel.h"
#import "MyMessageViewController.h"
#import "CreativityAndProjectDetailViewController.h"
#import "HuaShanDetailViewController.h"
#import "SearchViewController.h"
#import "Hall_HomeTodayHotModel.h"
#import "Hall_HomeStarProject.h"
#import "HomePageImgModel.h"
#import "BusinessHotDetailViewController.h"
#import "VideoDetailViewController.h"
#import "SearchNumbersDetailViewController.h"
#import "DetailViewController.h"
#import "ServerDetailViewController.h"
#import "LoginViewController.h"
#import "PolicyDetailViewController.h"
#import "HotServeSecondCell_ServeFirst.h"

BOOL receiveMessage;

@interface HallFirstViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)CustomNavi *customNavi;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)TableHeader_HallFirst *header;
@property(nonatomic,strong)NSMutableArray *cyccleImagesData;
@property(nonatomic,strong)NSMutableArray *huaShanData;
@property(nonatomic,strong)NSMutableArray *todayHotData;
@property(nonatomic,strong)NSMutableArray *starProjectData;

@end

@implementation HallFirstViewController

-(NSMutableArray *)cyccleImagesData{
    if (!_cyccleImagesData) {
        _cyccleImagesData=[NSMutableArray array];
    }
    return _cyccleImagesData;
}
-(NSMutableArray *)huaShanData{
    if (!_huaShanData) {
        _huaShanData=[NSMutableArray array];
    }
    return _huaShanData;
}
-(NSMutableArray *)todayHotData{
    if (!_todayHotData) {
        _todayHotData=[NSMutableArray array];
    }
    return _todayHotData;
}
-(NSMutableArray *)starProjectData{
    if (!_starProjectData) {
        _starProjectData=[NSMutableArray array];
    }
    return _starProjectData;
}
-(void)getData{
    
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    
    
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token};
    [TDHttpTools hallHomeWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"+++++%@",dic);
        //NSLog(@"-----%@",[SJTool logDic:dic]);
        
        [self.cyccleImagesData removeAllObjects];
        [self.todayHotData removeAllObjects];
        [self.huaShanData removeAllObjects];
        [self.starProjectData removeAllObjects];
        
        if ([dic[@"code"] intValue]==200) {
            NSDictionary *data=dic[@"data"];
            for (NSDictionary *dict in data[@"carousels"]) {
                HomePageImgModel *model=[[HomePageImgModel alloc]initWithDictionary:dict];
                [self.cyccleImagesData addObject:model];
            }
            for (NSDictionary *dict in data[@"newpush"]) {
                Hall_HomeTodayHotModel *model=[[Hall_HomeTodayHotModel alloc]initWithDictionary:dict];
                [self.todayHotData addObject:model];
            }
            for (NSDictionary *dict in data[@"recpost"]) {
                HuaShanListModel *model=[[HuaShanListModel alloc]initWithDictionary:dict];
                [self.huaShanData addObject:model];
            }
            for (NSDictionary *dict in data[@"projects"]) {
                Hall_HomeStarProject *model=[[Hall_HomeStarProject alloc]initWithDictionary:dict];
                [self.starProjectData addObject:model];
            }
            
            NSMutableArray *imgArr=[NSMutableArray array];
            for (HomePageImgModel *model in self.cyccleImagesData) {
                [imgArr addObject:model.TopImgUrl];
            }
            self.header.cycleImageUrls=imgArr;
            
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
//获取个人信息
-(void)getUserInfro{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token};
    [TDHttpTools getUserInfoWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [Account sharedAccount].message=[dic[@"data"][@"message"] intValue];
            if ([Account sharedAccount].message>0) {
                receiveMessage=YES;
                self.customNavi.redDot.hidden=NO;
            }
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TOKEN"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[Account sharedAccount] logout];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (receiveMessage) {
        self.customNavi.redDot.hidden=NO;
    }else{
        self.customNavi.redDot.hidden=YES;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    receiveMessage=NO;
    //
    self.customNavi=[[CustomNavi alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight+44)];
    WS(weakSelf);
    [self.customNavi setTouchSearchBlock:^{
        NSLog(@"点击搜索");
        SearchViewController *searchVC=[[SearchViewController alloc]init];
        
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    }];
    [self.customNavi setTouchMessageBlock:^{
        NSLog(@"点击消息");
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            weakSelf.customNavi.redDot.hidden=YES;
            receiveMessage=NO;
            [Account sharedAccount].message=0;
            MyMessageViewController *messageVC=[MyMessageViewController new];
            messageVC.index=0;
            [weakSelf.navigationController pushViewController:messageVC animated:YES];
        }
        
    }];
    [self.view addSubview:self.customNavi];
    
    [self.view addSubview:self.tableView];
    
    [self getData];
    [self getUserInfro];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getData];
        
    }];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.customNavi.bottom, kScreenWidth, kScreenHeight-self.customNavi.height-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView=[self head];
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(UIView *)head{
    self.header=[[TableHeader_HallFirst alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 238*kBaseHeight)];
    self.header.cycleScrollView.delegate=self;
    WS(weakSelf);
    [self.header setThreeBtnClickBlock:^(NSInteger index) {
        //找创意，找项目，找伙伴
        GotoSearchThreeViewController *searchVC=[GotoSearchThreeViewController new];
        searchVC.index=index;
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
        
    }];
    return self.header;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
                static NSString *cellId1_1=@"cellIdentifier1_1";
                HotServeSecondCell_ServeFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId1_1];
                if (!cell) {
                    cell=[[HotServeSecondCell_ServeFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId1_1];
                    cell.backgroundColor=kBackgroundColor;
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                if (self.todayHotData.count>0) {
                    Hall_HomeTodayHotModel *model=self.todayHotData.firstObject;
                    cell.hallModel=model;
                    
                }
                
                return cell;
            }else{
                static NSString *cellId1_2=@"cellIdentifier1_2";
                HotTitleCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId1_2];
                if (!cell) {
                    cell=[[HotTitleCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId1_2];
                    cell.backgroundColor=kBackgroundColor;
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                if (self.todayHotData.count>0) {
                    NSMutableArray *arr=[self.todayHotData mutableCopy];
                    [arr removeObjectAtIndex:0];
                    cell.models=arr;
                    WS(weakSelf);
                    [cell setTitleClickBlock:^(Hall_HomeTodayHotModel * _Nonnull model) {
                        [weakSelf todayHotJumpWith:model];
                    }];
                }
                return cell;
            }
        }
            break;
        case 1:
        {
            static NSString *cellId2=@"cellIdentifier2";
            HuaShanTitleCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId2];
            if (!cell) {
                cell=[[HuaShanTitleCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId2];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            if (self.huaShanData.count>0) {
                HuaShanListModel *model=self.huaShanData[indexPath.row];
                cell.model=model;
            }
            
            return cell;
        }
            break;
        default:
        {
            static NSString *cellId3=@"cellIdentifier3";
            StarProjectCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId3];
            if (!cell) {
                cell=[[StarProjectCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId3];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            if (self.starProjectData.count>0) {
                cell.model_starProject=self.starProjectData[indexPath.row];
            }
            return cell;
        }
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 85;
        }else{
            return 215;
        }
    }else if (indexPath.section==1){
//        NSArray *texts=@[@"《区块链金融大师班》————15亿准独角兽区块链创业团队领衔主讲",@"《区块链金融大师班》————15亿准独角兽区块链",@"《区块链金融大师班》————15亿准独角兽区块链创业团队领衔主讲《区块链金融大师班》————15亿准独角兽区块链创业团队领衔主讲《区块链金融大师班》————15亿准独角兽区块链创业团队领衔主讲"];
//        CGFloat height=[tableView cellHeightForIndexPath:indexPath model:texts[indexPath.row] keyPath:@"titleText" cellClass:[HuaShanTitleCell_HallFirst class] contentViewWidth:kScreenWidth];
//        return height;
        if (self.huaShanData.count>0) {
            HuaShanListModel *model=self.huaShanData[indexPath.row];
            CGFloat height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HuaShanTitleCell_HallFirst class] contentViewWidth:kScreenWidth];
            return height;
        }
        
    }
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeader_HallFirst *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header=[[SectionHeader_HallFirst alloc]initWithReuseIdentifier:@"header"];
    }
    NSArray *images=@[@"hall_hottest",@"hall_forum",@"hall_star"];
    NSArray *titles=@[@"今日最热",@"华山论剑",@"明星项目"];
    header.leftIV.image=[UIImage imageNamed:images[section]];
    header.titleLab.text=titles[section];
    return header;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 8;
    }
    return 0.01;
}
-(void)todayHotJumpWith:(Hall_HomeTodayHotModel *)model{
    NSLog(@"%@",model.module);//model.Id
    //今日最热根据标签分类跳转不同的详情页,传id
    [self jumpWithId:model.Id module:model.module];
}
-(void)jumpWithId:(int)targetId module:(NSString *)module{
    if ([module isEqualToString:@"idea"]) {
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=0;
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"project"]){
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=1;
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"information"]){
        BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"course"]){
        VideoDetailViewController *detailVC=[VideoDetailViewController new];
        detailVC.courseId=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"post"]||[module isEqualToString:@"activity"]){
        HuaShanDetailViewController *detailVC=[HuaShanDetailViewController new];
        detailVC.postId=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"team"]){
        SearchNumbersDetailViewController *detailVC=[SearchNumbersDetailViewController new];
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"innovation"]){
        DetailViewController *detailVC=[DetailViewController new];
        detailVC.innovationId=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"provider"]){
        ServerDetailViewController *detailVC=[ServerDetailViewController new];
        detailVC.providerId=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"policy"]){
        PolicyDetailViewController *detailVC=[PolicyDetailViewController new];
        detailVC.policyId=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            Hall_HomeTodayHotModel *model=self.todayHotData.firstObject;
            [self todayHotJumpWith:model];
        }
    }else if (indexPath.section==1){
        HuaShanDetailViewController *detailVC=[HuaShanDetailViewController new];
        HuaShanListModel *model=self.huaShanData[indexPath.row];
        detailVC.postId=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=1;
        Hall_HomeStarProject *model=self.starProjectData[indexPath.row];
        detailVC.Id=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}
#pragma mark 点击轮播图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //NSLog(@"%d,点我干嘛？",(int)index);
    HomePageImgModel *model=self.cyccleImagesData[index];
    [self jumpWithId:model.Id module:model.module];
    
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
