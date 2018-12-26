//
//  UploadPlanFileViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "UploadPlanFileViewController.h"

@interface UploadPlanFileViewController ()

@end

@implementation UploadPlanFileViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"上传商业计划书";
    [kNotificationCenter addObserver:self selector:@selector(jumpSelector:) name:@"receivePlanfile" object:nil];
    [self initUI];
}
-(void)initUI{
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 15)];
    lab1.text=@"如何上传";
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont boldSystemFontOfSize:18];
    [self.view addSubview:lab1];
    //
    UILabel *lab2=[[UILabel alloc]init];
    lab2.numberOfLines=0;
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.font=[UIFont systemFontOfSize:16];
    lab2.textColor=[UIColor grayColor];
    lab2.text=@"保持当前页在后台运行,去微信中打开商业计划书,点击右上角分享按钮,选择用其他应用打开,然后选择创客巴士";
    [self.view addSubview:lab2];
    lab2.sd_layout
    .leftSpaceToView(self.view, 40)
    .rightSpaceToView(self.view, 40)
    .topSpaceToView(lab1, 20)
    .autoHeightRatio(0);
}
-(void)jumpSelector:(NSNotification *)noti{
    NSDictionary *dic=noti.userInfo;
    NSString *path=dic[@"path"];
    NSString *filename=[self getFileName:path];
    //NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* thepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Inbox"];//[paths objectAtIndex:0];
    thepath = [thepath stringByAppendingPathComponent:filename];
    
    NSData *data=[NSData dataWithContentsOfFile:thepath];
    
    if (self.CallBack) {
        self.CallBack(@{@"planname":filename,@"filePath":thepath,@"planfile":data});
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//从路径中获取文件名
-(NSString*)getFileName:(NSString*)pFile
{
    NSRange range = [pFile rangeOfString:@"/"options:NSBackwardsSearch];
    return [pFile substringFromIndex:range.location + 1];
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self];
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
