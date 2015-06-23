//
//  UIViewAnimationViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/22.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

//UIView实现基础动画
//UIView动画封装 其实UIView本身对于基本动画和关键帧动画、转场动画都有相应的封装，在对动画细节没有特殊要求的情况下使用起来要简单的多，可以说在日常开发中90%以上的情况使用UIView的封装都可以搞定

#import "UIViewAnimationViewController.h"
#import "DampViewController.h"
@interface UIViewAnimationViewController ()
{
    UIImageView *_imageView;
}

@property (nonatomic,strong)DampViewController *dampCtr;
@end

@implementation UIViewAnimationViewController

- (void)btnClik{
    _dampCtr = [[DampViewController alloc] init];
    [self.navigationController pushViewController:_dampCtr animated:YES];
    
}
- (void)drawHearder
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 100, 20);
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"弹性动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClik) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem =rightItem;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self drawHearder];
    
    
    //设置背景
    UIImage *backgroudColor = [UIImage imageNamed:@"backgroudImage.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroudColor];
    
    //创建图像显示控件
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leap.png"]];
    _imageView.frame = CGRectMake(0, 0, 30, 30);
    _imageView.center = CGPointMake(50, 150);
    [self.view addSubview:_imageView];
    

}

#pragma mark 点击时间

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    //方法一：block方式
    /*开始动画，UIView的动画执行完后动画会停留在重点位置而不需要进行任何特殊的处理
     duration:执行时间
     delay：延迟时间
     options：动画设置，例如自动回复，匀速运动
     completion:动画完成回调方法
     */
//    [UIView animateWithDuration:5.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        _imageView.center = location;
//    } completion:^(BOOL finished) {
//        NSLog(@"Animation end");
//    }];
    
    //方法2；静态方法
    //开始动画
    [UIView beginAnimations:@"KCBasicAnimation" context:nil];
    
    [UIView setAnimationDuration:5.0];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:10];
  //  [UIView setAnimationWillStartSelector:@selector]//动画开始运动的执行方法
  //  [UIView setAnimationDidStopSelector:<#(SEL)#>];//动画运行结束后的执行方法
    
    _imageView.center = location;
    
    //开始动画
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
