//
//  DampViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/22.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "DampViewController.h"

@interface DampViewController ()
{
    UIImageView *_imageView ;
}
@end

@implementation DampViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建图像显示控件
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    _imageView.frame = CGRectMake(0, 0, 50, 50);
    _imageView.center = CGPointMake(160, 80);
    [self.view addSubview:_imageView];
}

#pragma mark -touch事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _imageView.center = location;
    } completion:^(BOOL finished) {
        NSLog(@"animation end");
        
    }];
    
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
