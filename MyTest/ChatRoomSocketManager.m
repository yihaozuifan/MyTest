//
//  ChatRoomSocketManager.m
//  MoJingLive
//
//  Created by Dev on 2017/3/15.
//  Copyright © 2017年 Dev. All rights reserved.
//

#import "ChatRoomSocketManager.h"
#import "AsyncSocket.h"

@interface ChatRoomSocketManager()<AsyncSocketDelegate>

@property(nonatomic,copy)NSString *hostName;
@property(nonatomic,assign)NSInteger port;

@property(nonatomic,strong)AsyncSocket *socket;

@property (nonatomic, strong) NSTimer *heartTimer;   // 心跳计时器
@end
@implementation ChatRoomSocketManager


+(instancetype)sharedStance
{
    static dispatch_once_t onceToken;
    static ChatRoomSocketManager *manager;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc]init];
    });
    
    return manager;
}

-(instancetype)init
{
    if(self = [super init]){
        
        self.socket = [[AsyncSocket alloc]initWithDelegate:self];
        [self.socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
    return self;
}


- (BOOL)connectToHost:(NSString *)hostname onPort:(UInt16)port
{
    
    self.hostName = [hostname copy];
    self.port = port;
    
    NSError *error = nil;
    
    if(![self.socket isConnected]){
        
        [self.socket connectToHost:hostname onPort:port withTimeout:60 error:&error];
    }
    
    if(error){
        return false;
    }
    
    return true;
}


-(void)sendMessage:(NSDictionary *)msgDic tag:(NSInteger)tag
{
    
//    NSData * data = [NSJSONSerialization dataWithJSONObject:msgDic options:NSJSONWritingPrettyPrinted error:nil];
    
    
    NSString *str = @"123123";
    NSData *data = [str dataUsingEncoding:NSASCIIStringEncoding];
    
    [self.socket writeData:data withTimeout:60 tag:tag];
}


-(void)disconnect
{
    self.socket.userData = SocketOfflineByUser;
    [self.socket disconnect];
}

// 心跳连接
-(void)checkLongConnectByServe
{
    // 向服务器发送固定消息，来检测长连接
    NSString *longConnect = @"connect host";
    NSData *data = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:3 tag:1001];
}


#pragma mark -- Delegate

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    //这是异步返回的连接成功，
    NSLog(@"didConnectToHost");
//    self.heartTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkLongConnectByServe) userInfo:nil repeats:YES];
//    [self.heartTimer fire];
}


- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@" willDisconnectWithError %ld   err = %@",sock.userData,[err description]);
    if (err.code == 57) {
        self.socket.userData = SocketOfflineByWifiCut;
    }
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"onSocketDidDisconnect sorry the connect is failure %ld",sock.userData);
    
    if (sock.userData == SocketOfflineByServer) {
        // 服务器掉线，重连
        [self connectToHost:self.hostName onPort:self.port];
        
    } else if (sock.userData == SocketOfflineByUser) {
        // 如果由用户断开，不进行重连
        return;
        
    }else if (sock.userData == SocketOfflineByWifiCut) {
        // wifi断开，不进行重连
        return;
    }
}

//发送消息成功之后回调
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    if(tag != 1001){
        
         NSLog(@"发送成功");
        
         [self.socket readDataWithTimeout:-1 tag:1];
    }
   
}

//接受消息成功之后回调
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
   
    //收到结果解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",dic);
    
    [sock readDataWithTimeout:-1 tag:tag];
}

@end
