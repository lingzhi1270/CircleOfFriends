//
//  MessageAvatarFactory.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 头像大小以及头像与其他控件的距离
static CGFloat const AvatarImageSize = 40.0f;
static CGFloat const AlbumAvatarSpacing = 15.0f;

typedef NS_ENUM(NSInteger, XHMessageAvatarType) {
    MessageAvatarTypeNormal = 0,
    MessageAvatarTypeSquare,
    MessageAvatarTypeCircle
};

@interface XHMessageAvatarFactory : NSObject

+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatarType:(XHMessageAvatarType)type;

@end
