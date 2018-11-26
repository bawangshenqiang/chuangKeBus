//
//  Head_BusinessCourse.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Head_BusinessCourse : UIScrollView
/** init之后需要先设置，默认白色 */
@property(nonatomic,strong)UIColor *bgColor;
/** init之后需要先设置，默认选中第一个 */
@property(nonatomic,assign)NSInteger selectedIndex;
/** 数量较多，一个屏幕显示不开的时候用，可滑动 */
@property(nonatomic,strong)NSMutableArray *titleArr;
/** 数量较少，一个屏幕就可以显示开的时候用，不可滑动 */
@property(nonatomic,strong)NSArray *fixedTitles;

/** (搜索专用)数量较多，一个屏幕显示不开的时候用，可滑动 */
@property(nonatomic,strong)NSMutableArray *searchTitleArr;

@property(nonatomic,copy)void (^topSegmentChangeBlock)(int index);
@property(nonatomic,copy)void (^topSegmentChangeSecondBlock)(NSString *module);
@end

NS_ASSUME_NONNULL_END
