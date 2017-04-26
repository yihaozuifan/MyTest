

//
//  HttpNetworkingTool.m
//  doctors
//
//  Created by mac on 16/1/27.
//  Copyright © 2016年 zhonghong. All rights reserved.
//

#import "HttpNetworkingTool.h"

@implementation HttpNetworkingTool



+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 发送请求
    
    
    [mgr GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if(success){
             success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
             failure(error);
        }
        
    }];
    
    
//    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        nil;
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//            
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (error) {
//
//            failure(error);
//            NSLog(@"%@",error);
//        }
//    }];
    

}

+ (void)post:(NSString *)url params:(id )params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 创建管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    // 发送请求

    [mgr POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if(success){
            NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            //  NSLog(@"返回的数据/n%@",jsonDict);
            
            success(jsonDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            NSLog(@"%@",error);
        }
    }];
    
    
//    [mgr POST:url parameters:params  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            
//            NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//          //  NSLog(@"返回的数据/n%@",jsonDict);
//            
//          success(jsonDict);
//            
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//     
//                if (failure) {
//                    failure(error);
//                    NSLog(@"%@",error);
//                }
//    }];
    
    
}

+ (void)post:(NSString *)url param:(NSDictionary *)param fileData:(NSDictionary *)fileData success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    // 获取管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
   // mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    
  //  mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    // 发送请求
    
    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData[@"data"] name:fileData[@"name"] fileName:fileData[@"fileName"] mimeType:fileData[@"mimeType"]];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(error);
    }];
    
//    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:fileData[@"data"] name:fileData[@"name"] fileName:fileData[@"fileName"] mimeType:fileData[@"mimeType"]];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        nil;
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         failure(error);
//    }];
    
    
//    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:fileData[@"data"] name:fileData[@"name"] fileName:fileData[@"fileName"] mimeType:fileData[@"mimeType"]];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//

    NSString *heImagePath = [[NSBundle mainBundle] pathForResource:@"testImage" ofType:@"png"];
    
    NSLog(@"theImagePath----%@",heImagePath);
    
    
}


+ (void)post:(NSString *)url params:(id )params dataArr:(NSArray *)dataArr fileName:(NSString *)fileName success:(void (^)(id responseObj))success failure:(void (^)(NSError *))failure
{
    
    // 创建管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 发送请求
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (dataArr.count > 0) {

            for (NSData *data in dataArr) {

                [formData appendPartWithFormData:data name:fileName];
            }
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
//    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        if (dataArr.count > 0) {
//            
//            for (NSData *data in dataArr) {
//                
//                [formData appendPartWithFormData:data name:fileName];
//            }
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//        
//    }];
    
}




@end
