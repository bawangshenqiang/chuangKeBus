//
//  AboutWeViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "AboutWeViewController.h"
#import "SystemMessageDetailViewController.h"

@interface AboutWeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation AboutWeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于我们";
    self.view.backgroundColor=kBackgroundColor;
    [self initSubView];
    
}
-(void)initSubView{
    UIImageView *leftIV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-60)/2, 40, 60, 60)];
    leftIV.image=[UIImage imageNamed:@"update_yutong"];
    [self.view addSubview:leftIV];
    UILabel *versionLab=[[UILabel alloc]initWithFrame:CGRectMake(0, leftIV.bottom+15, kScreenWidth, 15)];
    versionLab.textColor=[UIColor colorWithHexString:@"#989898"];
    versionLab.textAlignment=NSTextAlignmentCenter;
    versionLab.backgroundColor=[UIColor clearColor];
    versionLab.font=[UIFont systemFontOfSize:14];
    versionLab.text=[NSString stringWithFormat:@"版本号  %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [self.view addSubview:versionLab];
    //
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, versionLab.bottom+20, kScreenWidth, 80) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.scrollEnabled=NO;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *arr=@[@"用户协议",@"隐私权政策"];
    cell.textLabel.text=arr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SystemMessageDetailViewController *detail=[SystemMessageDetailViewController new];
    NSString *kSERVER_HTTP_DXE=@"http://118.25.54.108/";
    
    if (indexPath.row==0) {
        detail.urlString=[NSString stringWithFormat:@"%@protocolapp",kSERVER_HTTP_DXE];
        detail.title=@"用户协议";
    }else{
        detail.urlString=[NSString stringWithFormat:@"%@privacyapp",kSERVER_HTTP_DXE];
        detail.title=@"隐私权政策";
    }
    [self.navigationController pushViewController:detail animated:YES];
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
