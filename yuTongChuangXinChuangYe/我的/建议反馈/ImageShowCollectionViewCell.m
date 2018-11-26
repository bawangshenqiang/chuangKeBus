//
//  ImageShowCollectionViewCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ImageShowCollectionViewCell.h"

@implementation ImageShowCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.imageView.backgroundColor=[UIColor lightGrayColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteClick)];
    self.delete.userInteractionEnabled=YES;
    [self.delete addGestureRecognizer:tap];
}
-(void)deleteClick{
    if (self.DeleteImageBlock) {
        self.DeleteImageBlock(self);
    }
}

@end
