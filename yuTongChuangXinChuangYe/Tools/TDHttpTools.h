//
//  TDHttpTools.h
//  TD
//
//  Created by 霸枪001 on 2017/3/24.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger , RequestMethodType) {
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};
@interface TDHttpTools : NSObject

/**
 *  json格式
 *
 *  @param methodTypr <#methodTypr description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)requestWithMethodType:(RequestMethodType)methodTypr Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


/**
 *  XML格式
 *
 *  @param methodType <#methodType description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)requestXmlWithMethodType:(RequestMethodType)methodType Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/*********************请求方法***********************************/

/**
 *  账号密码登陆
 */
+(void)loginWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  验证码登陆
 */
+(void)loginWithCodeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  注册
 */
+(void)registWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  忘记密码
 */
+(void)forgetPwdWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  验证码验证
 */
+(void)getAuthCodeWithParams:(NSDictionary *)params type:(int)typeCode success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  绑定手机
 */
+(void)bindingWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  退出登录
 */
+(void)loginOutWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


/**
 *  获取APPStore上的版本号
 */
+(void)getLatestVersionWithAppId:(NSString *)appid success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  获取个人信息
 */
+(void)getUserInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  修改个人信息
 */
+(void)updateUserInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  修改密码
 */
+(void)changePwdWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  微信登陆
 */
+(void)loginWXWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  大厅首页
 */
+(void)hallHomeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  找创意列表
 */
+(void)searchCreativityListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  找项目列表
 */
+(void)searchProjectListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  找成员列表
 */
+(void)searchNumbersListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  小贴士列表
 */
+(void)tipsListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  创意详情
 */
+(void)ideaDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  项目详情
 */
+(void)projectDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  找成员详情
 */
+(void)teamDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  获取所有分类信息
 */
+(void)getCatogaryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  创意信息(修改创意)
 */
+(void)creativityInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  项目信息(修改项目)
 */
+(void)projectInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  找成员信息(修改找成员)
 */
+(void)teamInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  提交创意
 */
+(void)submitCreativityWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  提交项目
 */
+(void)submitProjectWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  提交找成员
 */
+(void)submitTeamWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的创业-创意列表
 */
+(void)myCreativityListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的创业-项目列表
 */
+(void)myProjectListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的创业-团队列表
 */
+(void)myTeamListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的创业-资源列表
 */
+(void)myProviderListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的收藏-帖子（主题）列表
 */
+(void)myCollectionPostListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的收藏-课程列表
 */
+(void)myCollectionCourseListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的收藏-政策列表
 */
+(void)myCollectionPolicyListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的收藏-服务商列表
 */
+(void)myCollectionProviderListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的收藏-资讯热点列表
 */
+(void)myCollectionInformationListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的发表-帖子（主题）列表
 */
+(void)myPublishPostListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的发表-评论列表
 */
+(void)myPublishCommentListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的发表-感兴趣
 */
+(void)myPublishCaredListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  创意点赞
 */
+(void)praiseCreativityWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  找成员点赞
 */
+(void)praiseFindTeamWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  找成员感兴趣
 */
+(void)caredFindTeamWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  创意评论
 */
+(void)commentCreativityWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  项目点赞
 */
+(void)praiseProjectWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  项目评论
 */
+(void)commentProjectWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  资讯首页
 */
+(void)informationHomeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  资讯详情
 */
+(void)informationDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  资讯收藏
 */
+(void)collectInformationWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  资讯评论
 */
+(void)commentInformationWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  行业热点分类
 */
+(void)informationHotCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  行业热点列表
 */
+(void)informationHotListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  保存用户分类
 */
+(void)saveUserCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  7*24小时快讯
 */
+(void)fastInformationListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  创新宇通列表
 */
+(void)innovationListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  创新宇通详情
 */
+(void)innovationDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  政策区域、行业分类
 */
+(void)policyCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  政策列表
 */
+(void)policyListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  政策详情
 */
+(void)policyDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  政策收藏
 */
+(void)collectPolicyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  华山论剑首页
 */
+(void)huaShanHomepageWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  系统大厅列表
 */
+(void)systemHallListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  帖子详情
 */
+(void)postDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  帖子评论
 */
+(void)commentPostWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  帖子点赞
 */
+(void)praisePostWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  帖子收藏
 */
+(void)collectPostWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  帖子信息
 */
+(void)postInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  发表帖子
 */
+(void)submitPostWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  服务首页
 */
+(void)serverHomeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  创业资源(服务商)列表
 */
+(void)providerListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  服务商详情
 */
+(void)providerDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  服务商收藏
 */
+(void)collectProviderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  提交服务商需求
 */
+(void)providerDemandWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  服务商信息(修改加入服务商)
 */
+(void)providerInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  加入服务商
 */
+(void)joinProviderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  课程分类
 */
+(void)courseCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 * 创业课程列表
 */
+(void)courseListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 * 课程详情
 */
+(void)courseDetailWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  课程收藏
 */
+(void)collectCourseWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  课程评论
 */
+(void)commentCourseWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  获取热门搜索关键字
 */
+(void)getHotSearchKeyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  搜索详情分类
 */
+(void)searchDetailCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  搜索-服务商列表
 */
+(void)searchProviderListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  用户反馈
 */
+(void)userSegmentWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的消息-系统消息
 */
+(void)mySystemMessageWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  我的消息-个人消息
 */
+(void)myUserMessageWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  推送设置
 */
+(void)userPushSetWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  孵化专员
 */
+(void)getHatchPersonWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  项目审核记录列表
 */
+(void)projectAuditListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  任务中心
 */
+(void)taskCenterWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

@end
