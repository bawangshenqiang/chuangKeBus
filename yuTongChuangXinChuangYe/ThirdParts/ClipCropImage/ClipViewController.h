//
//  ClipViewController.h
//  MSClipDemo
//
//  Created by MelissaShu on 17/6/15.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    CIRCULARCLIP   = 0,   //圆形裁剪
    SQUARECLIP            //方形裁剪
    
}ClipType;

@class ClipViewController;
@protocol ClipVCDelegate <NSObject>

-(void)clipViewController:(ClipViewController *)clipViewController finishClipImage:(UIImage *)editImage;

@end

@interface ClipViewController : UIViewController

@property (nonatomic, assign) ClipType clipType;  //裁剪的形状
@property (nonatomic, strong) id<ClipVCDelegate>delegate;

-(instancetype)initWithImage:(UIImage *)image; //默认方形裁剪框

-(instancetype)initWithImage:(UIImage *)image clipSize:(CGSize)clipSize;

//圆形裁剪
-(instancetype)initWithImage:(UIImage *)image radius:(CGFloat)radius;

@end
