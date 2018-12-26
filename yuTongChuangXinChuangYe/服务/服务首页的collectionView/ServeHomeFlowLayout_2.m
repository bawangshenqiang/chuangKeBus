//
//  ServeHomeFlowLayout_2.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeHomeFlowLayout_2.h"

@implementation ServeHomeFlowLayout_2
-(void)prepareLayout{
    [super prepareLayout];
    //设置item尺寸
    CGFloat itemW = (self.collectionView.frame.size.width-40)/2;
    CGFloat itemH = itemW*150/325+25;
    self.itemSize = CGSizeMake(itemW, itemH);
    
    //设置最小间距
    self.minimumLineSpacing = 20;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
}
@end
