//
//  FilterView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "FilterView.h"
#import "MoveCollectionViewCell.h"

#define identity @"MoveCollectionViewCell"

@interface FilterView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,strong)NSMutableArray *origalArr;

@end

@implementation FilterView

-(instancetype)initWithArr:(NSMutableArray *)arr{
    if (self=[super init]) {
        self.dataArr=arr;
        self.origalArr=arr;
        
        self.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.delegate=self;
        [self addGestureRecognizer:tap];
        //
        self.bigView=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth, kStatusBarHeight, kScreenWidth*0.8, (kScreenHeight-kStatusBarHeight)*0.8)];
        self.bigView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.bigView];
        //
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bigView.width, 40)];
        titleLab.text=@"个性化展示";
        titleLab.font=[UIFont systemFontOfSize:17];
        titleLab.textAlignment=NSTextAlignmentCenter;
        [self.bigView addSubview:titleLab];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(15, titleLab.bottom-0.4, self.bigView.width-30, 0.4)];
        line.backgroundColor=RGBAColor(145, 165, 165, 0.5);
        [self.bigView addSubview:line];
        UILabel *titleLab2=[[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom, self.bigView.width-30, 30)];
        titleLab2.text=@"长按拖动可调整顺序";
        titleLab2.font=[UIFont boldSystemFontOfSize:14];
        [self.bigView addSubview:titleLab2];
        //
        [self.bigView addSubview:self.collectionView];
        
        //
        self.resetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.resetBtn.frame=CGRectMake(0, self.collectionView.bottom, self.bigView.width/2, 50);
        [self.resetBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.resetBtn setBackgroundColor:[UIColor whiteColor]];
        self.resetBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        self.resetBtn.layer.borderWidth=0.5;
        self.resetBtn.layer.borderColor=RGBAColor(145, 165, 165, 0.5).CGColor;
        [self.resetBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.resetBtn];
        //
        self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.frame=CGRectMake(self.resetBtn.right, self.collectionView.bottom, self.bigView.width/2, 50);
        [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sureBtn setBackgroundColor:kThemeColor];
        self.sureBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        [self.sureBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.sureBtn];
        //
        [self show];
    }
    return self;
}
- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(80, 30);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, self.bigView.width, self.bigView.height-120) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MoveCollectionViewCell class] forCellWithReuseIdentifier:identity];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_collectionView addGestureRecognizer:longPressGesture];
        
    }
    return _collectionView;
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    //根据长按手势的状态进行处理。
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
            //开始移动
            [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            [_collectionView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
            //停止移动调用此方法
            [_collectionView endInteractiveMovement];
            break;
        default:
            //取消移动
            [_collectionView cancelInteractiveMovement];
            break;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    NSDictionary *dic=self.dataArr[indexPath.row];
    cell.titleLab.text = dic[@"name"];
    return cell;
}
// 在开始移动时会调用此代理方法，
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexpath判断单元格是否可以移动，如果都可以移动，直接就返回YES ,不能移动的返回NO
    
    return YES;
}

// 在移动结束的时候调用此代理方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    NSMutableArray *arr=[self.dataArr copy];
    [self.dataArr removeObjectAtIndex:sourceIndexPath.row];
    NSDictionary *dic = arr[sourceIndexPath.row];
    [self.dataArr insertObject:dic atIndex:destinationIndexPath.row];
}


-(void)cancelBtnClick{
    
    [self dismiss];
    
}
-(void)commitBtnClick{
    [self dismiss];
    
    if (self.commitBlock) {
        self.commitBlock(self.dataArr);
    }
    
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBAColor(0, 0, 0, 0.4);
        self.bigView.transform=CGAffineTransformMakeTranslation(-kScreenWidth*0.8, 0);
        
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.bigView.transform=CGAffineTransformIdentity;
        self.backgroundColor = RGBAColor(0, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
        
    }];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if( [touch.view isDescendantOfView:self.bigView]) {
        return NO;
    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
