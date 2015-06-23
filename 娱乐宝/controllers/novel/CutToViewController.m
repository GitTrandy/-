//
//  CutToViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/21.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "CutToViewController.h"
#define IMAGE_COUNT 17

@interface CutToViewController ()
{
    UIImageView *_imageView;
    int _currentIndex;
}
@end

@implementation CutToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _currentIndex = 0;
    //定义图片控件
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = [UIScreen mainScreen].applicationFrame;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:@"0.png"];
    [self.view addSubview:_imageView];
    
    //添加手势
    
    UISwipeGestureRecognizer *leftSwipGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                           initWithTarget:self action:@selector(leftSwip:)];
    leftSwipGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipGestureRecognizer];
    
    
    UISwipeGestureRecognizer *rightSwipGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                           initWithTarget:self action:@selector(rightSwip:)];
    rightSwipGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipGestureRecognizer];
    
    
    


}


#pragma mark 向左滑动浏览下一张图片
- (void)leftSwip:(UISwipeGestureRecognizer *)gesture{

    [self transitionAnimation:YES];
}

#pragma mark 向右浏览上一张图片
- (void)rightSwip:(UISwipeGestureRecognizer *)gesture{

    [self transitionAnimation:NO];
}

#pragma mark - 转场动画
- (void)transitionAnimation:(BOOL)isNext
{

    //1.创建转场动画对象
    CATransition *transition = [[CATransition alloc] init];
    
    //2.设置动画类型，注意对于苹果官方，没有公开的动画类型，只能使用字符串，并没有对应的常量定义
    transition.type = self.catogoryName;
    //设置子类型
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    } else {
        transition.subtype = kCATransitionFromLeft;
    }
    //设置动画时长
    transition.duration = 1.0f;
    //3.设置转场后的新视图添加转场动画
    _imageView.image = [self getImage:isNext];
    
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

- (UIImage *)getImage:(BOOL)isNext
{
    if (isNext) {
        _currentIndex = (_currentIndex +1)%IMAGE_COUNT;
        
    } else{
        _currentIndex = (_currentIndex -1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    
    NSLog(@"_currentIndex is %d",_currentIndex);
    NSString *imageName = [NSString stringWithFormat:@"%i.png",_currentIndex];
    return [UIImage imageNamed:imageName];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end




