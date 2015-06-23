//
//  KCView5.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/23.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "KCView5.h"

@implementation KCView5

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    self.backgroundColor = [UIColor whiteColor];
   // [self drawLinearGradient:context];
   // [self drawRadialGradient:context];
    [self drawRectByUIKitWithContext2:context];
    
}

#pragma mark 线性渐变
- (void)drawLinearGradient:(CGContextRef)context{

    //使用颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    /*指定颜色渐变
     space:颜色空间
     components:颜色数组，注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色
     （red,green,blue,alpha）
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数

     */
   // CGFloat componments[2] = {2,3};
    
    //裁切处⼀一块矩形⽤用于显⽰示,注意必须先裁切再调⽤用渐变
    //CGContextClipToRect(context, CGRectMake(20, 50, 280,300));
    //裁切还可以使⽤用UIKit中对应的⽅方法
    UIRectClip(CGRectMake(20, 50, 280, 300));
    
    CGFloat components[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradiend = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);
    /*
     绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startpoint:起始位置
     endPoint:终点位置
     options:绘制方式 kCGGradientDrawsBeforeStartLocation 开
     始位置之前就进⾏行绘制,到结束位置之后不再绘制, kCGGradientDrawsAfterEndLocation开始位置之前不进
     ⾏行绘制,到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradiend, CGPointZero, CGPointMake(320, 300), kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
    
}
#pragma mark -径向渐变

- (void)drawRadialGradient:(CGContextRef)context
{

    //使用RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    /*指定渐变颜色
     space:颜色空间 
     compnents：颜色数组，注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red,green,blue,alpha）
     如果有三个颜色，则这个数组有4*3个元素
     locations：颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count：渐变个数，等于locations的个数
     */
    CGFloat components[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);
    
    CGContextDrawRadialGradient(context, gradient,CGPointMake(160, 284), 0, CGPointMake(165, 289),150,kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
    
}

-(void)drawRectByUIKitWithContext2:(CGContextRef)context{
    CGRect rect= CGRectMake(0, 130.0, 320.0, 50.0);
    CGRect rect1= CGRectMake(0, 390.0, 320.0, 50.0);
    CGRect rect2=CGRectMake(20, 50.0, 10.0, 250.0);
    CGRect rect3=CGRectMake(40.0, 50.0, 10.0, 250.0);
    CGRect rect4=CGRectMake(60.0, 50.0, 10.0, 250.0);
    CGRect rect5=CGRectMake(80.0, 50.0, 10.0, 250.0);
    CGRect rect6=CGRectMake(100.0, 50.0, 10.0, 250.0);
    CGRect rect7=CGRectMake(120.0, 50.0, 10.0, 250.0);
    CGRect rect8=CGRectMake(140.0, 50.0, 10.0, 250.0);
    CGRect rect9=CGRectMake(160.0, 50.0, 10.0, 250.0);
    CGRect rect10=CGRectMake(180.0, 50.0, 10.0, 250.0);
    CGRect rect11=CGRectMake(200.0, 50.0, 10.0, 250.0);
    CGRect rect12=CGRectMake(220.0, 50.0, 10.0, 250.0);
    CGRect rect13=CGRectMake(240.0, 50.0, 10.0, 250.0);
    CGRect rect14=CGRectMake(260.0, 50.0, 10.0, 250.0);
    CGRect rect15=CGRectMake(280.0, 50.0, 10.0, 250.0);
    CGRect rect16=CGRectMake(30.0, 310.0, 10.0, 250.0);
    CGRect rect17=CGRectMake(50.0, 310.0, 10.0, 250.0);
    CGRect rect18=CGRectMake(70.0, 310.0, 10.0, 250.0);
    CGRect rect19=CGRectMake(90.0, 310.0, 10.0, 250.0);
    CGRect rect20=CGRectMake(110.0, 310.0, 10.0, 250.0);
    CGRect rect21=CGRectMake(130.0, 310.0, 10.0, 250.0);
    CGRect rect22=CGRectMake(150.0, 310.0, 10.0, 250.0);
    CGRect rect23=CGRectMake(170.0, 310.0, 10.0, 250.0);
    CGRect rect24=CGRectMake(190.0, 310.0, 10.0, 250.0);
    CGRect rect25=CGRectMake(210.0, 310.0, 10.0, 250.0);
    CGRect rect26=CGRectMake(230.0, 310.0, 10.0, 250.0);
    CGRect rect27=CGRectMake(250.0, 310.0, 10.0, 250.0);
    CGRect rect28=CGRectMake(270.0, 310.0, 10.0, 250.0);
    CGRect rect29=CGRectMake(290.0, 310.0, 10.0, 250.0);
    [[UIColor yellowColor]set];
    UIRectFill(rect);
    [[UIColor greenColor]setFill];
    UIRectFill(rect1);
    [[UIColor redColor]setFill];
    UIRectFillUsingBlendMode(rect2, kCGBlendModeClear);
    UIRectFillUsingBlendMode(rect3, kCGBlendModeColor);
    UIRectFillUsingBlendMode(rect4, kCGBlendModeColorBurn);
    UIRectFillUsingBlendMode(rect5,
                             kCGBlendModeColorDodge);
    UIRectFillUsingBlendMode(rect6, kCGBlendModeCopy);
    UIRectFillUsingBlendMode(rect7, kCGBlendModeDarken);
    UIRectFillUsingBlendMode(rect8,
                             kCGBlendModeDestinationAtop);
    UIRectFillUsingBlendMode(rect9,
                             kCGBlendModeDestinationIn);
    UIRectFillUsingBlendMode(rect10,
                             kCGBlendModeDestinationOut);
    UIRectFillUsingBlendMode(rect11,
                             kCGBlendModeDestinationOver);
    UIRectFillUsingBlendMode(rect12,
                             kCGBlendModeDifference);
    UIRectFillUsingBlendMode(rect13,
                             kCGBlendModeExclusion);
    UIRectFillUsingBlendMode(rect14,
                             kCGBlendModeHardLight);
    UIRectFillUsingBlendMode(rect15, kCGBlendModeHue);
    UIRectFillUsingBlendMode(rect16, kCGBlendModeLighten);
    UIRectFillUsingBlendMode(rect17,
                             kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(rect18, kCGBlendModeMultiply);
    UIRectFillUsingBlendMode(rect19, kCGBlendModeNormal);
    UIRectFillUsingBlendMode(rect20, kCGBlendModeOverlay);
    UIRectFillUsingBlendMode(rect21,
                             kCGBlendModePlusDarker);
    UIRectFillUsingBlendMode(rect22,
                             kCGBlendModePlusLighter);
    UIRectFillUsingBlendMode(rect23,
                             kCGBlendModeSaturation);
    UIRectFillUsingBlendMode(rect24, kCGBlendModeScreen);
    UIRectFillUsingBlendMode(rect25,
                             kCGBlendModeSoftLight);
    UIRectFillUsingBlendMode(rect26,
                             kCGBlendModeSourceAtop);
    UIRectFillUsingBlendMode(rect27, kCGBlendModeSourceIn);
    UIRectFillUsingBlendMode(rect28,
                             kCGBlendModeSourceOut);
    UIRectFillUsingBlendMode(rect29, kCGBlendModeXOR);
}

@end
