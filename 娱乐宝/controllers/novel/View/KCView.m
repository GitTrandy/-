//
//  KCView.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/15.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "KCView.h"
#import "KCLayer.h"
@implementation KCView


- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame:");
    self = [super initWithFrame:frame];
    if (self) {
        KCLayer *layer = [[KCLayer alloc] init];
        layer.bounds = CGRectMake(0, 0, 185, 185);
        layer.position = CGPointMake(160, 284);
        layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
        //显示图层
        
        [layer setNeedsDisplay];
        [self.layer addSublayer:layer];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"2-drawRect:");
    NSLog(@"CGContext:%@",UIGraphicsGetImageFromCurrentImageContext());
    
    //得到当前图形上下文正是drawLayer中传递的
    [super drawRect:rect];
    
}


@end
