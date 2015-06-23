//
//  AnimationValuesViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/20.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//
// 通过values 设置关键帧动画

#import "AnimationValuesViewController.h"

@interface AnimationValuesViewController ()
{
    CALayer *_layer;
}
@end

@implementation AnimationValuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置背景
    UIImage *backgroudImage = [UIImage imageNamed:@"photo.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroudImage];
    
    //自定义一个图层
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 30, 60);
    _layer.position = CGPointMake(50, 150);
    _layer.contents = (id)[UIImage imageNamed:@"section0_emotion2@2x.png"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    //创建动画
    [self translationAnimation];
}

#pragma mark -创建动画
- (void)translationAnimation{

    //1.创建关键帧动画并设置动画属性
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    
    //2.设置动画关键帧，这里有四个关键帧
    NSValue *key1 = [NSValue valueWithCGPoint:_layer.position];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(90, 400)];
    NSValue *key5 = [NSValue valueWithCGPoint:CGPointMake(45, 500)];
    
    NSArray *values = @[key1,key2,key3,key4,key5];
    keyframeAnimation.values = values;
    //设置其他属性
    keyframeAnimation.duration = 8.0;
    //设置延迟两秒执行
    keyframeAnimation.beginTime = CACurrentMediaTime()+2;
    
    //3.添加动画到其他层，添加动画后回执行动画
    
    [_layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
