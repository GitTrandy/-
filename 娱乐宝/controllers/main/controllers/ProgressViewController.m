//
//  ProgressViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/6/1.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "ProgressViewController.h"
#import "DACircularProgressView.h"
@interface ProgressViewController ()
{
    DACircularProgressView *progress;
    NSTimer *timer;
}
@end

 float a=0.0;

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    progress = [[DACircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    [progress setCenter:CGPointMake((int)_icon.bounds.size.width / 2, 36)];
    [progress setTrackTintColor:[UIColor lightGrayColor]];
    [progress setProgressTintColor:[UIColor darkGrayColor]];
    [progress setAlpha:0.8];
    [_icon addSubview:progress];

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

- (IBAction)downLoad:(id)sender {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                             target:self
                                           selector:@selector(showProgress)
                                           userInfo:nil
                                            repeats:YES];
}
- (void)showProgress{
    a= a+0.01;
    if (a<=1) {
        progress.progress =a;
  
    }else{
        [timer invalidate];
    }
}
@end
