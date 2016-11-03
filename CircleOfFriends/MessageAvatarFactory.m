//
//  MessageAvatarFactory.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "MessageAvatarFactory.h"
#import "UIImage+Rounded.h"

@implementation XHMessageAvatarFactory

+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatarType:(XHMessageAvatarType)messageAvatarType {
    CGFloat radius = 0.0;
    switch (messageAvatarType) {
        case MessageAvatarTypeNormal
            :
            return originImage;
            break;
        case MessageAvatarTypeCircle:
            radius = originImage.size.width / 2.0;
            break;
        case MessageAvatarTypeSquare:
            radius = 8;
            break;
        default:
            break;
    }
    UIImage *avatar = [originImage createRoundedWithRadius:radius];
    return avatar;
}

@end
