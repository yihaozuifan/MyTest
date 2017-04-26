//
//  SoonRequest.m
//  sport
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaoFengRequest.h"


@implementation BaoFengRequest

-(id)init
{
    self = [super init];
    if (self) {
        [self.requestAccessories addObject:self];
        [self addAccessory:self];
    }
    return self;
}


-(NSString *)baseUrl
{
    return @"";
}

-(NSTimeInterval)requestTimeoutInterval
{
    return 20;
}
-(LXMRequestMethod)requestMethod
{
    return LXMRequestMethodGet;
}
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    NSDictionary *dic = @{@"clientType":@"1",@"appversion":@"1.0"};
    return [dic mutableCopy];
}

- (NSString *)requestAuthentication
{
//    NSString *accessToken = USERTEL;
//    if (accessToken.length>0) {
//        return accessToken;
//    }
    
    return nil;
}


//-(NSDictionary *)requestTotalArgument
//{

//    NSDictionary *param = self.requestArgument;
//    
//    NSMutableDictionary *totalParam = [NSMutableDictionary dictionary];
//    
//    if([[param allKeys] containsObject:@"app_version"] == NO){
//        
//        [totalParam setObject:APP_VERSION forKey:@"app_version"];
//    }
//    
//    if(param != nil){
//       [totalParam  setValuesForKeysWithDictionary:param];
//    }
//    
//    [totalParam setValuesForKeysWithDictionary:[self commonDic]];
//   
//    return totalParam;
//}


//-(NSDictionary *)commonDic
//{
//    
//   
//    NSDictionary *dic = @{@"app_id":APP_ID,@"timestamp":@"123"};
//    return dic;
//}


- (AFConstructingBlock)constructingBodyBlock
{
    return nil;
}


-(void (^)(LXMBaseRequest *))failureCompletionBlock
{
    return ^(LXMBaseRequest *request){
        
        NSInteger responseStatusCode = request.responseStatusCode;
//        NSString *responseString = request.responseString;
        if(responseStatusCode == 0){
          
            
        }else{

            
        }
    };
}

//-(void (^)(LXMBaseRequest *))successCompletionBlock
//{
//    return ^(LXMBaseRequest *request){
//        
//        id responseJSONObject = request.responseJSONObject;
//        
//    };
//}


@end
