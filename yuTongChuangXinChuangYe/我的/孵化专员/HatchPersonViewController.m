//
//  HatchPersonViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HatchPersonViewController.h"

@interface HatchPersonViewController ()
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UILabel *bottomLab;
@property(nonatomic,strong)NSString *telephone;
@end

@implementation HatchPersonViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"孵化专员";
    self.view.backgroundColor=kBackgroundColor;
    
    UIImageView *backIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth-20, 115)];
    backIV.image=[UIImage imageNamed:@"incubation_bg"];
    backIV.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackIV)];
    [backIV addGestureRecognizer:tap];
    [self.view addSubview:backIV];
    //
    UIImageView *headerIV=[[UIImageView alloc]initWithFrame:CGRectMake(20, (115-45)/2, 45, 45)];
    headerIV.image=[UIImage imageNamed:@"incubation_headportrait"];
    [backIV addSubview:headerIV];
    //
    self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(headerIV.right+20, headerIV.y, 230, 15)];
    self.topLab.text=@"辅导员：";
    self.topLab.font=[UIFont boldSystemFontOfSize:18];
    self.topLab.textColor=[UIColor whiteColor];
    [backIV addSubview:self.topLab];
    //
    self.bottomLab=[[UILabel alloc]initWithFrame:CGRectMake(headerIV.right+20, self.topLab.bottom+15, self.topLab.width, 15)];
    self.bottomLab.textColor=[UIColor whiteColor];
    self.bottomLab.text=@"联系方式：";
    self.bottomLab.font=[UIFont boldSystemFontOfSize:18];
    [backIV addSubview:self.bottomLab];
    
    //
    [self getData];
}
-(void)getData{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token};
    [TDHttpTools getHatchPersonWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            self.topLab.text=[NSString stringWithFormat:@"辅导员：%@",dic[@"data"][@"instructor"]];
            self.bottomLab.text=[NSString stringWithFormat:@"联系方式：%@",dic[@"data"][@"linkphone"]];
            self.telephone=dic[@"data"][@"linkphone"];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
-(void)clickBackIV{
    //NSLog(@"打电话");
    if (self.telephone.length==11) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", self.telephone];
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
