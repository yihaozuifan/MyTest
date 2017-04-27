//
//  ViewController.m
//  MyTest
//
//  Created by Dev on 2017/2/27.
//  Copyright © 2017年 Dev. All rights reserved.
//

#import "ViewController.h"
#import "ChatRoomSocketManager.h"
#import "UIImage+Mask.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
   
    
    NSString *const XMPP_DOMAIN = @"jianyezuqiu.cn";
    NSString * const XMPP_HOST_NAME = @"chat.jianyezuqiu.cn";
    NSInteger const XMPP_HOST_PORT = 5222;
    
    ChatRoomSocketManager *manager = [ChatRoomSocketManager sharedStance];

    
    [manager connectToHost:XMPP_HOST_NAME onPort:XMPP_HOST_PORT];
    
    UIButton *btn = [[UIButton alloc]init];
    
    btn.frame = CGRectMake(40, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString *testImg = @"testImg家就搜到几哦啊是大家哦给偶加欧艾斯都拿上好我我奇偶我奇偶我Joi你";
    
    UIImage *newImg = [UIImage createOtherMerchantImage:testImg withBgImage:[UIImage createImageWithColor:[UIColor whiteColor]] withFont:22 withTextColor:[UIColor redColor] imageSize:CGSizeMake(200, 100)];

    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.image = newImg;
    imageView.frame = CGRectMake(80, 200, 100, 100);
    [self.view addSubview:imageView];

    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)displayLinkCallback:(CADisplayLink*)sender
{
    if([UIApplication sharedApplication].applicationState != UIApplicationStateActive){
        
        return;
    }
    
    NSString *testImg = @"testImg家就搜到几哦啊是大家哦给偶加欧艾斯都拿上好我我奇偶我奇偶我Joi你";
    
    UIImage *newImg = [UIImage createOtherMerchantImage:testImg withBgImage:[UIImage createImageWithColor:[UIColor whiteColor]] withFont:22 withTextColor:[UIColor redColor] imageSize:CGSizeMake(200, 100)];
    
    GLuint uint = [UIImage createTextureWithImage:newImg];
    
}

-(void)test
{
//    NSDictionary *dic = @{@"123":@"hhh"};
//    [[ChatRoomSocketManager sharedStance] sendMessage:dic tag:0];
    
    SystemSoundID soundID;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"8619" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
    NSLog(@"send message");
}
@end
