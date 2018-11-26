//
//  FilterView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterView : UIView
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UIButton *resetBtn;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,copy)void (^commitBlock)(NSMutableArray *dataArray);
-(instancetype)initWithArr:(NSMutableArray *)arr;
@end

NS_ASSUME_NONNULL_END
