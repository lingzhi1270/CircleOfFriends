//
//  SoundManager.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/1.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "SoundManager.h"

#import <AudioToolbox/AudioToolbox.h>

@interface SoundManager () {
    SystemSoundID refreshSound;
}

@end

@implementation SoundManager

+ (instancetype)sharedInstance {
    static SoundManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SoundManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"pullrefresh" withExtension:@"aif"];
        
        //下拉时水滴声
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url) , &refreshSound);
    }
    return self;
}

- (void)playRefreshSound {
    AudioServicesPlaySystemSound(refreshSound);
}

@end
