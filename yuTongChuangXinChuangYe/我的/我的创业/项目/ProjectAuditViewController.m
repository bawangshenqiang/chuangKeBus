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
#import "AuditingLookDetailViewController.h"

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
        _tableView.tableFooterView=[self tableViewfooter];
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
    
    //进预览页,不进详情了
    ProjectModel_ChuangYe *model=self.dataArr[indexPath.row];
    AuditingLookDetailViewController *vc=[AuditingLookDetailViewController new];
    vc.url=model.url;
    [self.navigationController pushViewController:vc animated:YES];
    
//    ProjectModel_ChuangYe *model=self.dataArr[indexPath.row];
//    CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
//    detailVC.index=1;
//
//    detailVC.Id=model.projectId;
//    [self.navigationController pushViewController:detailVC animated:YES];
}
-(UIView *)tableViewfooter{
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 145)];
    UIImageView *backIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth-20, 115)];
    backIV.image=[UIImage imageNamed:@"incubation_bg"];
    backIV.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackIV)];
    [backIV addGestureRecognizer:tap];
    [footer addSubview:backIV];
    //
    UIImageView *headerIV=[[UIImageView alloc]initWithFrame:CGRectMake(20, (115-45)/2, 45, 45)];
    headerIV.image=[UIImage imageNamed:@"incubation_headportrait"];
    [backIV addSubview:headerIV];
    //
    UILabel *topLab=[[UILabel alloc]initWithFrame:CGRectMake(headerIV.right+20, headerIV.y, 230, 15)];
    topLab.text=[NSString stringWithFormat:@"辅导员：%@",self.model.instructor];
    topLab.font=[UIFont boldSystemFontOfSize:18];
    topLab.textColor=[UIColor whiteColor];
    [backIV addSubview:topLab];
    //
    UILabel *bottomLab=[[UILabel alloc]initWithFrame:CGRectMake(headerIV.right+20, topLab.bottom+15, topLab.width, 15)];
    bottomLab.textColor=[UIColor whiteColor];
    bottomLab.text=[NSString stringWithFormat:@"联系方式：%@",self.model.linkphone];
    bottomLab.font=[UIFont boldSystemFontOfSize:18];
    [backIV addSubview:bottomLab];
    
    return footer;
}
-(void)clickBackIV{
    //NSLog(@"打电话");
    if (self.model.linkphone.length==11) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", self.model.linkphone];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
        
    }
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
