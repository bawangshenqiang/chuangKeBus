//
//  ImageShowCollectionViewCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageShowCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *delete;
@property(nonatomic,strong)void (^DeleteImageBlock)(ImageShowCollectionViewCell *cell);

@end

NS_ASSUME_NONNULL_END
