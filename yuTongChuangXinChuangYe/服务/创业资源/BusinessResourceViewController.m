//
//  BusinessResourceViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "BusinessResourceViewController.h"
#import "SDCycleScrollView.h"
#import "ResourceLeftCell.h"
#import "ResourceRightCell.h"
#import "ResourceLeftModel.h"
#import "ResourceRightModel.h"
#import "ServerDetailViewController.h"
#import "HomePageImgModel.h"
#import "ResourceHeaderView.h"

@interface BusinessResourceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *rightTableView;
@property(nonatomic,strong)NSMutableArray *data_left;
@property(nonatomic,strong)NSMutableArray *imageArr;

@end

@implementation BusinessResourceViewController

-(NSMutableArray *)data_left{
    if (!_data_left) {
        _data_left=[NSMutableArray array];
    }
    return _data_left;
}

-(void)getData{
    /**
    NSArray *arr=@[@{@"title":@"法务",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""}]},@{@"title":@"财税",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""}]},@{@"title":@"供应链",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""}]},@{@"title":@"专利",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""}]},@{@"title":@"人事",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""}]},@{@"title":@"融资",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""}]},@{@"title":@"工商",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""}]},@{@"title":@"软件开发",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""}]},@{@"title":@"工业设计",@"rightModel":@[@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""},@{@"imageUrl":@""}]}];
    for (NSDictionary *dic in arr) {
        ResourceLeftModel *model=[[ResourceLeftModel alloc]initWithDictionary:dic];
        [self.data_left addObject:model];
    }
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    */
    
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token};
    [TDHttpTools providerListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        
        NSLog(@"%@",dic);
        
        
        if ([dic[@"code"] intValue]==200) {
            NSDictionary *data=dic[@"data"];
            
            NSMutableArray *urlArr=[NSMutableArray array];
            for (NSDictionary *dict in data[@"carousels"]) {
                HomePageImgModel *model=[[HomePageImgModel alloc]initWithDictionary:dict];
                [self.imageArr addObject:model];
                [urlArr addObject:model.TopImgUrl];
            }
            self.cycleScrollView.imageURLStringsGroup=urlArr;
            
            for (NSDictionary *dict in data[@"resources"]) {
                ResourceLeftModel *model=[[ResourceLeftModel alloc]initWithDictionary:dict];
                [self.data_left addObject:model];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
    self.title=@"创业资源";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //
    NSArray *imageArr=@[@"图片3.jpg",@"图片3.jpg"];
    self.cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 145) imageNamesGroup:imageArr];
    [self.view addSubview:self.cycleScrollView];
    //
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self getData];
}
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(5, self.cycleScrollView.bottom+10, 50, kTableViewHeight-self.cycleScrollView.height-10) style:UITableViewStylePlain];
        _leftTableView.delegate=self;
        _leftTableView.dataSource=self;
        _leftTableView.layer.cornerRadius=5;
        _leftTableView.layer.masksToBounds=YES;
        _leftTableView.backgroundColor=[UIColor colorWithHexString:@"#f0f6f9"];
        _leftTableView.tableFooterView=[UIView new];
        _leftTableView.showsVerticalScrollIndicator=NO;
        
    }
    return _leftTableView;
}
-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(self.leftTableView.right, self.cycleScrollView.bottom+10, kScreenWidth-self.leftTableView.right, kTableViewHeight-self.cycleScrollView.height-10) style:UITableViewStylePlain];
        _rightTableView.delegate=self;
        _rightTableView.dataSource=self;
        //_rightTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _rightTableView.tableFooterView=[UIView new];
    }
    return _rightTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return 1;
    }else{
        return self.data_left.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView ==self.leftTableView) {
        return self.data_left.count;
    }else{
        if (self.data_left.count>0) {
            ResourceLeftModel *model=self.data_left[section];
            
            return model.rightModels.count;
        }else{
            return 0;
        }
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        NSString *cellID1=@"cellID1";
        ResourceLeftCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell=[[ResourceLeftCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
            cell.contentView.backgroundColor=[UIColor colorWithHexString:@"#f0f6f9"];
            cell.separatorInset=UIEdgeInsetsMake(0, -15, 0, 0);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        ResourceLeftModel *model=self.data_left[indexPath.row];
//        if (indexPath.row==0) {
//
//            [cell setSelected:YES];
//        }
        cell.leftModel=model;
        
        return cell;
    }else{
        
        NSString *cellID2=@"cellID2";
        ResourceRightCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell) {
            cell=[[ResourceRightCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID2];
            cell.separatorInset=UIEdgeInsetsMake(0, 5, 0, 10);
        }
        ResourceLeftModel *model_left=self.data_left[indexPath.section];
        ResourceRightModel *model=model_left.rightModels[indexPath.row];
        cell.model=model;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        ResourceLeftModel *model=self.data_left[indexPath.row];
        CGFloat height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"leftModel" cellClass:[ResourceLeftCell class] contentViewWidth:50];
        return height;
    }else{
        return 80;
    }
}

//MARK: - 一个方法就能搞定 右边滑动时跟左边的联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 如果是 左侧的 tableView 直接return
    if (scrollView == self.leftTableView) return;
    
    // 取出显示在 视图 且最靠上 的 cell 的 indexPath
    NSIndexPath *topHeaderViewIndexpath = [[self.rightTableView indexPathsForVisibleRows] firstObject];
    
    if (topHeaderViewIndexpath!=nil) {
        // 左侧 talbelView 移动的 indexPath
        NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
        
        // 移动 左侧 tableView 到 指定 indexPath 居中显示
        [self.leftTableView selectRowAtIndexPath:moveToIndexpath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

//MARK: - 点击 cell 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 选中 左侧 的 tableView
    if (tableView == self.leftTableView) {
        
        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];

        // 将右侧 tableView 移动到指定位置
        [self.rightTableView selectRowAtIndexPath:moveToIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];

        // 取消选中效果
        [self.rightTableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
        
    }else{
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        ResourceLeftModel *model_left=self.data_left[indexPath.section];
        ResourceRightModel *model=model_left.rightModels[indexPath.row];
        
        ServerDetailViewController *detailVC=[ServerDetailViewController new];
        detailVC.providerId=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
//不能带分区头或尾，要不就滑动的时候左边选不准了
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.rightTableView]) {
        NSString *headerSection=@"headerSection";
        ResourceHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSection];
        if (!header) {
            header=[[ResourceHeaderView alloc]initWithReuseIdentifier:headerSection];
            header.contentView.backgroundColor=[UIColor colorWithHexString:@"#f0f6f9"];//kBackgroundColor;
        }
        if (self.data_left.count>0) {
            ResourceLeftModel *model=self.data_left[section];
            header.titleLab.text=model.title;
        }
        return header;
    }
    return nil;
}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
//    view.tintColor=kBackgroundColor;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.rightTableView]) {
        return 30;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
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
