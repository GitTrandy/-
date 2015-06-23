//
//  JKAudioToolController.m
//  娱乐宝
//
//  Created by zhangjikuan on 15/6/16.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "JKAudioToolController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define kMusicFile @"孙燕姿-遇见.mp3"
#define kMusicSinger @"孙燕姿"
#define kMusicTitle @"遇见"
@interface JKAudioToolController ()<AVAudioPlayerDelegate>
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//播放器
@property (weak, nonatomic) IBOutlet UIImageView *singerImage;

@property (weak, nonatomic) IBOutlet UILabel *controlPanel;
@property (weak, nonatomic) IBOutlet UIButton *playOrPause;
@property (weak, nonatomic) IBOutlet UIProgressView *playProgress;
@property (weak, nonatomic) IBOutlet UILabel *musicSinger;
@property (weak,nonatomic) NSTimer *timer;

@end

@implementation JKAudioToolController

- (void)viewDidLoad {
    [super viewDidLoad];

   // [self playSoundEffect:@"videoRing"];
    [self setupUI];
}

void soundComleteCallBack(SystemSoundID soundID,void *clientData) {

    NSLog(@"播放完成");
}
- (void)setupUI {
    self.title = kMusicTitle;
    self.musicSinger.text = kMusicSinger;
    self.view.backgroundColor = [UIColor clearColor];
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    bgImageView.image = [UIImage imageNamed:@"16.png"];
//    [self.view addSubview:bgImageView];
    self.singerImage.image = [UIImage imageNamed:@"16.png"];
    
}
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:true];
        
    }
    return _timer;

}

- (AVAudioPlayer *)audioPlayer {

    if (!_audioPlayer) {
        NSString *urlStr = [[NSBundle mainBundle]pathForResource:kMusicFile ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        //设置播放器属性
        _audioPlayer.numberOfLoops = 0;//设置为0不循环
        _audioPlayer.delegate = self;
        [_audioPlayer prepareToPlay];//加载音频文件到缓存
        if (error) {
            NSLog(@"初始化播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;

        }
        
        //设置后天播放模式
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
        //添加通知，拔出耳机后暂停播放
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(routeChange:)
                                                     name:AVAudioSessionRouteChangeNotification
                                                   object:nil];
    }
    return _audioPlayer;
}

- (void)playSoundEffect:(NSString *)name {
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:@"caf"];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    //1.获得系统声音ID
    SystemSoundID soundID = 0;
    /*
     inFileUrl:音频文件url
     outSystemSoundID:声音id （此函数会将音效文件加入到系统文件中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundComleteCallBack, NULL);
    
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);
    
    
}
#pragma mark 播放音频
- (void)play {
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
        self.timer.fireDate = [NSDate distantPast];//恢复定时器
        
    }

}

#pragma mark 暂停播放
- (void)pause {
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer pause];
        self.timer.fireDate = [NSDate distantFuture];//暂停定时器，注意不能
    }

}
- (IBAction)playClick:(UIButton *)sender {
    if (sender.tag) {
        sender.tag = 0;
        [sender setTitle:@"start" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"playing_btn_paly_n"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"playing_btn_paly_h"] forState:UIControlStateHighlighted];
        [self pause];
        
    } else {
        sender.tag = 1;
        [sender setTitle:@"pause" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"playing_btn_pause_n"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"playing_btn_pause_h"] forState:UIControlStateHighlighted];
        [self play];
    }
}

#pragma mark - 更新播放进度
- (void)updateProgress {
    float progress = self.audioPlayer.currentTime/self.audioPlayer.duration;
    [self.playProgress setProgress:progress];
    
}

- (void)routeChange:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    int changeReason = [dict[AVAudioSessionRouteChangeReasonKey] intValue];
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription = dict[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription = [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            [self pause];
            
        }
    }
}
#pragma mark 播放器代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"音乐播放完成。。。");
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
