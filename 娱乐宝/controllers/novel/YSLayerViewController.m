//
//  YSLayerViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/15.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "YSLayerViewController.h"

@interface YSLayerViewController ()

@end
#define WIDTH 50

@implementation YSLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self drawMyLayer];
}

#pragma mark 绘制图层
- (void)drawMyLayer
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    //获得根视图
    CALayer *layer = [[CALayer alloc] init];
    //设置背景颜色，由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    //设置中心点
    layer.position = CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    //设置圆角，当圆角的半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius = WIDTH/2;
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;
    [self.view.layer addSublayer:layer];
    
}

#pragma mark 点击放大

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CALayer *layer = self.view.layer.sublayers[0];
    CGFloat width = layer.bounds.size.width;
    if (width==WIDTH) {
        width = WIDTH*4;
    } else {
        width = WIDTH;
    }
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = [touch locationInView:self.view];
    layer.cornerRadius = width/2;
    

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
