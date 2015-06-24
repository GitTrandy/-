//
//  CAAnimationiViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/15.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "CAAnimationiViewController.h"

@interface CAAnimationiViewController ()

@end

@implementation CAAnimationiViewController
{
    CALayer *_layer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置背景（注意这个图片其实在跟视图）
    UIImage *backgroundImage = [UIImage imageNamed:@"photo.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 20, 20);
    //若是给图层添加旋转一个旋转的动画，需要强调的一点是图层的形变都是相对于锚点的
    //例如旋转，旋转的中心点就是锚点
    _layer.anchorPoint = CGPointMake(0.5, 0.6);//设置锚点
    _layer.position = CGPointMake(50, 150);
    _layer.contents = (id)[UIImage imageNamed:@"face@2x.png"].CGImage;
   
    [self.view.layer addSublayer:_layer];
    
    
}

#pragma mark 移动动画
- (void)translationAnimation:(CGPoint)location
{

    //1.创建动画并制定动画属性
    
    //基础动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //2.设置动画属性初始值和结束值
    
   // basicAnimation.fromValue = [NSNumber numberWithInt:1];
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    // 设置重复数。HUGE_VALF看做无限大，起着循环动画的效果
    // basicAnimation.repeatCount = HUGE_VALF;
    
    //basicAnimation.removedOnCompletion = YES;//运行一次是否移除动画
    
    //在动画开始前设置一个代理去监听动画的开始和结束事件，在动画开始前给动画添加一个自定义属性“KCBacsicAnimationLocation”存储动画终点位置，然后再动画结束后设置动画的位置为终点位置
    
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
    basicAnimation.delegate = self;
    
    //设置动画其他属性
    basicAnimation.duration = 5.0;//动画时间五秒
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得动画时可以以此名来获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
    
}

#pragma mark 旋转动画
- (void)rotationAnimation{

    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //2.设置动画属性初始值和结束值
  //  basicAnimation.fromValue = [NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue = [NSNumber numberWithInt:M_PI_2*3];
    
    //3.设置动画其他属性
    basicAnimation.duration = 5.0;
    //旋转后再旋转到原来的位置
    basicAnimation.autoreverses = true;
    basicAnimation.removedOnCompletion = NO;
    //4.添加到动画层,注意key相当于给动画命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_rotation"];
    
}


#pragma mark -动画代理方法

#pragma mark 动画开始

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animation(%@)start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前⾯面 的设置的key获得动画
    
}

#pragma mark -animationPause code动画暂停
- (void)animationPause{

    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval = [_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [_layer setTimeOffset:interval];
    //速度设置为0，暂停动画
    _layer.speed = 0;
    
    
}

#pragma mark -animationResume 重新恢复动画
- (void)animationResume
{
    //1.获取暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime()-_layer.timeOffset;
    
    //2.设置偏移量
    _layer.timeOffset = 0;
    
    //3.设置开始时间
    _layer.beginTime = beginTime;
    
    //设置动画速度、开始动画
    _layer.speed = 1.0;
}
#pragma mark 动画结束

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animation(%@)stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
   // _layer.position=[[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
#pragma mark 关闭隐式动画
    //1.开启事物
    [CATransaction begin];
    //2.禁止隐式动画
    [CATransaction setDisableActions:YES];
    _layer.position = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    //3.提交事务
    [CATransaction commit];
    
    //4.暂停动画
    [self animationPause];
}

#pragma mark 点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint  location = [touch locationInView:self.view];
    //判断是否已经创建过动画、如果已经创建则不再创建动画
    
    CAAnimation *animation = [_layer animationForKey:@"KCBasicAnimation_Translation"];
    if (animation) {
        if (_layer.speed==0) {
            //恢复动画
            [self animationResume];
        }else{
            //暂停动画
            [self animationPause];
        }
    } else{
        //创建并开始动画
        [self translationAnimation:location];
        
        [self rotationAnimation];

    }
    
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
