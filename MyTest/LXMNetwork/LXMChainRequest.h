//
//  LXMChainRequest.h
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
#import "LXMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class LXMChainRequest;
@protocol LXMRequestAccessory;

@protocol LXMChainRequestDelegate <NSObject>

@optional

- (void)chainRequestFinished:(LXMChainRequest *)chainRequest;

- (void)chainRequestFailed:(LXMChainRequest *)chainRequest failedBaseRequest:(LXMBaseRequest*)request;

@end

typedef void (^ChainCallback)(LXMChainRequest *chainRequest, LXMBaseRequest *baseRequest);

@interface LXMChainRequest : NSObject

@property (weak, nonatomic, nullable) id<LXMChainRequestDelegate> delegate;

@property (nonatomic, strong, nullable) NSMutableArray<id<LXMRequestAccessory>> *requestAccessories;

/// start chain request
- (void)start;

/// stop chain request
- (void)stop;

- (void)addRequest:(LXMBaseRequest *)request callback:(nullable ChainCallback)callback;

- (NSArray<LXMBaseRequest *> *)requestArray;

/// Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<LXMRequestAccessory>)accessory;

@end

NS_ASSUME_NONNULL_END
