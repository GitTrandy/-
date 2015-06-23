//
//  AnimationsArrViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/20.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "AnimationsArrViewController.h"

@interface AnimationsArrViewController (){
    CALayer *_layer;
}

@end

@implementation AnimationsArrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *backgroudImage = [UIImage imageNamed:@"backgroudImage.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroudImage];
    
    //自定义一个图层
    _layer = [[CALayer alloc] init];
    _layer.frame = CGRectMake(0, 0, 10, 10);
    _layer.position = CGPointMake(50, 150);
    _layer.contents = (id)[UIImage imageNamed:@"leap.png"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    //创建动画
    [self groupAnimation];
}
#pragma mark -基础旋转动画
- (CABasicAnimation *)rotationAnimation
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    CGFloat toValue = M_PI_2*3;
    basicAnimation.toValue = [NSNumber numberWithFloat:toValue];
   // basicAnimation.duration = 6.0;
    basicAnimation.autoreverses = true;
    basicAnimation.repeatCount = HUGE_VALF;
    basicAnimation.removedOnCompletion = NO;
    [basicAnimation setValue:[NSNumber numberWithFloat:toValue] forKey:@"KCBasicAnimationProperty_ToValue"];
    return basicAnimation;
}

#pragma mark -关键帧动画
- (CAKeyframeAnimation *)tanslationAnimation
{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"] ;
    CGPoint endPoint = CGPointMake(55, 400);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, endPoint.x, endPoint.y);
    keyframeAnimation.path = path;
    CGPathRelease(path);
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"KCKeyframeAnimationProperty_EndPosition"];
    return keyframeAnimation;
    
}

#pragma mark -创建动画组
- (void)groupAnimation
{

    //1.创建动画组
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    //2.设置组中得动画和其他属性
    CABasicAnimation *basicAnimation = [self rotationAnimation];
    CAKeyframeAnimation *keyframeAnimation = [self tanslationAnimation];
    
    animationGroup.animations = @[basicAnimation,keyframeAnimation];
    
    animationGroup.delegate = self;
    animationGroup.duration = 10;//设置动画时间,如果动画组中 动画已经设置过动画属性则不再⽣生效
    animationGroup.beginTime = CACurrentMediaTime()+5;
    
    //3.给图层添加新动画
    [_layer addAnimation:animationGroup forKey:nil];
    
    
    
}
#pragma mark - 代理方法

#pragma mark - 动画完成
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CAAnimationGroup *animationGroup = (CAAnimationGroup *)anim;
    CABasicAnimation *basicAnimation = animationGroup.animations[0];
    CAKeyframeAnimation *keframeAnimation = animationGroup.animations[1];
    CGFloat toValue = [[basicAnimation valueForKey:@"KCBasicAnimationProperty_ToValue"] floatValue];
    CGPoint endPoint = [[keframeAnimation valueForKey:@"KCKeyframeAnimationProperty_EndPosition"]CGPointValue];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    //设置动画最终状态
    _layer.position = endPoint;
    _layer.transform = CATransform3DMakeRotation(toValue, 0, 0, 1);
    [CATransaction commit];

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
