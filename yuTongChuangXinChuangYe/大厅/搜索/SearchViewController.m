//
//  SearchViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/1.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SearchViewController.h"
#import "DWQTagView.h"
#import "HistorySearchCell.h"
#import "HotSerachCell.h"
#import "HotSearchModel.h"
#import "SearchDetailViewController.h"

static NSString *const HotCellID = @"HotCellID";
static NSString *const HistoryCellID = @"HistoryCellID";


@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate,DWQTagViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *history;//历史记录
@property (nonatomic, strong) NSMutableArray *HotArr;//热门搜索
/** 得到热门搜索TagView的高度 */
@property (nonatomic ,assign) CGFloat tagViewHeight;
//显示搜索结果
@property(nonatomic,assign)BOOL show;
@property(nonatomic,strong)NSMutableArray *searchResultArr;

@end

@implementation SearchViewController

-(NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)history{
    if (_history==nil) {
        _history=[NSMutableArray array];
    }
    return _history;
}
-(NSMutableArray *)HotArr{
    if (_HotArr==nil) {
        _HotArr=[NSMutableArray array];
    }
    return _HotArr;
}
-(NSMutableArray *)searchResultArr{
    if (_searchResultArr==nil) {
        _searchResultArr=[NSMutableArray array];
    }
    return _searchResultArr;
}
//获取热门搜索关键字
-(void)getHotKey{
    
    [self.dataArr removeAllObjects];
    [self.HotArr removeAllObjects];
    
    self.history=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"searchHistory"]];
    
    NSDictionary *param=@{@"module":@""};
    [TDHttpTools getHotSearchKeyWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            self.HotArr=dic[@"data"];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.searchController.active=YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.searchController.searchBar becomeFirstResponder];
        
        for(id sousuo in [self.searchController.searchBar subviews]) {
            for (id view in [sousuo subviews]) {
                if([view isKindOfClass:[UIButton class]]){
                    UIButton *btn = (UIButton *)view;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                    
                    break;
                }
            }
        }
        
    });
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor colorWithHexString:@"#f9f9f9"];
    [self.tableView registerClass:[HotSerachCell class] forCellReuseIdentifier:HotCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"HistorySearchCell" bundle:nil] forCellReuseIdentifier:HistoryCellID];
    [self.view addSubview:self.tableView];
    
    [self getHotKey];
    
    self.searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater=self;
    self.searchController.delegate=self;
    self.searchController.searchBar.delegate=self;
    
    self.definesPresentationContext=YES;
    self.searchController.searchBar.tintColor=[UIColor whiteColor];
    self.searchController.searchBar.barTintColor=kThemeColor;
    
    //设置搜索时，背景变暗色，默认YES
    _searchController.dimsBackgroundDuringPresentation = NO;
    //设置搜索时，背景变模糊，默认YES
    if (@available(iOS 9.1, *)) {
        _searchController.obscuresBackgroundDuringPresentation = NO;
    } else {
        // Fallback on earlier versions
    }
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = YES;
    
    _searchController.searchBar.frame=CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView= _searchController.searchBar;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.show) {
        return 1;
    }else{
        if (self.history.count==0) {
            return 1;
        }else{
            return 2;
        }
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.show) {
        return self.searchResultArr.count;
    }else{
        if (self.history.count==0) {
            return 1;
        }else{
            if (section==0) {
                return self.history.count;
            }else{
                return 1;
            }
        }
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.show) {
        HistorySearchCell *HistoryCell = [tableView dequeueReusableCellWithIdentifier:HistoryCellID forIndexPath:indexPath];
        HistoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        HistoryCell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 1000);
        HistoryCell.removeTagBtn.hidden=YES;
        HistoryCell.tagNameLab.text = self.searchResultArr[indexPath.row];
        
        return HistoryCell;
    }else{
        if (self.history.count == 0) {
            HotSerachCell *hotCell = [tableView dequeueReusableCellWithIdentifier:HotCellID forIndexPath:indexPath];
            
            hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
            hotCell.userInteractionEnabled = YES;
            hotCell.hotSearchArr = self.HotArr;
            hotCell.dwqTagV.delegate = self;
            /** 将通过数组计算出的tagV的高度存储 */
            self.tagViewHeight = hotCell.dwqTagV.frame.size.height;
            return hotCell;
        }
        else
        {
            if (indexPath.section == 0) {
                HistorySearchCell *HistoryCell = [tableView dequeueReusableCellWithIdentifier:HistoryCellID forIndexPath:indexPath];
                HistoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
                HistoryCell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 1000);
                HistoryCell.removeTagBtn.hidden=NO;
                HistoryCell.tagNameLab.text = self.history[indexPath.row];
                
                [HistoryCell.removeTagBtn addTarget:self action:@selector(removeSingleTagClick:) forControlEvents:UIControlEventTouchUpInside];
                HistoryCell.removeTagBtn.tag = 250 + indexPath.row;
                
                return HistoryCell;
                
            }
            else
            {
                HotSerachCell *hotCell = [tableView dequeueReusableCellWithIdentifier:HotCellID forIndexPath:indexPath];
                hotCell.dwqTagV.delegate = self;
                hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
                hotCell.backgroundColor=[UIColor whiteColor];
                hotCell.userInteractionEnabled = YES;
                hotCell.hotSearchArr = self.HotArr;
                /** 将通过数组计算出的tagV的高度存储 */
                self.tagViewHeight = hotCell.dwqTagV.frame.size.height;
                return hotCell;
            }
        }
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.history.count>0&&indexPath.section==0&&!self.show) {
        self.searchController.searchBar.text=self.history[indexPath.row];
        SearchDetailViewController *searchDetailVC=[[SearchDetailViewController alloc]init];
        searchDetailVC.name=self.history[indexPath.row];
        [self.navigationController pushViewController:searchDetailVC animated:YES];
        
    }
    if (self.show) {
        
        
        
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    headView.backgroundColor = [UIColor colorWithWhite:0.922 alpha:1.000];
    for (UILabel *lab in headView.subviews) {
        [lab removeFromSuperview];
    }
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width - 15, 44)];
    titleLab.textColor = [UIColor colorWithWhite:0.229 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:14];
    [headView addSubview:titleLab];
    if (self.show) {
        titleLab.text=@"";
    }else{
        if (self.history.count == 0) {
            
            titleLab.text = @"热门搜索";
        }
        else
        {
            if (section == 0) {
                titleLab.text = @"";
            }
            else
            {
                titleLab.text = @"热门搜索";
                
            }
        }
    }
    
    return headView;
}
/** FooterView */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.show) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1)];
        return view;
    }else{
        if (self.history.count>0&&section == 0) {
            UIButton *removeAllHistory = [UIButton buttonWithType:0];
            removeAllHistory.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
            removeAllHistory.backgroundColor = [UIColor whiteColor];
            [removeAllHistory setTitleColor:kThemeColor forState:0];
            [removeAllHistory setTitle:@"清空搜索记录" forState:0];
            removeAllHistory.titleLabel.font = [UIFont systemFontOfSize:16];
            [removeAllHistory addTarget:self action:@selector(removeAllHistoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            return removeAllHistory;
        }
        else
        {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1)];
            return view;
        }
    }
    
}
/** 头部的高 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.show) {
        return 0.1;
    }else{
        if (self.history.count==0) {
            return 44;
        }else{
            if (section==0) {
                return 0.1;
            }else{
                return 44;
            }
        }
    }
    
}

/** FooterView的高 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.show) {
        return 0.1;
    }else{
        if (self.history.count == 0) {
            return 0.1;
        }
        else
        {
            if (section == 0) {
                return 44;
            }
            else
            {
                return 0.1;
            }
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.show) {
        return 44;
    }else{
        if (self.history.count == 0) {
            
            return self.tagViewHeight + 40;
        }
        else
        {
            if (indexPath.section == 1) {
                return self.tagViewHeight + 40;
            }
            else
            {
                return 44;
            }
        }
    }
    
}
-(void)removeSingleTagClick:(UIButton *)removeBtn
{
    NSArray * myArray = [[NSUserDefaults standardUserDefaults] arrayForKey:@"searchHistory"];
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT removeObjectAtIndex:removeBtn.tag-250];
    [[NSUserDefaults standardUserDefaults] setObject:searTXT forKey:@"searchHistory"];
    [self.history removeObjectAtIndex:removeBtn.tag - 250];
    
    [self.tableView reloadData];
}
-(void)removeAllHistoryBtnClick{
    
    NSArray * myArray = [[NSUserDefaults standardUserDefaults] arrayForKey:@"searchHistory"];
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:searTXT forKey:@"searchHistory"];
    [self.history removeAllObjects];
    [self.tableView reloadData];
}
#pragma mark -- 实现点击热门搜索tag  Delegate
-(void)DWQTagView:(UIView *)dwq fetchWordToTextFiled:(NSString *)KeyWord
{
    //NSLog(@"点击了%@",KeyWord);
    self.searchController.searchBar.text=KeyWord;
    SearchDetailViewController *searchDetailVC=[[SearchDetailViewController alloc]init];
    searchDetailVC.name=KeyWord;
    [self.navigationController pushViewController:searchDetailVC animated:YES];
    [self SearchText:self.searchController.searchBar.text];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchController.searchBar resignFirstResponder];
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    [self.dataArr removeAllObjects];
    [self.searchResultArr removeAllObjects];
    
//    [TDHttpTools showSearchResultWithCity:self.city name:searchController.searchBar.text success:^(id response) {
//        id aDic=[NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
//        if ([aDic isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *dic=(NSDictionary *)aDic;
//            NSLog(@"%@",dic);
//            if ([dic[@"Flag"] intValue]==2){
//                for (NSDictionary *d in dic[@"Data"]) {
//                    HotSearchModel *hotSearchModel=[[HotSearchModel alloc]initWithDictionary:d];
//                    [self.searchResultArr addObject:hotSearchModel.resName];
//                    [self.dataArr addObject:hotSearchModel];
//                }
//                [self.tableView reloadData];
//            }
//        }
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    /**
    self.searchResultArr=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    self.show=YES;
    if (searchController.searchBar.text.length==0) {
        self.show=NO;
    }
    [self.tableView reloadData];
    */
}
-(void)SearchText :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:@"searchHistory"]];
    
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [NSMutableArray array];
    searTXT = [myArray mutableCopy];
    
    BOOL isEqualTo1,isEqualTo2;
    isEqualTo1 = NO;
    isEqualTo2 = NO;
    
    if (searTXT.count > 0) {
        isEqualTo2 = YES;
        //判断搜索内容是否存在，存在的话放到数组最后一位，不存在的话添加。
        for (NSString * str in myArray) {
            if ([seaTxt isEqualToString:str]) {
                //获取指定对象的索引
                NSUInteger index = [myArray indexOfObject:seaTxt];
                [searTXT removeObjectAtIndex:index];
                [searTXT addObject:seaTxt];
                isEqualTo1 = YES;
                break;
            }
        }
    }
    
    if (!isEqualTo1 || !isEqualTo2) {
        [searTXT addObject:seaTxt];
    }
    
    if(searTXT.count > 10)
    {
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    self.history=searTXT;
    
    [userDefaultes setObject:self.history forKey:@"searchHistory"];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    SearchDetailViewController *searchDetailVC=[[SearchDetailViewController alloc]init];
    searchDetailVC.name=searchBar.text;
    [self.navigationController pushViewController:searchDetailVC animated:YES];
    [self SearchText:self.searchController.searchBar.text];
    
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if (self.searchController.searchBar.text.length && self.BackTitleBlock) {
        self.BackTitleBlock(self.searchController.searchBar.text);
    }
    //self.searchController.active=NO;
    
    [self.navigationController popViewControllerAnimated:YES];
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
