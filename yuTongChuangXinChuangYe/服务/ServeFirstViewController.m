//
//  ServeFirstViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeFirstViewController.h"
#import "CustomNavi.h"
#import "SectionHeader_HallFirst.h"
#import "TableHeader_ServeFirst.h"
#import "StarCourseModel_Serve.h"
#import "StarCourseCell_ServeFirst.h"
#import "StarProjectCell_HallFirst.h"
#import "HotServeCell_ServeFirst.h"
#import "HotServeSecondCell_ServeFirst.h"
#import "BusinessResourceViewController.h"
#import "BusinessCourseViewController.h"
#import "VideoDetailViewController.h"
#import "MyMessageViewController.h"
#import "VideoDetailViewController.h"
#import "ServerDetailViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"

#import "ServeHomeCourseCell.h"
#import "ServeHomeServiceCell.h"

extern BOOL receiveMessage;

@interface ServeFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomNavi *customNavi;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr1;
@property(nonatomic,strong)NSMutableArray *dataArr2;
@end

@implementation ServeFirstViewController

-(NSMutableArray *)dataArr1{
    if (!_dataArr1) {
        _dataArr1=[NSMutableArray array];
    }
    return _dataArr1;
}
-(NSMutableArray *)dataArr2{
    if (!_dataArr2) {
        _dataArr2=[NSMutableArray array];
    }
    return _dataArr2;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getData];
        
    }];
}
-(void)getData{
    
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    
    
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token};
    [TDHttpTools serverHomeWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        
        NSLog(@"%@",[SJTool logDic:dic]);
        
        [self.dataArr1 removeAllObjects];
        [self.dataArr2 removeAllObjects];
        
        
        if ([dic[@"code"] intValue]==200) {
            NSDictionary *data=dic[@"data"];
            for (NSDictionary *dict in data[@"courses"]) {
                StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
                [self.dataArr1 addObject:model];
            }
            for (NSDictionary *dict in data[@"providers"]) {
                StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
                [self.dataArr2 addObject:model];
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
//-(void)getData{
//
//    NSArray *arr1=@[@{@"picture":@"course",@"title":@"品牌和营销——从入门到精通"},@{@"picture":@"course",@"title":@"品牌和营销——从入门到精通，学习没有捷径，和真知死磕到底"}];
//    NSArray *arr2=@[@{@"picture":@"entrepreneurship",@"title":@"宇通服务商名称"},@{@"picture":@"entrepreneurship",@"title":@"宇通服务商名称"}];
//    for (NSDictionary *dic1 in arr1) {
//        StarCourseModel_Serve *model1=[[StarCourseModel_Serve alloc]initWithDictionary:dic1];
//        [self.dataArr1 addObject:model1];
//    }
//    for (NSDictionary *dic1 in arr2) {
//        StarCourseModel_Serve *model1=[[StarCourseModel_Serve alloc]initWithDictionary:dic1];
//        [self.dataArr2 addObject:model1];
//    }
//
//    [self.tableView reloadData];
//
//}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.customNavi.bottom, kScreenWidth, kScreenHeight-self.customNavi.height-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView=[self header];
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(UIView *)header{
    TableHeader_ServeFirst *header=[[TableHeader_ServeFirst alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 78)];
    WS(weakSelf);
    [header setTwoBtnClickBlock:^(NSInteger index) {
        NSLog(@"tag:%d",(int)index);
        switch (index) {
            case 0:
            {
                BusinessResourceViewController *businessVC=[BusinessResourceViewController new];
                [weakSelf.navigationController pushViewController:businessVC animated:YES];
            }
                break;
            default:
            {
                BusinessCourseViewController *courseVC=[BusinessCourseViewController new];
                [weakSelf.navigationController pushViewController:courseVC animated:YES];
            }
                break;
        }
    }];
    return header;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
//        if (self.dataArr1.count<=2) {
//            return 1;
//        }else if (self.dataArr1.count==3){
//            return 2;
//        }else{
//            return 3;
//        }
//    }else{
//        if (self.dataArr2.count<=2) {
//            return 1;
//        }else if (self.dataArr2.count==3){
//            return 2;
//        }else{
//            return 3;
//        }
//    }
//    return 3;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        /**
        if (indexPath.row==0) {
            NSString *cellID1=@"cellIdentifier1";
            StarCourseCell_ServeFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
            if (!cell) {
                cell=[[StarCourseCell_ServeFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.models=self.dataArr1;
            WS(weakSelf);
            [cell setACellBtnClickBlock:^(NSInteger index) {
                NSLog(@"tag:%d",(int)index);
                [weakSelf gotoDetailWith:(int)index];
            }];
            return cell;
        }else{
            static NSString *cellId2=@"cellIdentifier2";
            StarProjectCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId2];
            if (!cell) {
                cell=[[StarProjectCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId2];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            if (self.dataArr1.count>0) {
                cell.model_serve=self.dataArr1[indexPath.row+1];
                
            }
            
            return cell;
        }
        */
        NSString *cellID1=@"cellIdentifier1";
        ServeHomeCourseCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell=[[ServeHomeCourseCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
            cell.backgroundColor=[UIColor whiteColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.courseArr=self.dataArr1;
        WS(weakSelf);
        [cell setSelectAitemBlock:^(NSInteger courseId) {
            [weakSelf gotoDetailWith:(int)courseId];
        }];
        return cell;
    }else{
        /**
        if (indexPath.row==0) {
            NSString *cellID3=@"cellIdentifier3";
            HotServeCell_ServeFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID3];
            if (!cell) {
                cell=[[HotServeCell_ServeFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID3];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.models=self.dataArr2;
            WS(weakSelf);
            [cell setACellBtnClickBlock:^(NSInteger index) {
                NSLog(@"tag:%d",(int)index);
                ServerDetailViewController *detailVC=[ServerDetailViewController new];
                
                detailVC.providerId=index;
                [weakSelf.navigationController pushViewController:detailVC animated:YES];
            }];
            return cell;
        }else{
            NSString *cellID4=@"cellIdentifier4";
            HotServeSecondCell_ServeFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID4];
            if (!cell) {
                cell=[[HotServeSecondCell_ServeFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID4];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            if (self.dataArr2.count>0) {
                cell.model=self.dataArr2[indexPath.row+1];
            }
            
            return cell;
        }
        */
        NSString *cellID1=@"cellIdentifier2";
        ServeHomeServiceCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell=[[ServeHomeServiceCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
            cell.backgroundColor=[UIColor whiteColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.serviceArr=self.dataArr2;
        WS(weakSelf);
        [cell setSelectAitemBlock:^(NSInteger providerId) {
            ServerDetailViewController *detailVC=[ServerDetailViewController new];
            
            detailVC.providerId=providerId;
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
        }];
        return cell;
    }
    
}
#pragma mark 视频详情
-(void)gotoDetailWith:(int)index{
    VideoDetailViewController *videoDetail=[VideoDetailViewController new];
    videoDetail.courseId=index;
    [self.navigationController pushViewController:videoDetail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0) {
//        if (indexPath.row==0) {
//            return 170;
//        }else{
//            return 100;
//        }
//    }else{
//        if (indexPath.row==0) {
//            return 120;
//        }else{
//            return 85;
//        }
//    }
    CGFloat width=(kScreenWidth-40)/2;
    CGFloat height1=(width*25/33+40);
    CGFloat height2=(width*150/325+25);
    
    if (indexPath.section==0) {
        return 2*height1+30;
    }else{
        return 2*height2+40;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    SectionHeader_HallFirst *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//    if (!header) {
//        header=[[SectionHeader_HallFirst alloc]initWithReuseIdentifier:@"header"];
//    }
//    NSArray *images=@[@"serve_starclass",@"hall_hottest"];
//    NSArray *titles=@[@"明星课程",@"热门服务"];
//    header.leftIV.image=[UIImage imageNamed:images[section]];
//    header.titleLab.text=titles[section];
//    return header;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    label.backgroundColor=[UIColor whiteColor];
    label.font=[UIFont boldSystemFontOfSize:16];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=RGBAColor(102, 102, 102, 1);
    if (section==0) {
        label.text=@"明星课程";
    }else{
        label.text=@"热门服务";
    }
    return label;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=[UIColor whiteColor];//kBackgroundColor;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0 && indexPath.row!=0) {
//        VideoDetailViewController *detailVC=[VideoDetailViewController new];
//        StarCourseModel_Serve *model=self.dataArr1[indexPath.row+1];
//        detailVC.courseId=model.Id;
//        [self.navigationController pushViewController:detailVC animated:YES];
//
//    }else if (indexPath.section==1 && indexPath.row!=0){
//        ServerDetailViewController *detailVC=[ServerDetailViewController new];
//        StarCourseModel_Serve *model=self.dataArr2[indexPath.row+1];
//        detailVC.providerId=model.Id;
//        [self.navigationController pushViewController:detailVC animated:YES];
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
