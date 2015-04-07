//
//  MainViewController.m
//  推送测试
//
//  Created by Zhang_JK on 15/3/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "MainViewController.h"
#import "MovesDetailController.h"
#import "MusicDetailController.h"
#import "NewsDetailController.h"
#import "NovesDetailController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)movesDetailAction:(UIButton *)sender {
    MovesDetailController *moves = [[MovesDetailController alloc] init];
    //[self presentViewController:moves animated:YES completion:nil];
    [self.navigationController pushViewController:moves animated:YES];
    
}
- (IBAction)musicDetailAction:(UIButton *)sender {
    MusicDetailController *music = [[MusicDetailController alloc] init];

    [self.navigationController pushViewController:music animated:YES];
    
}
- (IBAction)newsDeitailAction:(UIButton *)sender {
    NewsDetailController *news = [[NewsDetailController alloc] init];
    [self.navigationController pushViewController:news animated:YES];
}
- (IBAction)noveiDetialAction:(UIButton *)sender {
    NovesDetailController *novel= [[NovesDetailController alloc] init];
    [self.navigationController pushViewController:novel animated:YES];
    
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
