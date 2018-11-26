//
//  CycleScrollImageCell.m
//  易彩票
//
//  Created by 霸枪001 on 2017/10/27.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "CycleScrollImageCell.h"

@implementation CycleScrollImageCell

-(SDCycleScrollView *)cycleScrollImage{
    if (!_cycleScrollImage) {
        
        _cycleScrollImage=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 0, kScreenWidth-20, 100) delegate:nil placeholderImage:[UIImage imageNamed:@"hall_diagram"]];
        _cycleScrollImage.layer.cornerRadius=4;
        //
        //_cycleScrollImage.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_cycleScrollImage];
    }
    return _cycleScrollImage;
}
-(void)setCycleImageUrls:(NSArray *)cycleImageUrls{
    _cycleImageUrls=cycleImageUrls;
    self.cycleScrollImage.imageURLStringsGroup=cycleImageUrls;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
