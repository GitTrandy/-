//
//  DRCALayerViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/15.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "DRCALayerViewController.h"
#define PHOTO_HEIGHT 150

static int runTimes=0;

@interface DRCALayerViewController ()
@property (nonatomic,strong)CALayer *layer;
@property (nonatomic,strong)NSMutableArray *mArr;
@end

@implementation DRCALayerViewController

@synthesize layer;
@synthesize mArr;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
/*
    
    
    //⾃自定义图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=CGRectMake(0, 0, PHOTO_HEIGHT,PHOTO_HEIGHT);
    layer.position=CGPointMake(160, 200);
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=PHOTO_HEIGHT/2;
    //注意仅仅设置圆⾓角,对于图形⽽而⾔言可以正常显⽰示,但是对于图层中
    //绘制的图⽚片⽆无法正确显⽰示
    //如果想要正确显⽰示则必须设置masksToBounds=YES,剪切⼦子图层
    layer.masksToBounds=YES;
    //阴影效果⽆无法和masksToBounds同时使⽤用,因为masksToBounds的⽬目的就是剪切外边框,
    //⽽而阴影效果刚好在外边框
    //    layer.shadowColor=[UIColor grayColor].CGColor;
    //    layer.shadowOffset=CGSizeMake(2, 2);
    //    layer.shadowOpacity=1;
    //设置边框
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=2;
    //设置图层代理
    layer.delegate=self;
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    //调⽤用图层setNeedDisplay,否则代理⽅方法不会被调⽤用
    [layer setNeedsDisplay];
*/
    CGPoint position = CGPointMake(160, 200);
    
    CGRect bounds=CGRectMake(0, 0, PHOTO_HEIGHT,
                             PHOTO_HEIGHT);
    CGFloat cornerRadius=PHOTO_HEIGHT/2;
    CGFloat borderWidth=2;
    
    //阴影图层
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = bounds;
    layerShadow.position = position;
    layerShadow.cornerRadius = cornerRadius;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2, 1);
    layerShadow.shadowOpacity = 1;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = borderWidth;
    [self.view.layer addSublayer:layerShadow];
    
    
    //容器图层
    layer = [[CALayer alloc] init];
    layer.bounds = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = cornerRadius;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = borderWidth;
    
    //利用
   // layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    //设置图层代理
    [layer setValue:@M_PI  forKeyPath:@"transform.rotation.x"];
   
    //mArr = [[NSMutableArray alloc] initWithObjects:@M_PI,@M_PI_4,@M_1_PI,@M_2_PI, nil];
    
//    NSTimer *timer;
//    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(setMove) userInfo:nil repeats:YES];
//    
    //如果仅仅显示一张图片在图层中没有必要那么麻烦
//    UIImage *image = [UIImage imageNamed:@"photo.jpg"];
//    //设置内容（注意这里一定要转换为CGImage）
//    // layer.contents = (id)image.CGImage;
//    [layer setContents:(id)image.CGImage];
    
    
    layer.delegate = self;
    
    //添加图层到跟图层
    [self.view.layer addSublayer:layer];
    
    //调用图层setNeedDisplay方法
    
    [layer setNeedsDisplay];
    
    //图层的形变
    

    
}

- (void)setMove{

    int i=runTimes%mArr.count;
    [layer setValue:mArr[i] forKeyPath:@"transform.rotation.x"];
    runTimes++;
}

/*形变对于动画有特殊的意义在动画开发中形变往往不是直接设置transform，而是通过keyPath进行设置
这种方法的设置形变的本质和前面没有本质的区别，只是利用了KVC可以动态的修改属性值而已。但是这种方式在动画中确实是很常用的，因为他可以很方便的将几种组合到一起使用。同样是解决动画旋转问题，只要将前面的旋转代码改为下面的代码即可：
 */
#pragma mark 绘制图形、图像到图层,注意参数中的ctx是图层的图形 上下⽂文,其中绘图位置也是相对图层⽽而⾔言的 

-(void)drawLayer:(CALayer *)layer inContext: (CGContextRef)ctx
{
    NSLog(@"%@",layer);//这个图层正是上⾯面定义的图层
   
    CGContextSaveGState(ctx);
    
//    //图形上下⽂形变,解决图⽚倒⽴的问题
//    CGContextScaleCTM(ctx, 1, -1);
//    
//    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);

    UIImage *image=[UIImage imageNamed:@"photo.jpg"];
    
    //注意这个位置是相对于图层⽽言的不是屏幕
    
    CGContextDrawImage(ctx, CGRectMake(0, 0,PHOTO_HEIGHT,PHOTO_HEIGHT), image.CGImage);
 
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGContextRestoreGState(ctx);

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
   
    CALayer *layerShadow = self.view.layer.sublayers[0];
    CALayer *layer1 = self.view.layer.sublayers[1];
    CGFloat width = layer.bounds.size.width;
    
    if (width==PHOTO_HEIGHT) {
        width = PHOTO_HEIGHT*4;
    } else {
        width = PHOTO_HEIGHT;
    }
    
    layerShadow.bounds =  CGRectMake(0, 0, width, width);
    layerShadow.position = [touch locationInView:self.view];
    layerShadow.cornerRadius = width/2;

    
    layer1.bounds = CGRectMake(0, 0, width, width);
    layer1.position = [touch locationInView:self.view];
    layer1.cornerRadius = width/2;
    
    



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
