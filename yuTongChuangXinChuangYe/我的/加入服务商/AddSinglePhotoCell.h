//
//  AddSinglePhotoCell.h
//  KR管理系统
//
//  Created by 霸枪001 on 2018/3/2.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSinglePhotoCell : UITableViewCell
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UIImageView *currentIma;
@property(nonatomic,copy)void (^addPhotoBlock)(void);
@property(nonatomic,strong)NSString *imageUrl;

@end
