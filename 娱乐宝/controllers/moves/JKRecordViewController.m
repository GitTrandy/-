//
//  JKRecordViewController.m
//  娱乐宝
//
//  Created by zhangjikuan on 15/6/19.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "JKRecordViewController.h"
#define kRecordAudioFile @"myRecord.caf"
@interface JKRecordViewController ()<AVAudioRecorderDelegate>
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音
@property (nonatomic,strong) NSTimer *timer;//录音声波监控
@property (weak, nonatomic) IBOutlet UIButton *record;//开始录音
@property (weak, nonatomic) IBOutlet UIButton *pause;//暂停录音
@property (weak, nonatomic) IBOutlet UIButton *resume;//恢复录音

@property (weak, nonatomic) IBOutlet UIButton *stop;//录音停止
@property (weak, nonatomic) IBOutlet UIProgressView *audioPower;

@end

@implementation JKRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAudioSession];
}
#pragma mark - 设置音频会话
- (void) setAudioSession {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //设置播放和录音状态
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    
}


#pragma mark 取得录音文件保存路径
- (NSURL *)getSavePath {
    NSString *urlStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr = [urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"filePath is %@",urlStr);
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    return url;

}
#pragma mark 取得录音文件设置
- (NSDictionary *)getAudioSetting {
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    return dicM;
}
#pragma mark - 获取录音机对象
- (AVAudioRecorder *)audioRecorder {
    if (!_audioPlayer) {
        NSURL *url = [self getSavePath];
        //创建录音格式设置
        NSDictionary *setting = [self getAudioSetting];
        //创建录音机
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error: &error];
        
        _audioPlayer.delegate = self;
        _audioPlayer.meteringEnabled = YES;//如果要监测声波则必须设置为yes
        if (error) {
            NSLog(@"创建录音对象发生错误，错误信息");
        }
    }
    return _audioRecorder;
    
}
#pragma mark -创建播放器
- (AVAudioPlayer *)audioPlayer {
    if (!_audioPlayer) {
        NSURL *url = [self getSavePath];
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops = 0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发错误,错误信息%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}
#pragma mark 录音声波状态设置
- (void)audioPowerChange {
    [self.audioRecorder updateMeters];
    float power = [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围是-160到0；
    CGFloat progress = (1.0/160.0)*(power + 160);
    [self.audioPower setProgress:progress];
    
    
}
- (IBAction)recordClick:(id)sender {
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder record];
        self.timer.fireDate = [NSDate distantPast];
    }
}

- (IBAction)pauseClick:(id)sender {
    
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
}

- (IBAction)resumeClick:(id)sender {
    [self recordClick:sender];
}

- (IBAction)stopClick:(id)sender {
    [self.audioRecorder stop];
    self.timer.fireDate = [NSDate distantFuture];
    self.audioPower.progress = 0.0;
}
#pragma mark -录音代理方法
- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
    NSLog(@"录音完成");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
