//
//  SetCell_switch.h
//  皮口袋记账
//
//  Created by 霸枪001 on 2018/6/15.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCell_switch : UITableViewCell
@property (nonatomic,strong) UILabel *titleLab;
@property (strong,nonatomic) UISwitch *rightSwitch;
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^switchBlock)(NSIndexPath *indexpath,BOOL open);

@end
