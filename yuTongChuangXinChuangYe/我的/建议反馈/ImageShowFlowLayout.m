//
//  ImageShowFlowLayout.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ImageShowFlowLayout.h"

@implementation ImageShowFlowLayout
-(void)prepareLayout{
    [super prepareLayout];
    CGFloat cellSize=(kScreenWidth-4*8)/3;
    self.itemSize=CGSizeMake(cellSize, cellSize);
    self.sectionInset=UIEdgeInsetsMake(8, 8, 8, 8);
    self.minimumLineSpacing=8;
    self.minimumInteritemSpacing=8;
}
@end
