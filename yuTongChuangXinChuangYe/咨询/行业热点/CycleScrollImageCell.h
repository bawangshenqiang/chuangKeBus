//
//  CycleScrollImageCell.h
//  易彩票
//
//  Created by 霸枪001 on 2017/10/27.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface CycleScrollImageCell : UITableViewCell

@property(nonatomic,strong)SDCycleScrollView *cycleScrollImage;

@property(nonatomic,strong)NSArray *cycleImageUrls;

@end
