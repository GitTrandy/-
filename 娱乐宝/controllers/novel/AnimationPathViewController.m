//
//  AnimationPathViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/20.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//  通过path设置关键帧动画

#import "AnimationPathViewController.h"

@interface AnimationPathViewController ()
{
    CALayer *_layer;
}
@end

@implementation AnimationPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景图
    UIImage *backgroudImage = [UIImage imageNamed:@"backgroudImage.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroudImage];
    
    //自定义一个层
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 30, 40);
    _layer.position = CGPointMake(100, 150);
    _layer.contents = (id)[UIImage imageNamed:@"leap.png"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    //创建动画
    [self translationAnimation];


}

#pragma mark -translationAnimation code

- (void)translationAnimation{

    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置路径
    //绘制贝塞尔曲线
    CGMutablePathRef  path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
    // CGPathAddArc(path, NULL, 150,150 , 50, 0, 360, YES);//绘制圆形
    //CGPathAddArcToPoint(path, NULL, 0, 100, 100, 200, 50);
    //CGAffineTransform *affineTransform =
    // CGPathAddEllipseInRect(path, nil, CGRectMake(100, 300, 100, 200));//椭圆

    
    keyFrameAnimation.path = path;//设置path属性
    CGPathRelease(path);//释放路径对象
    
    //设置其他属性
    keyFrameAnimation.duration = 10.0;
    keyFrameAnimation.beginTime = CACurrentMediaTime();//设置延迟5秒执行
    
    //3.添加动画到图层,添加后就会执行动画
    [_layer addAnimation:keyFrameAnimation forKey:@"KCKeyFrameAnimation_Positon"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   // UITouch *touch =[touches anyObject];
    [self translationAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
