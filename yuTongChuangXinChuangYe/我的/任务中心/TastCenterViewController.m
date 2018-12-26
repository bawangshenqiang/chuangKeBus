//
//  TastCenterViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TastCenterViewController.h"
#import "TastTop.h"
#import "TaskCenterHeaderModel.h"
#import "TastCenterModel.h"
#import "TaskCenterHeaderView.h"
#import "TaskCenterSectionHeader.h"
#import "TaskCenterCell.h"
#import "TicketRecordViewController.h"
#import "RankingListViewController.h"

#import "PublishThemeViewController.h"
#import "SubmitCreativityViewController.h"
#import "SearchNumbersViewController.h"
#import "SubmitProjectViewController.h"
#import "UserInfomationViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "BindingAccountViewController.h"

#import "GotoSearchThreeViewController.h"
#import "BusinessHotViewController.h"
#import "NewPolicyViewController.h"
#import "InnovateYTViewController.h"
#import "SystemHallViewController.h"
#import "BusinessCourseViewController.h"

@interface TastCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)TastTop *topView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *sectionData;
@property(nonatomic,strong)NSMutableArray *sectionArr;
@property(nonatomic,strong)TastCenterModel *model;
@property(nonatomic,strong)TaskCenterHeaderView *header;

@end

@implementation TastCenterViewController

-(NSMutableArray *)sectionData{
    if (!_sectionData) {
        _sectionData=[NSMutableArray array];
    }
    return _sectionData;
}
-(NSMutableArray *)sectionArr{
    if (!_sectionArr) {
        _sectionArr=[NSMutableArray array];
    }
    return _sectionArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName : [UIColor blackColor]};
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self getData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = kThemeColor;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]};
}
-(void)getData{
    
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token};
    [TDHttpTools taskCenterWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            
            TastCenterModel *model=[[TastCenterModel alloc]initWithDictionary:dic[@"data"]];
            self.model=model;
            self.header.topView.ticketCount.text=[NSString stringWithFormat:@"%d",self.model.totalscore];
            self.header.todayTicket.text=[NSString stringWithFormat:@"%d",self.model.todayscore];
            
            NSArray *arr=@[@{@"title":@"每日任务",@"subTitle":@"每日0点自动刷新，请及时完成"},@{@"title":@"豪华任务",@"subTitle":@"满足任务条件后自动发送，不限奖励次数"},@{@"title":@"一次性任务",@"subTitle":@"仅可完成一次，奖励丰厚"}];
            [self.sectionData removeAllObjects];
            [self.sectionArr removeAllObjects];
            
            for (NSDictionary *dict in arr) {
                TaskCenterHeaderModel *model=[[TaskCenterHeaderModel alloc]initWithDictionary:dict];
                [self.sectionData addObject:model];
                [self.sectionArr addObject:@NO];
            }
            
            [self.tableView reloadData];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    self.title=@"任务中心";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"排行榜" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
//    self.topView=[[TastTop alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 87)];
//    self.topView.ticketCount.text=@"68120";
//    [self.topView setCenterClickBlock:^{
//        NSLog(@"兑换中心");
//    }];
//    [self.view addSubview:self.topView];
    
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark 排行榜
-(void)rightBarClick{
    RankingListViewController *vc=[RankingListViewController new];
    vc.ticketCount=self.model.totalscore;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableHeaderView=[self headerView];
        _tableView.tableFooterView=[self footerView];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(UIView *)headerView{
    TaskCenterHeaderView *head=[[TaskCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 137)];
    self.header=head;
    WS(weakSelf);
    [head setRecordClickBlock:^{
        //车票记录
        TicketRecordViewController *vc=[TicketRecordViewController new];
        vc.ticketCount=weakSelf.model.totalscore;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [head.topView setCenterClickBlock:^{
        //兑换中心
        
    }];
    return head;
}
-(UIView *)footerView{
    UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    foot.backgroundColor=kBackgroundColor;
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 4, kScreenWidth, 14)];
    lab.text=@"更多奖励任务敬请期待~";
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:14];
    lab.textColor=RGBAColor(102, 102, 102, 1);
    [foot addSubview:lab];
    return foot;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.sectionArr.count>0) {
        if ([self.sectionArr[section] boolValue]) {
            return 0;
        }else{
            switch (section) {
                case 0:
                    return 4;
                    break;
                case 1:
                    return 4;
                    break;
                default:
                    return 3;
                    break;
            }
        }
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellIdentifier1";
    TaskCenterCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[TaskCenterCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        cell.separatorInset=UIEdgeInsetsMake(0, 10, 0, 10);
    }
    NSArray *images=@[@[@"签到",@"pic_day1",@"pic_day2",@"pic_day4"],@[@"pic_m2",@"pic_m3",@"pic_m1",@"pic_day4"],@[@"pic_one1",@"pic_one2",@"pic_one3"]];
    NSArray *titles=@[@[@"签到",@"浏览阅读",@"点赞收藏评论",@"发表主题"],@[@"提交创意",@"提交项目",@"提交找成员",@"精华主题"],@[@"新人福利",@"绑定微信",@"完善个人资料"]];
    cell.leftIV.image=[UIImage imageNamed:images[indexPath.section][indexPath.row]];
    cell.topTitle.text=titles[indexPath.section][indexPath.row];
    cell.indexPath=indexPath;
    WS(weakSelf);
    [cell setBtnClickBlock:^(NSString * _Nonnull string,NSIndexPath *indexPath) {
        [weakSelf btnClickJumpWith:string indexpath:indexPath];
    }];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.todaysign];
                    cell.bottomTitle.text=[NSString stringWithFormat:@"明日签到将获得%d车票",self.model.tomorrowsign];
                    cell.completeLab.hidden=YES;
                    cell.btn.hidden=NO;
                    if (self.model.Signed) {
                        [cell.btn setTitle:@"已签到" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        cell.btn.backgroundColor=RGBAColor(153, 153, 153, 1);
                        cell.btn.layer.borderWidth=0;
                    }else{
                        [cell.btn setTitle:@"签到" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                        cell.btn.backgroundColor=[UIColor whiteColor];
                        cell.btn.layer.borderWidth=1;
                        cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                    }
                    
                }
                    break;
                case 1:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.viewjobscore];
                    cell.bottomTitle.text=[NSString stringWithFormat:@"浏览%d篇文章（%d/%d）",self.model.viewjobtotal,self.model.viewjobnow,self.model.viewjobtotal];
                    cell.completeLab.hidden=YES;
                    cell.btn.hidden=NO;
                    if (self.model.viewjobdone) {
                        [cell.btn setTitle:@"已完成" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        cell.btn.backgroundColor=RGBAColor(153, 153, 153, 1);
                        cell.btn.layer.borderWidth=0;
                    }else{
                        if (self.model.viewjobnow==self.model.viewjobtotal) {
                            [cell.btn setTitle:@"领奖励" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            cell.btn.backgroundColor=RGBAColor(255, 150, 0, 1);
                            cell.btn.layer.borderWidth=0;
                        }else{
                            [cell.btn setTitle:@"做任务" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                            cell.btn.backgroundColor=[UIColor whiteColor];
                            cell.btn.layer.borderWidth=1;
                            cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                        }
                    }
                    
                }
                    break;
                case 2:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.clickjobscore];
                    cell.bottomTitle.text=[NSString stringWithFormat:@"各完成一次（%d/3）",(self.model.collectjobnow+self.model.commentjobnow+self.model.praisejobnow)];
                    cell.completeLab.hidden=YES;
                    cell.btn.hidden=NO;
                    if (self.model.clickjobdone) {
                        [cell.btn setTitle:@"已完成" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        cell.btn.backgroundColor=RGBAColor(153, 153, 153, 1);
                        cell.btn.layer.borderWidth=0;
                    }else{
                        if (self.model.praisejobnow+self.model.commentjobnow+self.model.collectjobnow==3) {
                            [cell.btn setTitle:@"领奖励" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            cell.btn.backgroundColor=RGBAColor(255, 150, 0, 1);
                            cell.btn.layer.borderWidth=0;
                        }else{
                            [cell.btn setTitle:@"做任务" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                            cell.btn.backgroundColor=[UIColor whiteColor];
                            cell.btn.layer.borderWidth=1;
                            cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                        }
                    }
                }
                    break;
                default:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.postjobscore];
                    cell.bottomTitle.text=@"恶意灌水将扣除车票！";
                    cell.completeLab.hidden=YES;
                    cell.btn.hidden=NO;
                    if (self.model.postjobdone) {
                        [cell.btn setTitle:@"已完成" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        cell.btn.backgroundColor=RGBAColor(153, 153, 153, 1);
                        cell.btn.layer.borderWidth=0;
                    }else{
                        if (self.model.postjobnow) {
                            [cell.btn setTitle:@"领奖励" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            cell.btn.backgroundColor=RGBAColor(255, 150, 0, 1);
                            cell.btn.layer.borderWidth=0;
                        }else{
                            [cell.btn setTitle:@"做任务" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                            cell.btn.backgroundColor=[UIColor whiteColor];
                            cell.btn.layer.borderWidth=1;
                            cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                        }
                    }
                }
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.ideajobscore];
                    cell.bottomTitle.text=@"需审核通过";
                    if (self.model.ideajobnow>0) {
                        cell.completeLab.hidden=NO;
                        cell.btn.hidden=YES;
                        cell.completeLab.text=[NSString stringWithFormat:@"已完成%d次",self.model.ideajobnow];
                    }else{
                        cell.completeLab.hidden=YES;
                        cell.btn.hidden=NO;
                        [cell.btn setTitle:@"做任务" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                        cell.btn.backgroundColor=[UIColor whiteColor];
                        cell.btn.layer.borderWidth=1;
                        cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                    }
                }
                    break;
                case 1:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.projobscore];
                    cell.bottomTitle.text=@"需上线通过";
                    if (self.model.projobnow>0) {
                        cell.completeLab.hidden=NO;
                        cell.btn.hidden=YES;
                        cell.completeLab.text=[NSString stringWithFormat:@"已完成%d次",self.model.projobnow];
                    }else{
                        cell.completeLab.hidden=YES;
                        cell.btn.hidden=NO;
                        [cell.btn setTitle:@"做任务" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                        cell.btn.backgroundColor=[UIColor whiteColor];
                        cell.btn.layer.borderWidth=1;
                        cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                    }
                }
                    break;
                case 2:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.teamjobscore];
                    cell.bottomTitle.text=@"需审核通过";
                    if (self.model.teamjobnow>0) {
                        cell.completeLab.hidden=NO;
                        cell.btn.hidden=YES;
                        cell.completeLab.text=[NSString stringWithFormat:@"已完成%d次",self.model.teamjobnow];
                    }else{
                        cell.completeLab.hidden=YES;
                        cell.btn.hidden=NO;
                        [cell.btn setTitle:@"做任务" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                        cell.btn.backgroundColor=[UIColor whiteColor];
                        cell.btn.layer.borderWidth=1;
                        cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                    }
                }
                    break;
                default:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.hotpostjobscore];
                    cell.bottomTitle.text=@"发表的主题被选为精华主题";
                    cell.completeLab.hidden=NO;
                    cell.btn.hidden=YES;
                    cell.completeLab.text=[NSString stringWithFormat:@"被置顶%d次",self.model.hotpostjobnow];
                }
                    break;
            }
            break;
        default:
            switch (indexPath.row) {
                case 0:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.regjobscore];
                    cell.bottomTitle.text=@"新用户直接领取，祝您创业成功～";
                    cell.completeLab.hidden=YES;
                    cell.btn.hidden=NO;
                    if (self.model.regjobdone) {
                        [cell.btn setTitle:@"已完成" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        cell.btn.backgroundColor=RGBAColor(153, 153, 153, 1);
                        cell.btn.layer.borderWidth=0;
                    }else{
                        [cell.btn setTitle:@"领奖励" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        cell.btn.backgroundColor=RGBAColor(255, 150, 0, 1);
                        cell.btn.layer.borderWidth=0;
                    }
                }
                    break;
                case 1:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.bindjobscore];
                    cell.bottomTitle.text=@"绑定后可直接使用微信登录";
                    cell.completeLab.hidden=YES;
                    cell.btn.hidden=NO;
                    if (self.model.bindjobdone) {
                        [cell.btn setTitle:@"已完成" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        cell.btn.backgroundColor=RGBAColor(153, 153, 153, 1);
                        cell.btn.layer.borderWidth=0;
                    }else{
                        if (self.model.bindjobnow) {
                            [cell.btn setTitle:@"领奖励" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            cell.btn.backgroundColor=RGBAColor(255, 150, 0, 1);
                            cell.btn.layer.borderWidth=0;
                        }else{
                            [cell.btn setTitle:@"做任务" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                            cell.btn.backgroundColor=[UIColor whiteColor];
                            cell.btn.layer.borderWidth=1;
                            cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                        }
                    }
                }
                    break;
                default:
                {
                    cell.topScore.text=[NSString stringWithFormat:@"+%d",self.model.completejobscore];
                    cell.bottomTitle.text=@"不要忘记还有头像哦～";
                    cell.completeLab.hidden=YES;
                    cell.btn.hidden=NO;
                    if (self.model.completejobdone) {
                        [cell.btn setTitle:@"已完成" forState:UIControlStateNormal];
                        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        cell.btn.backgroundColor=RGBAColor(153, 153, 153, 1);
                        cell.btn.layer.borderWidth=0;
                    }else{
                        if (self.model.completejobnow) {
                            [cell.btn setTitle:@"领奖励" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            cell.btn.backgroundColor=RGBAColor(255, 150, 0, 1);
                            cell.btn.layer.borderWidth=0;
                        }else{
                            [cell.btn setTitle:@"做任务" forState:UIControlStateNormal];
                            [cell.btn setTitleColor:RGBAColor(255, 150, 0, 1) forState:UIControlStateNormal];
                            cell.btn.backgroundColor=[UIColor whiteColor];
                            cell.btn.layer.borderWidth=1;
                            cell.btn.layer.borderColor=RGBAColor(255, 150, 0, 1).CGColor;
                        }
                    }
                }
                    break;
            }
            break;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 47;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TaskCenterSectionHeader *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (header==nil) {
        header=[[TaskCenterSectionHeader alloc]initWithReuseIdentifier:@"headerView"];
        WS(weakSelf);
        [header setFoldClickBlock:^(NSInteger index) {
            
            [weakSelf.sectionArr replaceObjectAtIndex:index withObject:@(![weakSelf.sectionArr[index] boolValue])];
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    
    header.taag=section;
    if (self.sectionData.count>0) {
        header.model=self.sectionData[section];
    }
    return header;
}
-(void)btnClickJumpWith:(NSString *)string indexpath:(NSIndexPath *)indexPath{
    if ([string isEqualToString:@"签到"]) {
        [self completeJobWith:@"sign"];
    }else if ([string isEqualToString:@"领奖励"]){
        if (indexPath.section==0) {
            switch (indexPath.row) {
                case 1:
                    [self completeJobWith:@"view"];
                    break;
                case 2:
                    [self completeJobWith:@"click"];
                    break;
                case 3:
                    [self completeJobWith:@"post"];
                    break;
                default:
                    break;
            }
        }else if (indexPath.section==2){
            switch (indexPath.row) {
                case 0:
                    [self completeJobWith:@"register"];
                    break;
                case 1:
                    [self completeJobWith:@"wxbind"];
                    break;
                case 2:
                    [self completeJobWith:@"info"];
                    break;
                default:
                    break;
            }
        }
    }else if ([string isEqualToString:@"做任务"]){
        if (indexPath.section==0) {
            switch (indexPath.row) {
                case 1:
                {
                    int a=arc4random()%8;//(0~7)
                    NSArray *arr=@[@{@"key1":@"0",@"key2":@"GotoSearchThreeViewController"},@{@"key1":@"1",@"key2":@"GotoSearchThreeViewController"},@{@"key1":@"2",@"key2":@"GotoSearchThreeViewController"},@{@"key1":@"3",@"key2":@"BusinessHotViewController"},@{@"key1":@"4",@"key2":@"NewPolicyViewController"},@{@"key1":@"5",@"key2":@"SystemHallViewController"},@{@"key1":@"6",@"key2":@"BusinessCourseViewController"},@{@"key1":@"7",@"key2":@"InnovateYTViewController"}];
                    for (NSDictionary *dic in arr) {
                        if ([@(a).stringValue isEqualToString:dic[@"key1"]]) {
                            Class class=NSClassFromString(dic[@"key2"]);
                            UIViewController *vc=[[class alloc]init];
                            if ([dic[@"key2"] isEqualToString:@"GotoSearchThreeViewController"]) {
                                GotoSearchThreeViewController *mvc=(GotoSearchThreeViewController *)vc;
                                mvc.index=a;
                                [self.navigationController pushViewController:mvc animated:YES];
                            }else if([dic[@"key2"] isEqualToString:@"SystemHallViewController"]){
                                SystemHallViewController *mvc=(SystemHallViewController *)vc;
                                mvc.themeId=126;
                                mvc.title=@"创意交流";
                                [self.navigationController pushViewController:mvc animated:YES];
                            }else{
                                [self.navigationController pushViewController:vc animated:YES];
                            }
                            
                            break;
                        }
                    }
                    
                }
                    break;
                case 2:
                {
                    int a=arc4random()%7;//(0~6)
                    NSArray *arr=@[@{@"key1":@"0",@"key2":@"GotoSearchThreeViewController"},@{@"key1":@"1",@"key2":@"GotoSearchThreeViewController"},@{@"key1":@"2",@"key2":@"GotoSearchThreeViewController"},@{@"key1":@"3",@"key2":@"BusinessHotViewController"},@{@"key1":@"4",@"key2":@"NewPolicyViewController"},@{@"key1":@"5",@"key2":@"SystemHallViewController"},@{@"key1":@"6",@"key2":@"BusinessCourseViewController"}];
                    for (NSDictionary *dic in arr) {
                        if ([@(a).stringValue isEqualToString:dic[@"key1"]]) {
                            Class class=NSClassFromString(dic[@"key2"]);
                            UIViewController *vc=[[class alloc]init];
                            if ([dic[@"key2"] isEqualToString:@"GotoSearchThreeViewController"]) {
                                GotoSearchThreeViewController *mvc=(GotoSearchThreeViewController *)vc;
                                mvc.index=a;
                                [self.navigationController pushViewController:mvc animated:YES];
                            }else if([dic[@"key2"] isEqualToString:@"SystemHallViewController"]){
                                SystemHallViewController *mvc=(SystemHallViewController *)vc;
                                mvc.themeId=126;
                                mvc.title=@"创意交流";
                                [self.navigationController pushViewController:mvc animated:YES];
                            }else{
                                [self.navigationController pushViewController:vc animated:YES];
                            }
                            
                            break;
                        }
                    }
                }
                    break;
                case 3:
                {
                    PublishThemeViewController *vc=[PublishThemeViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }else if (indexPath.section==1){
            switch (indexPath.row) {
                case 0:
                {
                    SubmitCreativityViewController *vc=[SubmitCreativityViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    SubmitProjectViewController *vc=[SubmitProjectViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                {
                    SearchNumbersViewController *vc=[SearchNumbersViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }else if (indexPath.section==2){
            switch (indexPath.row) {
                case 1:
                {
                    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
                           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
                     {
                         if (state == SSDKResponseStateSuccess)
                         {
                             
                             
                             //
                             NSString *CName=[user.nickname copy];
                             NSString *icon = [user.icon copy];
                             
                             //
                             WS(weakSelf);
                             [weakSelf thirdPartyLogin:user.uid cName:CName headImg:icon];
                         }
                         
                         else
                         {
                             NSLog(@"%@",error);
                         }
                         
                     }];
                }
                    break;
                case 2:
                {
                    UserInfomationViewController *vc=[UserInfomationViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
    }
    
}
-(void)completeJobWith:(NSString *)module{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"module":module};
    [TDHttpTools completejobWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            if ([dic[@"data"] isKindOfClass:[NSDictionary class]] && dic[@"data"]!=nil) {
//                self.header.topView.ticketCount.text=[NSString stringWithFormat:@"%@",dic[@"data"][@"totalscore"]];
//                self.header.todayTicket.text=[NSString stringWithFormat:@"%@",dic[@"data"][@"todayscore"]];
                [self getData];
            }
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
-(void)thirdPartyLogin:(NSString*)openId cName:(NSString *)cname headImg:(NSString *)headImg{
    
    NSDictionary *param=@{@"openid":openId,@"ip":@"",@"name":cname,@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]};
    [TDHttpTools loginWXWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        //NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:@"已绑定微信"];
            [Account sharedAccount].wxname=cname;
            [Account sharedAccount].wxbind=YES;
        }
//        else if ([dic[@"code"] intValue]==500301){
//            //未绑定
//            BindingAccountViewController *bingVC=[BindingAccountViewController new];
//            bingVC.openid=openId;
//            bingVC.fromSetPage=YES;
//            [self.navigationController pushViewController:bingVC animated:YES];
//        }
        else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
