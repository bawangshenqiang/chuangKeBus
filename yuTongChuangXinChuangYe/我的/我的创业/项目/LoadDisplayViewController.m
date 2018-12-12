//
//  LoadDisplayViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "LoadDisplayViewController.h"

@interface LoadDisplayViewController ()<NSURLSessionDelegate>
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation LoadDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"附件";
    // 创建一个下载任务并设置代理
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:self.loadUrl];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
    [task resume];
    
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight)];
        _webView.scalesPageToFit=YES;
        [self.view addSubview:_webView];
    }
    return _webView;
}
#pragma mark -
/**
 下载完毕后调用
 参数：lication 临时文件的路径（下载好的文件）
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    // 创建存储文件路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    // response.suggestedFilename：建议使用的文件名，一般跟服务器端的文件名一致
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    /**将临时文件剪切或者复制到Caches文件夹
     AtPath :剪切前的文件路径
     toPath :剪切后的文件路径
     */
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr moveItemAtPath:location.path toPath:file error:nil];
    
    //webview加载展示文件
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:file]]];
}

/**
 每当下载完一部分时就会调用（可能会被调用多次）
 参数：
 bytesWritten 这次调用下载了多少
 totalBytesWritten 累计写了多少长度到沙盒中了
 totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    // 这里可以做些显示进度等操作
    float progress=totalBytesWritten/totalBytesExpectedToWrite;
    if (progress<1) {
        [SVProgressHUD showProgress:progress status:@"下载中"];
    }else if (progress==1){
        [SVProgressHUD dismiss];
    }
}

/**
 恢复下载时使用
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    // 用于断点续传
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
