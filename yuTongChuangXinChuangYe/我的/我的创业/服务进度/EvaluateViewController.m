//
//  EvaluateViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "EvaluateViewController.h"
#import "RatingBar.h"

@interface EvaluateViewController ()<RatingBarDelegate>
@property(nonatomic,strong)RatingBar *ratingBar;
@property(nonatomic,strong)UILabel *resultLab;
@property(nonatomic,strong)UITextView *textView;

@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发表评价";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
    //
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line1.backgroundColor=RGBAColor(175, 175, 175, 0.5);
    [self.view addSubview:line1];
    //
    UILabel *pingFen=[[UILabel alloc]initWithFrame:CGRectMake(12, 24, 40, 15)];
    pingFen.text=@"评分";
    pingFen.font=[UIFont systemFontOfSize:16];
    pingFen.textColor=RGBAColor(102, 102, 102, 1);
    [self.view addSubview:pingFen];
    //
    self.ratingBar=[[RatingBar alloc]init];
    self.ratingBar.frame=CGRectMake(pingFen.right+72, 22, 149, 16);
    [self.ratingBar setImageDeselected:@"evaluate_star" halfSelected:nil fullSelected:@"evaluate_star_nor" andDelegate:self];
    [self.view addSubview:self.ratingBar];
    //
    self.resultLab=[[UILabel alloc]initWithFrame:CGRectMake(self.ratingBar.right+24, 24, 70, 15)];
    self.resultLab.font=[UIFont systemFontOfSize:16];
    self.resultLab.textColor=RGBAColor(153, 153, 153, 1);
    [self.view addSubview:self.resultLab];
    //
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(10, 60, kScreenWidth-20, 0.5)];
    line2.backgroundColor=RGBAColor(175, 175, 175, 0.5);
    [self.view addSubview:line2];
    //
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(12, line2.bottom+20, kScreenWidth-24, kTableViewHeight-80)];
    self.textView.font=[UIFont systemFontOfSize:14];
    self.textView.textColor=[UIColor colorWithHexString:@"#989898"];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"该服务商的服务您满意吗？在这里写下评论吧！";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = RGBAColor(153, 153, 153, 1);
    [placeHolderLabel sizeToFit];
    [self.textView addSubview:placeHolderLabel];
    placeHolderLabel.font = [UIFont systemFontOfSize:14];
    [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    [self.textView setInputAccessoryView:[SJTool backToolBarView]];
    [self.view addSubview:self.textView];
    
}
-(void)rightClick{
    if ([self.ratingBar rating]<=0) {
        [SJTool showAlertWithText:@"请评分"];
        return;
    }
    if (!self.textView.text.length) {
        [SJTool showAlertWithText:@"请写下评论信息"];
        return;
    }
    NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"id":@(self.demandId),@"providerId":@(self.providerId),@"star":@((int)[self.ratingBar rating]),@"comment":self.textView.text};
    [TDHttpTools gotoEvaluateWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:@"评价成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)ratingChanged:(float)newRating{
    if (newRating<=1.0) {
        self.resultLab.text=@"非常差";
    }else if (newRating>1.0&&newRating<=2.0){
        self.resultLab.text=@"差";
    }else if (newRating>2.0&&newRating<=3.0){
        self.resultLab.text=@"一般";
    }else if (newRating>3.0&&newRating<=4.0){
        self.resultLab.text=@"好";
    }else if (newRating>4.0&&newRating<=5.0){
        self.resultLab.text=@"非常好";
    }
}
-(void)dismissKeyboard:(NSNotification *)noti{
    [self.textView endEditing:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
