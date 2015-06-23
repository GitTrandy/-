//
//  NSThread实现多线程
//  娱乐宝
//
//  Created by Zhang_JK on 15/6/5.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "NSThreadViewController.h"
#import "JKImageData.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface NSThreadViewController (){
    UIImageView *_imageView;
    
    NSMutableArray *_imageViews;
    
}

@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

#pragma mark 界面布局
- (void)layoutUI {
    _imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

#pragma mark 将图片显示到界面上
- (void)updateImage:(NSData *)data {
    UIImage *image = [UIImage imageWithData:data];
    _imageView.image  = image;
}

#pragma mark 请求图片数据
- (NSData *)requestData {

    //对于多线程操作建议把线程操作放到@autoreleasepool中
    @autoreleasepool {
        NSURL *url = [NSURL URLWithString:@"http://36.0.16.99/ipad/plTypeMilDefault07.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        return data;
    }
}


#pragma mark 加载图片
- (void)loadImage {

    //请求数据
    NSData *data =[self requestData];
    //将数据显示到UI控件，注意只能在主线程中更新UI，
    /*
     另外performSelectorOnMainThread⽅法是NSObject的分类⽅法,每个NSObject对象都有此⽅法,
     它调⽤用的selector方法是当前调用控件的⽅法,例如使用 UIImageView调⽤用的时候selector就是UIImageView的方法
     Object:代表调⽤用⽅方法的参数,不过只能传递⼀个参数(如果有多个 参数请使⽤用对象进⾏行封装)
     waitUntilDone:是否线程任务完成执⾏行*/
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
}
#pragma mark 多线程下载图片
- (void)loadImageWithMultiThread {

    //方法1：使用对象方法
//    NSThread  *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImage) object:nil];
//    //注意:启动一个线程并非就是一定立即执行，而是处于就绪状态，当系统调度时才真正执行
//    [thread start];
    
    //方法2：使用类方法
   
    [NSThread detachNewThreadSelector:@selector(loadImage)
                             toTarget:self withObject:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
