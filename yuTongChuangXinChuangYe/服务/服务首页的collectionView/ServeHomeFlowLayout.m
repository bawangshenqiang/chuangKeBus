//
//  ServeHomeFlowLayout.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeHomeFlowLayout.h"

@implementation ServeHomeFlowLayout
-(void)prepareLayout{
    [super prepareLayout];
    //设置item尺寸
    CGFloat itemW = (self.collectionView.frame.size.width-40)/2;
    CGFloat itemH = itemW*25/33+40;
    self.itemSize = CGSizeMake(itemW, itemH);
    
    //设置最小间距
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
}
@end
