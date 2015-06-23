//
//  CoreAnimationViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/15.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "CoreAnimationViewController.h"
#import "CAAnimationiViewController.h"
@interface CoreAnimationViewController ()
@property(nonatomic,strong)CAAnimationiViewController *CACtr;


- (IBAction)coreAnimation:(id)sender;


@end

@implementation CoreAnimationViewController
{
    CALayer *_layer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //调用UIView的块代码实现一个动画效果
    UIImage *image = [UIImage imageNamed:@"photo.jpg"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake(120, 140, 80, 80);
    [self.view addSubview:imageView];
    
    //两秒后开始一个持续的动画
    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        imageView.frame = CGRectMake(40, 100, 240, 240);
    } completion:nil];
    
    //如果不使用UIView封装的方法创建动画，动画创建一般分为以下几步
    
    //1.初始化动画并设置动画属性
    
    //2.设置动画属性初始值（可以省略）、结束值以及其他动画属性
    
    //3.给图层添加动画
    
    //下面以一个移动的动画为例，在这个例子中点击屏幕哪个位置落花将飞向哪里
    

    
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

- (IBAction)coreAnimation:(id)sender {
    _CACtr = [[CAAnimationiViewController alloc] init];
    [self.navigationController pushViewController:_CACtr animated:YES];
    
}
@end
