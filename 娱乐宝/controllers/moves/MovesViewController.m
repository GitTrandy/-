//
//  MovesViewController.m
//  推送测试
//
//  Created by Zhang_JK on 15/3/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "MovesViewController.h"
#import "JKAudioToolController.h"
#import "MPViewController.h"
#import "JKRecordViewController.h"
@interface MovesViewController ()
{
    NSMutableArray *_dataArray;
    
}
@end

@implementation MovesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"AudioToolbx音效播放",@"MPMusicPlayerController播放音乐库中的音乐",@"录音", nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identy];
        
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
            [self jump2AudioToolbox];
            break;
        case 1:
            [self jump2MPViewController];
            break;
        case 2:
            [self jump2JKRecordViewController];
            break;

        default:
            break;
    }
}

- (void)jump2AudioToolbox {
    JKAudioToolController *jkAudioTool = [[JKAudioToolController alloc] init];
    [self.navigationController pushViewController:jkAudioTool animated:YES];
    
}

- (void)jump2MPViewController {
    MPViewController *mpCtr = [[MPViewController alloc] init];
    [self.navigationController pushViewController:mpCtr animated:YES];

}

- (void)jump2JKRecordViewController {
    JKRecordViewController *jkRrecoder = [[JKRecordViewController alloc] init];
    [self.navigationController pushViewController:jkRrecoder animated:YES];
    
}
@end
