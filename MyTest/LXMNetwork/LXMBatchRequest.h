//
//  LXMBatchRequest.h
//
//  Copyright (c) 2012-2014 LXMNetwork https://github.com/yuantiku
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "LXMRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class LXMBatchRequest;
@protocol LXMBatchRequestDelegate <NSObject>

@optional

- (void)batchRequestFinished:(LXMBatchRequest *)batchRequest;

- (void)batchRequestFailed:(LXMBatchRequest *)batchRequest;

@end

@interface LXMBatchRequest : NSObject

@property (strong, nonatomic, readonly) NSArray<LXMRequest *> *requestArray;

@property (weak, nonatomic, nullable) id<LXMBatchRequestDelegate> delegate;

@property (nonatomic, copy, nullable) void (^successCompletionBlock)(LXMBatchRequest *);

@property (nonatomic, copy, nullable) void (^failureCompletionBlock)(LXMBatchRequest *);

@property (nonatomic) NSInteger tag;

@property (nonatomic, strong, nullable) NSMutableArray<id<LXMRequestAccessory>> *requestAccessories;

@property (nonatomic, strong, readonly, nullable) LXMRequest *failedRequest;

- (instancetype)initWithRequestArray:(NSArray<LXMRequest *> *)requestArray;

- (void)start;

- (void)stop;

/// block回调
- (void)startWithCompletionBlockWithSuccess:(nullable void (^)(LXMBatchRequest *batchRequest))success
                                    failure:(nullable void (^)(LXMBatchRequest *batchRequest))failure;

- (void)setCompletionBlockWithSuccess:(nullable void (^)(LXMBatchRequest *batchRequest))success
                              failure:(nullable void (^)(LXMBatchRequest *batchRequest))failure;

/// 把block置nil来打破循环引用
- (void)clearCompletionBlock;

/// Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<LXMRequestAccessory>)accessory;

/// 是否当前的数据从缓存获得
- (BOOL)isDataFromCache;

@end

NS_ASSUME_NONNULL_END
