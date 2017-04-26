//
//  UIImage+Mask.h
//  MyTest
//
//  Created by Dev on 2017/4/26.
//  Copyright © 2017年 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Mask)


+ (UIImage *) createImageWithColor: (UIColor *) color;

/**
 *  在一张背景图上绘制文字并且居中
 *
 *  @param str       要绘制到图片上的文字
 *  @param image     背景图片
 *  @param fontSize  文字的大小
 *  @param textColor 文字颜色
 *
 *  @return 绘制上文字的图片
 */
+ (UIImage *)createOtherMerchantImage:(NSString *)str withBgImage:(UIImage *)image withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor imageSize:(CGSize)imageSize;

- (unsigned char *) convertUIImageToBitmapRGBA8:(UIImage *) image;

- (UIImage *) convertBitmapRGBA8ToUIImage:(unsigned char *) buffer
                                withWidth:(int) width
                               withHeight:(int) height;

+ (GLuint)createTextureWithImage:(UIImage *)image;

@end
