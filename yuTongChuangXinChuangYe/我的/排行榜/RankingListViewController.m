//
//  RankingListViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "RankingListViewController.h"
#import "TastTop.h"
#import "RankingListModel.h"
#import "RankingListCell.h"

@interface RankingListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)TastTop *topView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation RankingListViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName : [UIColor blackColor]};
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = kThemeColor;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]};
}
-(void)getData{
    NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]};
    [TDHttpTools rankingListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"]) {
                RankingListModel *model=[[RankingListModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"排行榜";
    self.view.backgroundColor=kBackgroundColor;
    
    self.topView=[[TastTop alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 87)];
    self.topView.ticketCount.text=[NSString stringWithFormat:@"%d",self.ticketCount];
    [self.topView setCenterClickBlock:^{
        NSLog(@"兑换中心");
    }];
    [self.view addSubview:self.topView];
    
    
    [self.view addSubview:self.tableView];
    
    [self getData];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, kScreenWidth, kTableViewHeight-self.topView.height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cellID";
    RankingListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[RankingListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        cell.separatorInset=UIEdgeInsetsMake(0, 12, 0, 12);
    }
    RankingListModel *model=self.dataArr[indexPath.row];
    [cell.leftIV sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    cell.name.text=model.nickname;
    cell.ticketLab.text=[NSString stringWithFormat:@"%d",model.score];
    if (indexPath.row==0) {
        cell.medalIV.hidden=NO;
        cell.rangingLab.hidden=YES;
        cell.medalIV.image=[UIImage imageNamed:@"pic_daytop1"];
    }else if (indexPath.row==1){
        cell.medalIV.hidden=NO;
        cell.rangingLab.hidden=YES;
        cell.medalIV.image=[UIImage imageNamed:@"pic_daytop2"];
    }else if (indexPath.row==2){
        cell.medalIV.hidden=NO;
        cell.rangingLab.hidden=YES;
        cell.medalIV.image=[UIImage imageNamed:@"pic_daytop3"];
    }else{
        cell.medalIV.hidden=YES;
        cell.rangingLab.hidden=NO;
        cell.rangingLab.text=[NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    }
    if (indexPath.row==6) {
        cell.separatorInset=UIEdgeInsetsMake(0, 1000, 0, 0);
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
