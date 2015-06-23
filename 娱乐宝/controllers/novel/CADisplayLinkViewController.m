//
//  CADisplayLinkViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/21.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "CADisplayLinkViewController.h"
#define IMAGE_COUNT 8

@interface CADisplayLinkViewController ()
{
    CALayer *_layer;
    int _index;
    NSMutableArray *_images;
}
@end

@implementation CADisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (id)[UIImage imageNamed:@"backgroudImage.png"].CGImage;
    
    //创建显示图层
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 87, 32);
    _layer.position = CGPointMake(160, 284);
    [self.view.layer addSublayer:_layer];
    //由于鱼的图片在循环中不断创建，而9张图片相对都较小
    //与其在循环中不断创建UIImage，不如直接将9张图片缓存起来
    
    _images = [NSMutableArray array];
    //_images = [[NSMutableArray alloc] init];
    for (int i=0; i<8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"b%i.png",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [_images addObject:image];
    }
    
    //定义时钟对象
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    
    //添加时钟对象到主循环
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

}

#pragma mark 每次屏幕刷新就会执行一次此方法（美妙接近60次）

- (void)step
{
    //定义一个变量记录执行次数
    static int s = 0;
    
    //每秒执行6次
    if (++s%8==0) {
        NSLog(@"index is %i",_index);
        UIImage *image = _images[_index];
        _layer.contents = (id)image.CGImage;
        _index = (_index + 1)%IMAGE_COUNT;
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
