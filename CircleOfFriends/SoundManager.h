//
//  SoundManager.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/1.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundManager : NSObject

+ (instancetype)sharedInstance;

- (void)playRefreshSound;

@end
