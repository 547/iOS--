//
//  ViewController.m
//  AVAudioPlay
//
//  Created by HW on 16-1-12.
//  Copyright (c) 2016年 SevenDream. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
{
    AVAudioPlayer *avAudio;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //播放音频
    NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"李荣浩 - 李白" ofType:@"mp3"]];
    avAudio=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    //开始播放
    [avAudio play];
    //暂停播放
//    [avAudio pause];
    //停止播放
//    [avAudio stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
