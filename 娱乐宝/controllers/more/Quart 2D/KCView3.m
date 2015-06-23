//
//  KCView3.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/23.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//  绘制矩形

#import "KCView3.h"

@implementation KCView3


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    //添加矩形对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    //绘制矩形
    [self drawrectWithOContext:context];
    
    [self drawRectBhUIKitWithContext:context];
   
    //绘制椭圆
    [self drawEllipse:context];
    //绘制弧形
    [self drawArc:context];
    //绘制贝塞尔曲线
    [self drawCurve:context];
    
}
#pragma mark 绘制贝塞尔曲线
- (void)drawCurve:(CGContextRef)context{

    //绘制曲线
    CGContextMoveToPoint(context, 20, 100);//移到起点位置
    
    /*
     绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddQuadCurveToPoint(context, 160, 0, 300, 100);
    CGContextMoveToPoint(context, 20, 300);
    
    
    /*绘制三次贝塞尔曲线
     c:图形上下文
     cp1x:第一个控制点x坐标
     cp1y:第一个控制点y坐标
     cp2x:第二个控制点x坐标
     cp2y:第二个控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddCurveToPoint(context, 80, 200, 240, 400, 300, 300);
    //设置图形上下文属性
    [[UIColor yellowColor] setFill];
    [[UIColor redColor] setStroke];
    
    //绘制路径
    
    CGContextDrawPath(context, kCGPathFillStroke);
    

}
#pragma mark 绘制弧形
- (void)drawArc:(CGContextRef)context{

    /*添加弧形对象
     x:中心点x坐标
     y:中心点y坐标
     radius:半径
     startAngle:起始弧度
     endAngle:终止弧度
     closewise:是否逆时针绘制，0则顺时针绘制
     */
    CGContextAddArc(context, 160, 160, 100.0, 0.0, M_PI_2/3, 0);
    //设置属性
    [[UIColor yellowColor] set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
    
}
#pragma mark 绘制椭圆
- (void)drawEllipse:(CGContextRef)context{

    //添加对象，绘制椭圆 （圆形）的过程也是先创建一个矩形
    CGRect rect = CGRectMake(50, 50, 220.0, 200.0);
    CGContextAddEllipseInRect(context, rect);
    //设置属性
    [[UIColor purpleColor] set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
    
}
#pragma mark 绘制矩形
- (void)drawrectWithOContext:(CGContextRef)context{

    CGRect rect1 = CGRectMake(20, 50, 280.0, 50.0);
    
    CGContextAddRect(context, rect1);
    
    //设置属性
    [[UIColor blueColor]set];
    
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}
#pragma mark 绘制矩形（利用UIKit的封装方法）
- (void)drawRectBhUIKitWithContext:(CGContextRef)context{
    CGRect rect = CGRectMake(20, 150, 280.0, 50);
    CGRect rect2 = CGRectMake(20, 250, 280.0, 50);
    
    //设置属性
    [[UIColor yellowColor]set];
    //绘制矩形，相当于创建对象，添加对象到上下文，绘制三个步骤
    
    UIRectFill(rect);//绘制图形 （只填充）
    
    [[UIColor redColor] setStroke];
    
    UIRectFrame(rect2);//绘制矩形 （只有边框）


}


@end
