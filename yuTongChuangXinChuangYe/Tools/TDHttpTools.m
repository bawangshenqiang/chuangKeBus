//
//  TDHttpTools.m
//  TD
//
//  Created by 霸枪001 on 2017/3/24.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "TDHttpTools.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"


//@"http://192.168.2.246:9005/api/"
//@"http://118.25.54.108:9005/api/"
//192.168.2.199

#define kSERVER_HTTP_DXE @"http://118.25.54.108:9005/api/"


@implementation TDHttpTools

/**
 *  返回json格式
 *
 *  @param methodType <#methodType description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)requestWithMethodType:(RequestMethodType)methodType Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    [SVProgressHUD showWithStatus:@""];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",@"application/xhtml+xml",@"application/xml", nil];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    [SVProgressHUD dismiss];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [SVProgressHUD dismiss];
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    [SVProgressHUD dismiss];
                    success(responseObject);
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [SVProgressHUD dismiss];
                    failure(error);
                    
                }
            }];
        }
            break;
            
        default:
            break;
    }
}
/**
 *  返回json格式     manager.requestSerializer 请求方式不一样    需要上传数组
 *
 *  @param methodType <#methodType description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)anotherRequestWithMethodType:(RequestMethodType)methodType Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    [SVProgressHUD showWithStatus:@""];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",@"application/xhtml+xml",@"application/xml", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    [SVProgressHUD dismiss];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [SVProgressHUD dismiss];
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    //id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    [SVProgressHUD dismiss];
                    success(responseObject);
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [SVProgressHUD dismiss];
                    failure(error);
                    
                }
            }];
        }
            break;
            
        default:
            break;
    }
}
/**
 *  xml格式
 *
 *  @param methodType <#methodType description#>
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)requestXmlWithMethodType:(RequestMethodType)methodType Url:(NSString *)urlString params:(id)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    // 设置超时时间
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manage.requestSerializer.timeoutInterval = 10.f;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manage.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [manage GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            [manage POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
            
        default:
            break;
    }
}
/**
 *  账号密码登陆
 */
+(void)loginWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@login/userpass",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
/**
 *  验证码登陆
 */
+(void)loginWithCodeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@login/usercode",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
/**
 *  注册
 */
+(void)registWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@register/user",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  忘记密码
 */
+(void)forgetPwdWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@find/user",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


/**
 *  验证码验证
 */
+(void)getAuthCodeWithParams:(NSDictionary *)params type:(int)typeCode success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=nil;
    switch (typeCode) {
        case 0:
            //登录用
            urlString=[NSString stringWithFormat:@"%@util/get_login_code",kSERVER_HTTP_DXE];
            break;
        case 1:
           //注册用
            urlString=[NSString stringWithFormat:@"%@util/get_reg_code",kSERVER_HTTP_DXE];
            break;
        case 2:
            //改密码用
            urlString=[NSString stringWithFormat:@"%@util/get_find_code",kSERVER_HTTP_DXE];
            break;
        default:
            //绑定账户用
            urlString=[NSString stringWithFormat:@"%@util/get_common_code",kSERVER_HTTP_DXE];
            break;
    }
    
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
/**
 *  绑定手机
 */
+(void)bindingWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@bind/user",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
/**
 *  退出登录
 */
+(void)loginOutWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/UserCenter/AppLogout",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


/**
 *  获取APPStore上的版本号
 */
+(void)getLatestVersionWithAppId:(NSString *)appid success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    
    NSString *urlString=[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",appid];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:nil success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  获取个人信息
 */
+(void)getUserInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/info",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  修改个人信息
 */
+(void)updateUserInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/update",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  修改密码
 */
+(void)changePwdWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/pwd",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  微信登陆
 */
+(void)loginWXWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@login/wxuser",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
/**
 *  大厅首页
 */
+(void)hallHomeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/hall2",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  找创意列表
 */
+(void)searchCreativityListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/idea/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  找项目列表
 */
+(void)searchProjectListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/project/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  找成员列表
 */
+(void)searchNumbersListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/team",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  小贴士列表
 */
+(void)tipsListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/tip/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  创意详情
 */
+(void)ideaDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/idea/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  项目详情
 */
+(void)projectDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/project/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  找成员详情
 */
+(void)teamDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/team/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  获取所有分类信息
 */
+(void)getCatogaryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@util/category",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  创意信息(修改创意)
 */
+(void)creativityInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/ideainfo",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  项目信息(修改项目)
 */
+(void)projectInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/projectinfo",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  找成员信息(修改找成员)
 */
+(void)teamInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/teamuserinfo",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  提交创意
 */
+(void)submitCreativityWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/ideaop",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  提交项目
 */
+(void)submitProjectWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/projectop",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  提交找成员
 */
+(void)submitTeamWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/teamuserop",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的创业-创意列表
 */
+(void)myCreativityListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/idealist",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的创业-项目列表
 */
+(void)myProjectListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/projectlist",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的创业-团队列表
 */
+(void)myTeamListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/teamuserlist",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的创业-资源列表
 */
+(void)myProviderListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/userdemand",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的收藏-帖子（主题）列表
 */
+(void)myCollectionPostListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/postcollect",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的收藏-课程列表
 */
+(void)myCollectionCourseListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/coursecollect",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的收藏-政策列表
 */
+(void)myCollectionPolicyListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/policycollect",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的收藏-服务商列表
 */
+(void)myCollectionProviderListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/providercollect",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的收藏-资讯热点列表
 */
+(void)myCollectionInformationListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/informationcollect",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的发表-帖子（主题）列表
 */
+(void)myPublishPostListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/postlist",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的发表-评论列表
 */
+(void)myPublishCommentListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/comment/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的发表-感兴趣
 */
+(void)myPublishCaredListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/findteamusercare",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  创意点赞
 */
+(void)praiseCreativityWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/praiseidea",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  找成员点赞
 */
+(void)praiseFindTeamWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/praisefindteamuser",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  找成员感兴趣
 */
+(void)caredFindTeamWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/carefindteamuser",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  创意评论
 */
+(void)commentCreativityWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/commentidea",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  项目点赞
 */
+(void)praiseProjectWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/praiseproject",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  项目评论
 */
+(void)commentProjectWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/commentproject",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  资讯首页
 */
+(void)informationHomeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/information",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  资讯详情
 */
+(void)informationDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/information/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  资讯收藏
 */
+(void)collectInformationWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/collectinformation",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  资讯评论
 */
+(void)commentInformationWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/commentinformation",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  行业热点分类
 */
+(void)informationHotCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/information/category",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  行业热点列表
 */
+(void)informationHotListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/information/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  保存用户分类
 */
+(void)saveUserCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/usercategory",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  7*24小时快讯
 */
+(void)fastInformationListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/flash",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  创新宇通列表
 */
+(void)innovationListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/innovation/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  创新宇通详情
 */
+(void)innovationDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/innovation/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  政策区域、行业分类
 */
+(void)policyCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/policy/category",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  政策列表
 */
+(void)policyListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/policy/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  政策详情
 */
+(void)policyDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/policy/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  政策收藏
 */
+(void)collectPolicyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/collectpolicy",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  华山论剑首页
 */
+(void)huaShanHomepageWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/post",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  系统大厅列表
 */
+(void)systemHallListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/post/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  帖子详情
 */
+(void)postDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/post/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  帖子评论
 */
+(void)commentPostWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/commentpost",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  帖子点赞
 */
+(void)praisePostWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/praisepost",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  帖子收藏
 */
+(void)collectPostWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/collectpost",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  帖子信息
 */
+(void)postInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/postinfo",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  发表帖子
 */
+(void)submitPostWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/postop",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  服务首页
 */
+(void)serverHomeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/service",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  创业资源(服务商)列表
 */
+(void)providerListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/provider/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  服务商详情
 */
+(void)providerDeatilWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/provider/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  服务商收藏
 */
+(void)collectProviderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/collectprovider",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  提交服务商需求
 */
+(void)providerDemandWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/providerdemandop",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  服务商信息(修改加入服务商)
 */
+(void)providerInfoWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/providerinfo",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  加入服务商
 */
+(void)joinProviderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/provider",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  课程分类
 */
+(void)courseCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/course/category",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 * 创业课程列表
 */
+(void)courseListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/course/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 * 课程详情
 */
+(void)courseDetailWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/course/detail",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  课程收藏
 */
+(void)collectCourseWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/collectcourse",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  课程评论
 */
+(void)commentCourseWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/commentcourse",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  获取热门搜索关键字
 */
+(void)getHotSearchKeyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@util/get_top_search",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  搜索详情分类
 */
+(void)searchDetailCatogeryWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/search/result",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  搜索-服务商列表
 */
+(void)searchProviderListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@data/provider/search",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  用户反馈
 */
+(void)userSegmentWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/feedback",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的消息-系统消息
 */
+(void)mySystemMessageWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/notice/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  我的消息-个人消息
 */
+(void)myUserMessageWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/usermessage/list",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  推送设置
 */
+(void)userPushSetWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/jpush",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  孵化专员
 */
+(void)getHatchPersonWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/idearecord",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  项目审核记录列表
 */
+(void)projectAuditListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/projectrecordlist",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  任务中心
 */
+(void)taskCenterWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@user/job",kSERVER_HTTP_DXE];
    [TDHttpTools requestWithMethodType:RequestMethodTypePost Url:urlString params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
