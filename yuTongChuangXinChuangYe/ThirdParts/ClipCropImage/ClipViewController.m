//
//  ClipViewController.m
//  MSClipDemo
//
//  Created by MelissaShu on 17/6/15.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import "ClipViewController.h"
#import "UIView+MJExtension.h"

#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ClipViewController ()<UIGestureRecognizerDelegate>
{
    UIImageView *_imageView;
    UIImage *_image;
    UIView * _overView;
    CGFloat _clipH;
    CGFloat _clipW;
}


@property (nonatomic, assign)CGRect clipFrame; //裁剪框的frame
@property (nonatomic, assign)CGRect currentFrame;   //图片当前frame

@end

@implementation ClipViewController


static const CGFloat scaleRation = 10;  //图片缩放的最大倍数
static const CGFloat kClipW = 300;  //裁剪框-宽
static const CGFloat kClipH = 180;  //裁剪框-高

-(instancetype)initWithImage:(UIImage *)image
{
    if(self = [super init])
    {
        _clipH = kClipH;
        _clipW = kClipW;
        
        _clipType = SQUARECLIP;
        _image = image;
        
        [self setUpView];
        
    }
    return  self;
}

-(instancetype)initWithImage:(UIImage *)image clipSize:(CGSize)clipSize
{
    if(self = [super init])
    {
        
        if (clipSize.height > 0 && clipSize.height < kSCREEN_HEIGHT ) {
            _clipH = clipSize.height;
        }else{
            _clipH = kClipH;
        }
        
        if (clipSize.width > 0 && clipSize.width < kSCREEN_WIDTH ) {
            _clipW = clipSize.width;
        }else{
            _clipW = kClipW;
        }
        
        _clipType = SQUARECLIP;
        _image = image;
        
    }
    return self;
}

//圆形裁剪
-(instancetype)initWithImage:(UIImage *)image radius:(CGFloat)radius{
    
    if(self = [super init])
    {
        _clipType = CIRCULARCLIP;
        if (radius > 0 && radius < kSCREEN_WIDTH * 0.5) {
            _clipH = radius * 2;
            _clipW = radius * 2;
        }else{
            _clipH = kClipW;
            _clipW = kClipW;
        }
        _image = image;
    }
    
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"裁剪图片";
    [self setUpView];
    [self addAllGesture];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)setUpView
{
    
    CGFloat clipX = (self.view.mj_w - _clipW)*0.5;
    CGFloat clipY = (self.view.mj_h - _clipH - kStatusBarHeight-44)*0.5;
    
    self.clipFrame = CGRectMake(clipX, clipY, _clipW, _clipH);
    
    //验证 裁剪半径是否有效
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _imageView = [[UIImageView alloc]initWithImage:_image];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSLog(@"_image : %f %f",_image.size.width,_image.size.height);
    [self.view addSubview:_imageView];
    
    CGRect newFrame;
    newFrame.size = [self handleScale];
    newFrame.origin = [self handleCenterWithSize:newFrame.size];
    
    _imageView.frame = newFrame;
    
    //覆盖层
    _overView = [[UIView alloc]init];
    [_overView setBackgroundColor:[UIColor clearColor]];
    _overView.opaque = NO;
    [_overView setFrame:CGRectMake(0, 0, self.view.mj_h, self.view.mj_h )];
    [self.view addSubview:_overView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(clipBtnSelected)];
    
    [self drawClipPath];
    [self makeImageViewFrameAdaptToClipFrame];
}


#pragma mark - 绘制裁剪框
-(void)drawClipPath
{
    
    UIBezierPath *path= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *clipPath;
    
    if (self.clipType == SQUARECLIP) {//方形
        clipPath = [UIBezierPath bezierPathWithRect:self.clipFrame];
    }else{
       
        clipPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.clipFrame), CGRectGetMidY(self.clipFrame)) radius:_clipW * 0.5 startAngle:0 endAngle:2*M_PI clockwise:NO];
    }
    [path appendPath:clipPath];
    
    [path setUsesEvenOddFillRule:YES];
    layer.path = path.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    
    layer.fillColor = [[UIColor blackColor] CGColor];
    layer.opacity = 0.5;
    
    [_overView.layer addSublayer:layer];
    
    //添加白线
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _overView.bounds;
    shapeLayer.path = clipPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    [_overView.layer addSublayer:shapeLayer];
    
}

#pragma mark - 让图片自适应裁剪框的大小
-(void)makeImageViewFrameAdaptToClipFrame
{
    CGFloat width = _imageView.mj_w ;//原来是_imageView.mj_h
    CGFloat height = _imageView.mj_h;
    if(height < _clipH)
    {
        width = (width / height) * _clipH;
        height = _clipH;
        CGRect frame = CGRectMake(0, 0, width, height);
        [_imageView setFrame:frame];
        [_imageView setCenter:self.view.center];
    }
}

#pragma mark - 添加手势
-(void)addAllGesture
{
    //捏合手势
    UIPinchGestureRecognizer * pinGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinGesture:)];
    pinGesture.delegate = self;
    [self.view addGestureRecognizer:pinGesture];
    //拖动手势
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}


#pragma mark - 处理捏合

-(void)handlePinGesture:(UIPinchGestureRecognizer *)pinGesture
{
    UIView * view = _imageView;
    if(pinGesture.state == UIGestureRecognizerStateBegan || pinGesture.state == UIGestureRecognizerStateChanged)
    {
        view.transform = CGAffineTransformScale(_imageView.transform, pinGesture.scale,pinGesture.scale);
        pinGesture.scale = 1.0;
    }
    else if(pinGesture.state == UIGestureRecognizerStateEnded)
    {
        
        CGFloat ration =  view.mj_h /_image.size.height;
        
        CGRect newFrame;
        if(ration>scaleRation) // 缩放倍数 > 自定义的最大倍数
        {
            newFrame =CGRectMake(0, 0, _image.size.width * scaleRation, _image.size.height * scaleRation);
            view.frame = newFrame;
            
        }else if (view.mj_h < _clipH || view.mj_w < _clipW)
        {
            newFrame.size = [self handleScale];
            
            newFrame.origin = [self handleCenterWithSize:newFrame.size];
        }
        else
        {
            newFrame = [self handlePosition:view];
        }
        
        [UIView animateWithDuration:0.05 animations:^{
            
            view.frame = newFrame;
            self.currentFrame = view.frame;
        }];
        
    }
}

#pragma mark - 处理拖动
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    UIView * view = _imageView;
    
    if(panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [panGesture translationInView:view.superview];
        
        //NSLog(@"state : %ld , translation : %@",(long)panGesture.state,NSStringFromCGPoint(translation));
        
        [view setCenter:CGPointMake(view.center.x + translation.x, view.center.y + translation.y)];
        
        [panGesture setTranslation:CGPointZero inView:view.superview];
    }
    else if ( panGesture.state == UIGestureRecognizerStateEnded)
    {
        CGRect currentFrame = view.frame;
        
        //        NSLog(@"\n  clipFrame : %@ \n currentFrame : %@",NSStringFromCGRect(self.clipFrame),NSStringFromCGRect(currentFrame));
        
        currentFrame = [self handlePosition:view];
        
        [UIView animateWithDuration:0.05 animations:^{
            [view setFrame:currentFrame];
        }];
        
        //NSLog(@"currentFrame : %@",NSStringFromCGRect(currentFrame));
    }
}

#pragma mark -
#pragma mark -- 居中显示
- (CGPoint)handleCenterWithSize:(CGSize)size{
    CGPoint point;
    point.x = CGRectGetMidX(_clipFrame) - size.width * 0.5;
    point.y = CGRectGetMidY(_clipFrame) - size.height * 0.5;
    return point;
}

#pragma mark -- 缩放结束后 确保图片在裁剪框内
-(CGRect )handlePosition:(UIView *)view
{
    
    // 图片.top < 裁剪框.top
    if(view.frame.origin.y > self.clipFrame.origin.y)
    {
        CGRect viewFrame = view.frame;
        viewFrame.origin.y = self.clipFrame.origin.y;
        view.frame = viewFrame;
    }
    // 图片.left < 裁剪框.left
    if(view.frame.origin.x > self.clipFrame.origin.x)
    {
        CGRect viewFrame = view.frame;
        viewFrame.origin.x = self.clipFrame.origin.x;
        view.frame = viewFrame;
    }
    
    // 图片.right < 裁剪框.right
    if(CGRectGetMaxX(view.frame)< CGRectGetMaxX(self.clipFrame))
    {
        CGFloat right =CGRectGetMaxX(view.frame);
        CGRect viewFrame = view.frame;
        CGFloat space = CGRectGetMaxX(self.clipFrame) - right;
        viewFrame.origin.x+=space;
        view.frame = viewFrame;
    }
    
    // 图片.bottom < 裁剪框.bottom
    if(CGRectGetMaxY(view.frame) < CGRectGetMaxY(self.clipFrame))
    {
        CGRect viewFrame = view.frame;
        CGFloat space = CGRectGetMaxY(self.clipFrame) - (CGRectGetMaxY(view.frame));
        viewFrame.origin.y +=space;
        view.frame = viewFrame;
    }
    
    return view.frame;
}


#pragma mark -- 处理图片大小
-(CGSize )handleScale
{
    CGFloat oriRate = _image.size.width / _image.size.height;
    CGFloat clipRate = _clipW / _clipH;
    
    CGSize resultSize;
    
    if (oriRate > clipRate) {
        resultSize.height = _clipH;
        resultSize.width = oriRate * _clipH;
    }else{
        resultSize.width = _clipW;
        resultSize.height = _clipW / oriRate;
    }
    
    return  resultSize;
}


#pragma mark -
-(void)clipBtnSelected
{
    [self.delegate clipViewController:self finishClipImage:[self getClippedImage]];
    //    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 裁剪获取图片
-(UIImage *)getClippedImage
{
    CGFloat rationScale = (_imageView.mj_w /_image.size.width);
    
    CGFloat origX = (self.clipFrame.origin.x - _imageView.frame.origin.x) / rationScale;
    CGFloat origY = (self.clipFrame.origin.y - _imageView.frame.origin.y) / rationScale;
    
    CGFloat oriWidth = _clipW / rationScale;
    CGFloat oriHeight = _clipH / rationScale;
    
    CGRect myRect = CGRectMake(origX, origY, oriWidth, oriHeight);
    CGImageRef  imageRef = CGImageCreateWithImageInRect(_image.CGImage, myRect);
    UIGraphicsBeginImageContext(myRect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myRect, imageRef);
    UIImage * clipImage = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    
    if(self.clipType == CIRCULARCLIP){
        return  [self clipCircularImage:clipImage];
    }
    return clipImage;
}

#pragma mark -- 裁剪图片为圆形效果
-(UIImage *)clipCircularImage:(UIImage *)image
{
    CGFloat arcCenterX = image.size.width/ 2;
    CGFloat arcCenterY = image.size.height / 2;
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextAddArc(context, arcCenterX , arcCenterY, image.size.width/ 2 , 0.0, 2*M_PI, NO);
    CGContextClip(context);
    CGRect myRect = CGRectMake(0 , 0, image.size.width ,  image.size.height);
    [image drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  newImage;
}


@end
