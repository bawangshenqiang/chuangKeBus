//
//  TastCenterModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TastCenterModel : NSObject

/** 浏览任务总数 */
@property(nonatomic,assign)int viewjobtotal;
/** 浏览任务积分 */
@property(nonatomic,assign)int viewjobscore;
/** 当前浏览任务数 */
@property(nonatomic,assign)int viewjobnow;
/** 浏览任务是否完成 */
@property(nonatomic,assign)BOOL viewjobdone;
/** 收藏任务完成数 1-完成 0-未完成 */
@property(nonatomic,assign)int collectjobnow;
/** 评价任务完成数 1-完成 0-未完成 */
@property(nonatomic,assign)int commentjobnow;
/** 点赞任务完成数 1-完成 0-未完成 */
@property(nonatomic,assign)int praisejobnow;
/** 点击(点赞收藏评价)任务积分 */
@property(nonatomic,assign)int clickjobscore;
/** 点击任务是否完成 */
@property(nonatomic,assign)BOOL clickjobdone;
/** 是否发帖 */
@property(nonatomic,assign)BOOL postjobnow;
/** 发帖任务积分 */
@property(nonatomic,assign)int postjobscore;
/** 发帖任务是否完成 */
@property(nonatomic,assign)BOOL postjobdone;
/** 创意任务积分 */
@property(nonatomic,assign)int ideajobscore;
/** 当前完成创意任务数 */
@property(nonatomic,assign)int ideajobnow;
/** 项目任务积分 */
@property(nonatomic,assign)int projobscore;
/** 当前完成项目任务数 */
@property(nonatomic,assign)int projobnow;
/** 团队任务积分 */
@property(nonatomic,assign)int teamjobscore;
/** 当前完成团队任务数 */
@property(nonatomic,assign)int teamjobnow;
/** 置顶帖子积分 */
@property(nonatomic,assign)int hotpostjobscore;
/** 当前置顶帖子数 */
@property(nonatomic,assign)int hotpostjobnow;
/** 是否注册 */
@property(nonatomic,assign)BOOL regjobnow;
/** 是否完成注册任务 */
@property(nonatomic,assign)BOOL regjobdone;
/** 注册任务积分 */
@property(nonatomic,assign)int regjobscore;
/** 是否绑定微信 */
@property(nonatomic,assign)BOOL bindjobnow;
/** 是否完成领奖励 */
@property(nonatomic,assign)BOOL bindjobdone;
/** 绑定任务积分 */
@property(nonatomic,assign)int bindjobscore;
/** 是否完善个人信息 */
@property(nonatomic,assign)BOOL completejobnow;
/** 完善个人信息任务是否完成 */
@property(nonatomic,assign)BOOL completejobdone;
/** 完善任务积分 */
@property(nonatomic,assign)int completejobscore;
/** 用户总积分 */
@property(nonatomic,assign)int totalscore;
/** 今日积分 */
@property(nonatomic,assign)int todayscore;
/** 今日签到积分 */
@property(nonatomic,assign)int todaysign;
/** 明日签到积分 */
@property(nonatomic,assign)int tomorrowsign;
/** 是否签到 */
@property(nonatomic,assign)BOOL Signed;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
