//
//  PushMessageViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/15.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "PushMessageViewController.h"
#import "SetCell_switch.h"

extern BOOL receiveComment;
extern BOOL receivePraise;
extern BOOL collected;

@interface PushMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation PushMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"推送提醒";
    self.view.backgroundColor=kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.tableFooterView=[UIView new];
        _tableView.scrollEnabled=NO;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetCell_switch *cell=[[SetCell_switch alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.separatorInset=UIEdgeInsetsMake(0, -15, 0, 0);
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    WS(weakSelf);
    cell.switchBlock = ^(NSIndexPath *indexpath, BOOL open) {
        [weakSelf dealSwitchAction:indexPath Openflag:open];
    };
    NSArray *titleArr=@[@"收到评论",@"收到赞",@"被收藏"];
    
    cell.titleLab.text=titleArr[indexPath.row];
    if (indexPath.row==0) {
        [cell.rightSwitch setOn:receiveComment];
    }else if(indexPath.row==1){
        [cell.rightSwitch setOn:receivePraise];
    }else{
        [cell.rightSwitch setOn:collected];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *view=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.text=@"开启后将收到相应通知提醒";
    view.font=[UIFont systemFontOfSize:12];
    view.textAlignment=NSTextAlignmentCenter;
    view.textColor=RGBAColor(204, 204, 204, 1);
    view.backgroundColor=kBackgroundColor;
    
    return view;
}
- (void)dealSwitchAction:(NSIndexPath*)indexPath Openflag:(BOOL)flag{
    
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSString *value=flag?@"ON":@"OFF";
    NSString *module=@"";
    if (indexPath.row==0) {
        module=@"comment";
    }else if(indexPath.row==1){
        module=@"praise";
    }else{
        module=@"collect";
    }
    NSDictionary *param=@{@"user_token":token,@"module":module,@"value":value};
    [TDHttpTools userPushSetWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            NSArray *arr=[[NSUserDefaults standardUserDefaults] objectForKey:@"pushArr"];
            NSMutableArray *pushArr=[arr mutableCopy];
            if (indexPath.row==0) {
                receiveComment=flag;
                if (flag) {
                    [pushArr addObject:@"comment"];
                }else{
                    [pushArr removeObject:@"comment"];
                    
                }
            }else if(indexPath.row==1){
                receivePraise=flag;
                if (flag) {
                    [pushArr addObject:@"praise"];
                }else{
                    [pushArr removeObject:@"praise"];
                    
                }
            }else{
                collected=flag;
                if (flag) {
                    [pushArr addObject:@"collect"];
                }else{
                    [pushArr removeObject:@"collect"];
                }
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:pushArr forKey:@"pushArr"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
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
