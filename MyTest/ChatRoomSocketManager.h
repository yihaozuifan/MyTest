//
//  ChatRoomSocketManager.h
//  MoJingLive
//
//  Created by Dev on 2017/3/15.
//  Copyright © 2017年 Dev. All rights reserved.
//



typedef enum {
    
    SocketOfflineByServer = 0,
    SocketOfflineByUser = 1,
    SocketOfflineByWifiCut = 2
    
}SocketOfflineType;

#import <Foundation/Foundation.h>

@interface ChatRoomSocketManager : NSObject

+(instancetype)sharedStance;


- (BOOL)connectToHost:(NSString *)hostname onPort:(UInt16)port;


-(void)disconnect;

-(void)sendMessage:(NSDictionary *)msgDic tag:(NSInteger)tag;

@end
