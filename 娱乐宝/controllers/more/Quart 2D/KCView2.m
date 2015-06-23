//
//  KCView2.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/23.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "KCView2.h"

@implementation KCView2

- (void)drawRect:(CGRect)rect {

    //1。获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.绘制路径（相当于KCView1里面的创建路径并添加路径到图形上下文两步操作
    CGContextMoveToPoint(context, 20, 50);
    CGContextAddLineToPoint(context, 20, 100);
    CGContextAddLineToPoint(context, 300, 100);
    //封闭路径:a.创建⼀一条起点和终点的线,不推荐
    //CGPathAddLineToPoint(path, nil, 20, 50);
    //封闭路径:b.直接调⽤用路径封闭⽅方法
    CGContextClosePath(context);
    
    //设置图形上下文属性
    
    [[UIColor redColor] setStroke];//设置红色边框
    [[UIColor greenColor] setFill];//设置绿色填充
   // [[UIColor blueColor]set];//同时设置填充和边框
    
    //4.绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    
}


@end
