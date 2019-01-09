//
//  CustomSharedView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CustomSharedView.h"
#import "shareSmallLzhGroupView.h"
#import <ShareSDK/ShareSDK.h>

@interface CustomSharedView()
@property(nonatomic,assign)CGFloat height_Big;

@end

@implementation CustomSharedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.height_Big=frame.size.height;
        
        self.shadeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.shadeView.backgroundColor=RGBAColor(0, 0, 0, 0.5);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteShadeView:)];
        [self.shadeView addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:self.shadeView];
        
        self.bigView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, frame.size.height)];
        self.bigView.backgroundColor=[UIColor whiteColor];
        [self.shadeView addSubview:self.bigView];
        
        //
        UILabel *topLabel = [[UILabel alloc]init];
        topLabel.frame = CGRectMake(0, 0, frame.size.width, 40);
        topLabel.text = @"分享到";
        topLabel.font=[UIFont systemFontOfSize:15];
        topLabel.textAlignment=NSTextAlignmentCenter;
        [self.bigView addSubview:topLabel];
        //
        CGFloat width = 60;
        CGFloat horizontalSpace = (frame.size.width - 4 * width) / 5;
        //
        NSArray *titleArr = @[@"微信朋友圈",@"微信好友"];
        NSMutableArray *imageArr = [NSMutableArray array];
        for (int k = 0; k < 2; k ++){
            NSString *imageStr = [NSString stringWithFormat:@"share0%d",k];
            [imageArr addObject:[UIImage imageNamed:imageStr]];
        }
        
        //
        for (int k = 0; k < 2; k ++){
            shareSmallLzhGroupView *smallView = [[shareSmallLzhGroupView alloc]initWithFrame:CGRectMake(horizontalSpace +  (k % 4) * horizontalSpace + (k % 4) * width, topLabel.bottom+10, width, width * 1.2)];
            //
            [smallView.backButt addTarget:self action:@selector(clickButt:) forControlEvents:UIControlEventTouchUpInside];
            //
            [smallView.topImageView setImage:imageArr[k]];
            smallView.backButt.tag = 1100+k;
            smallView.botLabel.text = titleArr[k];
            [self.bigView addSubview:smallView];
        }
        
        [self show];
    }
    return self;
}
- (void)clickButt:(UIButton*)_b{
    
    [self dismiss];
    
    //后期换成logo
    NSString *image=@"yutong_logo";
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:self.content
                                     images:image
                                        url:[NSURL URLWithString:self.url]
                                      title:self.title
                                       type:SSDKContentTypeAuto];
    switch (_b.tag-1100) {
        case 0://微信朋友圈
        {
            //
            [shareParams SSDKSetupWeChatParamsByText:self.content                title:self.title
                                                 url:[NSURL URLWithString:self.url]
                                          thumbImage:nil
                                               image:image
                                        musicFileURL:nil
                                             extInfo:nil
                                            fileData:nil
                                        emoticonData:nil
                                                type:SSDKContentTypeAuto  forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                if (error){
                    NSLog(@"微信朋友圈分享出错%@",error);
                }
            }];
            
        }
            break;
        case 1://微信好友
        {
            //
            [shareParams SSDKSetupWeChatParamsByText:self.content                 title:self.title
                                                 url:[NSURL URLWithString:self.url]
                                          thumbImage:nil
                                               image:image
                                        musicFileURL:nil
                                             extInfo:nil
                                            fileData:nil
                                        emoticonData:nil
                                                type:SSDKContentTypeAuto  forPlatformSubType:SSDKPlatformSubTypeWechatSession];
            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                if (error){
                    NSLog(@"微信好友分享出错%@",error);
                }
            }];
        }
            break;
        
        default:
            break;
    }
}
-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        self.bigView.transform=CGAffineTransformMakeTranslation(0, -self.height_Big);
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.bigView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        [self.bigView removeFromSuperview];
        [self.shadeView removeFromSuperview];
        
    }];
}
-(void)deleteShadeView:(UITapGestureRecognizer *)tap{
    
    [self dismiss];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
