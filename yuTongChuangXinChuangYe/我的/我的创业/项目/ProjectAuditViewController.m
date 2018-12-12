//
//  ProjectAuditViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProjectAuditViewController.h"
#import "ProjectModel_ChuangYe.h"
#import "ProjectAuditCell.h"
#import "LoadDisplayViewController.h"
#import "CreativityAndProjectDetailViewController.h"

@interface ProjectAuditViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ProjectAuditViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)getData{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"projectId":@(self.model.projectId)};
    [TDHttpTools projectAuditListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"]) {
                ProjectModel_ChuangYe *model=[[ProjectModel_ChuangYe alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
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
    [self.view addSubview:self.tableView];
    [self getData];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellIdentifier";
    ProjectAuditCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ProjectAuditCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=kBackgroundColor;
    }
    cell.model=self.dataArr[indexPath.row];
    WS(weakSelf);
    [cell.accessoryName setBtnClickBlock:^(NSString * _Nonnull string) {
        LoadDisplayViewController *detail=[LoadDisplayViewController new];
        detail.loadUrl=string;
        [weakSelf.navigationController pushViewController:detail animated:YES];
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    ProjectModel_ChuangYe *model=self.dataArr[indexPath.row];
    height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectAuditCell class] contentViewWidth:kScreenWidth];
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProjectModel_ChuangYe *model=self.dataArr[indexPath.row];
    CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
    detailVC.index=1;
    
    detailVC.Id=model.projectId;
    [self.navigationController pushViewController:detailVC animated:YES];
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
