//
//  QuartViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/22.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "QuartViewController.h"
#import "KCView1.h"
#import "KCView2.h"
#import "KCView3.h"
#import "KCView4.h"
#import "KCView5.h"
@interface QuartViewController ()
{
    KCView1 *view;
    KCView2 *view2;
    NSMutableArray *_dataArray;
}
@end

@implementation QuartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *items = @[@"路径",@"封装",@"矩椭弧贝",@"文字图片",@"渐变"];
    
    UISegmentedControl *segmentCtr = [[UISegmentedControl alloc] initWithItems:items];
    segmentCtr.frame =CGRectMake(10, 80, 300, 40);
    segmentCtr.selectedSegmentIndex=0;
    [segmentCtr addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentCtr];
    
    
    
    
    CGRect rect =CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-140);

    view = [[KCView1 alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [_dataArray addObject:view];

    view2 = [[KCView2 alloc] initWithFrame:rect];
    view2.backgroundColor = [UIColor whiteColor];
    [_dataArray addObject:view2];

    KCView3 *view3 = [[KCView3 alloc] initWithFrame:rect];
    view3.backgroundColor = [UIColor whiteColor];
    [_dataArray addObject:view3];
    
    KCView4 *view4 = [[KCView4 alloc] initWithFrame:rect];
    view4.backgroundColor = [UIColor whiteColor];
    [_dataArray addObject:view4];
    
    KCView5 *view5 = [[KCView5 alloc] initWithFrame:rect];
    [_dataArray addObject:view5];
    
                


}

//查看视图
- (void)change:(UISegmentedControl *)segment
{
    NSLog(@"select is %li",(long)segment.selectedSegmentIndex);
    NSInteger index = segment.selectedSegmentIndex;
    for (id obj in self.view.subviews) {
        if (![obj isKindOfClass:[UISegmentedControl class]]) {
            [obj removeFromSuperview];

        }
    }
        [self.view addSubview:_dataArray[index]];


}

- (void)addView1
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
