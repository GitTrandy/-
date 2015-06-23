//
//  KCView.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/22.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "KCView1.h"

@implementation KCView1

//绘图只能在此方法中调用，否则无法的到当前图形上下文
- (void)drawRect:(CGRect)rect {

    //1.取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.创建路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 100);//移到指定位置（设置路径起点）
    CGPathAddLineToPoint(path, nil, 20, 150);//绘制直线（从起点位置开始）
    CGPathAddLineToPoint(path, nil, 300, 150);//绘制另一条直线（从上一条直线终点开始绘制）
    //3.添加路径到图形上下文
    CGContextAddPath(context, path);
    
    //4.设置图形的上下文状态属性
    
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充颜色
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    CGContextSetLineCap(context, kCGLineCapRound);//设置顶底样式，（20，50）和（300，100）的顶点
    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，（20，100）是连接点
    /*设置线段样式
     phase:虚线开始的位置
     lenghts：虚线长度间隔
     count：虚线数组元素个数
     */
    
    CGFloat lenghts[2] = {18,9};
    CGContextSetLineDash(context, 0, lenghts, 2);
    
    //设置阴影
    /*
     context:图形上下文
     offset：偏移量
     blur：模糊度
     color：阴影颜色
     */
    
    CGColorRef color = [UIColor grayColor].CGColor;
    CGContextSetShadowWithColor(context, CGSizeMake(2, 3), 0.8, color);
    
    //5.绘制图像到指定的图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充(非零缠绕数填充),不绘制边框 
     kCGPathEOFill:奇偶规则填充(多条路径交叉时,奇数交叉填充,
     偶交叉不填充)
     kCGPathStroke:只有边框
     kCGPathFillStroke:既有边框又有填充 
     kCGPathEOFillStroke:奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    
    
    //6.释放对象
    CGPathRelease(path);

}


@end
