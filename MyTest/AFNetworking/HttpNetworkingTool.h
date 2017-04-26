//
//  HttpNetworkingTool.h
//  doctors
//
//  Created by mac on 16/1/27.
//  Copyright © 2016年 zhonghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HttpNetworkingTool : NSObject


/**
 *  get请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  post请求(非上传文件)
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)post:(NSString *)url params:(id)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  post请求(上传文件)
 *
 *  @param url      请求地址
 *  @param params   请求参数
 *  @param fileData 文件参数
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+ (void)post:(NSString *)url param:(NSDictionary *)param fileData:(NSDictionary *)fileData success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;


+ (void)post:(NSString *)url params:(id )params dataArr:(NSArray *)dataArr fileName:(NSString *)fileName success:(void (^)(id responseObj))success failure:(void (^)(NSError *))failure;



@end
