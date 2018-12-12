//
//  ChuangYiAuditViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/10.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ChuangYiAuditViewController.h"

@interface ChuangYiAuditViewController ()
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UILabel *bottomLab;
@property(nonatomic,strong)NSString *telephone;
@end

@implementation ChuangYiAuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    [self initView];
    [self getData];
}
-(void)initView{
    UIView *backView=[[UIView alloc]init];
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.cornerRadius=4;
    [self.view addSubview:backView];
    //
    UILabel *auditStatus_left=[[UILabel alloc]init];
    auditStatus_left.font=[UIFont systemFontOfSize:14];
    auditStatus_left.textColor=RGBAColor(112, 112, 112, 1);
    auditStatus_left.text=@"审核状态";
    [backView addSubview:auditStatus_left];
    //
    UILabel *auditStatus_right=[[UILabel alloc]init];
    auditStatus_right.text=self.model.checkStatus;
    auditStatus_right.font=[UIFont systemFontOfSize:14];
    
    if (self.model.statusId==0 || self.model.statusId==3) {
        auditStatus_right.textColor=RGBAColor(102, 102, 102, 1);//[UIColor colorWithHexString:@"#f3932b"];
    }else if (self.model.statusId==1){
        auditStatus_right.textColor=RGBAColor(0, 92, 175, 1);//[UIColor colorWithHexString:@"#00e01a"];
    }else if(self.model.statusId==2){
        auditStatus_right.textColor=[UIColor redColor];
    }
    [backView addSubview:auditStatus_right];
    //
    UILabel *auditIdea_left=[[UILabel alloc]init];
    auditIdea_left.font=[UIFont systemFontOfSize:14];
    auditIdea_left.textColor=RGBAColor(112, 112, 112, 1);
    auditIdea_left.text=@"审核意见";
    [backView addSubview:auditIdea_left];
    //
    UILabel *auditIdea_right=[[UILabel alloc]init];
    auditIdea_right.font=[UIFont systemFontOfSize:14];
    auditIdea_right.textColor=RGBAColor(51, 51, 51, 1);
    auditIdea_right.text=self.model.checkIdea;
    auditIdea_right.numberOfLines=0;
    [backView addSubview:auditIdea_right];
    
    //
    auditStatus_left.sd_layout
    .leftSpaceToView(backView, 12)
    .topSpaceToView(backView, 30)
    .heightIs(15);
    [auditStatus_left setSingleLineAutoResizeWithMaxWidth:100];
    //
    auditStatus_right.sd_layout
    .leftSpaceToView(auditStatus_left, 20)
    .centerYEqualToView(auditStatus_left)
    .heightIs(15);
    [auditStatus_right setSingleLineAutoResizeWithMaxWidth:150];
    //
    auditIdea_left.sd_layout
    .leftEqualToView(auditStatus_left)
    .topSpaceToView(auditStatus_left, 20)
    .heightIs(15);
    [auditIdea_left setSingleLineAutoResizeWithMaxWidth:100];
    //
    auditIdea_right.sd_layout
    .leftEqualToView(auditStatus_right)
    .topEqualToView(auditIdea_left)
    .rightSpaceToView(backView, 12)
    .autoHeightRatio(0);
    //
    backView.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10);
    [backView setupAutoHeightWithBottomView:auditIdea_right bottomMargin:30];
    
    //
    UIImageView *backIV=[[UIImageView alloc]init];//WithFrame:CGRectMake(10, backView.bottom+30, kScreenWidth-20, 115)
    //backIV.image=[UIImage imageNamed:@"incubation_bg"];
    backIV.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackIV)];
    [backIV addGestureRecognizer:tap];
    [self.view addSubview:backIV];
    
    backIV.sd_layout
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .topSpaceToView(backView, 30)
    .heightIs(115);
    //直接获取backIV的frame获取不到，导致无法直接在backIV上做渐变色，所以给它加一个确定frame的子view
    UIView *aview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 115)];
    [backIV addSubview:aview];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)RGBAColor(129, 99, 255, 1).CGColor, (__bridge id)RGBAColor(102, 162, 255, 1).CGColor];
    //, (__bridge id)[UIColor colorWithHexString:@"0384dd"].CGColor
    gradientLayer.locations = @[@0.0, @1.0];//, @0.5
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = aview.frame;
    gradientLayer.cornerRadius=4;
    gradientLayer.masksToBounds=YES;
    [backIV.layer addSublayer:gradientLayer];
    //
    UIImageView *headerIV=[[UIImageView alloc]initWithFrame:CGRectMake(20, (115-45)/2, 45, 45)];
    headerIV.image=[UIImage imageNamed:@"incubation_headportrait"];
    [backIV addSubview:headerIV];
    //
    self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(headerIV.right+20, headerIV.y, 230, 15)];
    //self.topLab.text=[NSString stringWithFormat:@"孵化专员：%@",self.model.instructor];
    self.topLab.font=[UIFont boldSystemFontOfSize:18];
    self.topLab.textColor=[UIColor whiteColor];
    [backIV addSubview:self.topLab];
    //
    self.bottomLab=[[UILabel alloc]initWithFrame:CGRectMake(headerIV.right+20, self.topLab.bottom+15, self.topLab.width, 15)];
    self.bottomLab.textColor=[UIColor whiteColor];
    //self.bottomLab.text=[NSString stringWithFormat:@"联系方式：%@",self.model.linkphone];
    self.bottomLab.font=[UIFont boldSystemFontOfSize:18];
    [backIV addSubview:self.bottomLab];
    
//    //
    
}
-(void)getData{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"username":self.model.username};
    [TDHttpTools getHatchPersonWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            self.topLab.text=[NSString stringWithFormat:@"孵化专员：%@",dic[@"data"][@"instructor"]];
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
