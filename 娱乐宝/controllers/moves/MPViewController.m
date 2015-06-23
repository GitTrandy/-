//
//  MPViewController.m
//  娱乐宝
//
//  Created by zhangjikuan on 15/6/16.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "MPViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface MPViewController ()
<MPMediaPickerControllerDelegate>
@property (nonatomic,strong)MPMediaPickerController *mediaPicker;
@property (nonatomic,strong)MPMusicPlayerController *musicPlayer;

@end

@implementation MPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
/**
 *获得音乐播放器
 *
 *@return音乐播放器
 */
- (MPMusicPlayerController *)musicPlayer {
    if (!_musicPlayer) {
        _musicPlayer = [MPMusicPlayerController systemMusicPlayer];
        [_musicPlayer beginGeneratingPlaybackNotifications];
        [self addNotification];
        
        [_musicPlayer setQueueWithItemCollection:[self getLoactionMediaItemCollection]];
        
    }

    return _musicPlayer;
}
/*
 创建媒体选择器
 *
 @return 媒体选择器
 */
- (MPMediaPickerController *)mediaPicker {
    if (!_mediaPicker) {
        _mediaPicker =[[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAny];
        _mediaPicker.prompt = @"请选择要播放的音乐";
        _mediaPicker.delegate = self;
    }
    return  _mediaPicker;
}
/**
 *取得媒体队列
 *
 * @return 媒体队列
 */

- (MPMediaQuery *)getLocalMediaQuery {
    MPMediaQuery *mediaQueue = [MPMediaQuery songsQuery];
    for (MPMediaItem *item in mediaQueue.items) {
        NSLog(@"标题：%@，%@",item.title,item.albumTitle);
    }
    return mediaQueue;
}
/**
 *取得媒体集合
 *
 * @return 媒体集合
 */
- (MPMediaItemCollection *)getLoactionMediaItemCollection {
    
    MPMediaQuery *mediaQueue = [MPMediaQuery songsQuery];
    NSMutableArray *array =  [NSMutableArray array];
    for (MPMediaItem *item in mediaQueue.items) {
        [array addObject:item];
        NSLog(@"标题：%@,%@",item.title,item.albumTitle);
    }
    MPMediaItemCollection *mediaItemCollection = [[MPMediaItemCollection alloc] initWithItems:[array copy]];
    
    return mediaItemCollection;
    
}
#pragma mark -MPMediaPickerController 代理方法
//选择完成
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    MPMediaItem *mediaItem = [mediaItemCollection.items firstObject];//第一个播放音乐
    NSString *title = [mediaItem valueForKey:MPMediaItemPropertyAlbumTitle];
    NSString *artist = [mediaItem valueForKey:MPMediaItemPropertyAlbumArtist];
    MPMediaItemArtwork *artWork = [mediaItem valueForKey:MPMediaItemPropertyArtwork];
    NSLog(@"标题：%@，表演者：%@，专辑：%@",mediaItem.title,mediaItem.artist,mediaItem.albumTitle);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//取消选择
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 添加通知
- (void)addNotification {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(playbackStateChange:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
    
    
}
- (void)playbackStateChange:(NSNotification *)notification {
    switch (self.musicPlayer.playbackState) {
        case MPMusicPlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMusicPlaybackStatePaused:
            NSLog(@"暂停播放...");
            break;
        case MPMusicPlaybackStateStopped:
            NSLog(@"播放停止...");
            break;
        default:
            break;
    }
}

- (IBAction)slectClick:(UIButton *)sender {
    [self presentViewController:self.mediaPicker animated:YES completion:nil];
}
- (IBAction)playClick:(UIButton *)sender {
    [self.musicPlayer play];
}
- (IBAction)pauseClick:(id)sender {
    [self.musicPlayer pause];
}

- (IBAction)stopClick:(id)sender {
    [self.musicPlayer stop];
}

- (IBAction)nextClick:(id)sender {
    [self.musicPlayer skipToNextItem];
}

- (IBAction)prevClick:(id)sender {
    [self.musicPlayer skipToPreviousItem];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [self.musicPlayer endGeneratingPlaybackNotifications];
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
