//
//  KCView4.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/23.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "KCView4.h"

@implementation KCView4

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
      //图像绘制
    [self drawImage:context];
    
    //文字绘制
    [self drawText:context];
    

    
}

#pragma mark drawImage
- (void)drawImage:(CGContextRef)context
{

    UIImage *image = [UIImage imageNamed:@"14.png"];
   // [image drawAtPoint:CGPointMake(10, 50)];
    
   // [image drawInRect:CGRectMake(10, 50, 300, 450)];
    [image drawInRect:CGRectMake(0, 0, 320, 568) blendMode:kCGBlendModeNormal alpha:1];
    
    //平铺绘制
    
    //[image drawAsPatternInRect:CGRectMake(0, 0, 320, 568)];
    
}

#pragma mark 文字绘制
- (void)drawText:(CGContextRef)context
{
    
    
    //绘制到指定的区域内容
    NSString *str=@"Star Walk is the most beautifulstargazing app you’ve ever seen on a mobile device. It willbecome your go-to interactive astro guide to the night sky,following your every movement in real-time and allowing youto explore over 200, 000 celestial bodies with extensiveinformation about stars and constellations that you find.";
    CGRect rect = CGRectMake(20, 50, 280, 300);
    UIFont *font = [UIFont systemFontOfSize:18];
    UIColor *color = [UIColor redColor];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    NSTextAlignment align = NSTextAlignmentLeft;
    style.alignment = align;
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
    

}

@end
