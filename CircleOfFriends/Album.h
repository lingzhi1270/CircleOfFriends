//
//  Album.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/2.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
// 朋友圈分享人的名称高度
#define AlbumUserNameHeigth 18

// 朋友圈分享的图片以及图片之间的间隔
#define AlbumPhotoSize 60
#define AlbumPhotoInsets 5

// 朋友圈分享内容字体和间隔
#define AlbumContentFont [UIFont systemFontOfSize:13]
#define AlbumContentLineSpacing 4

// 朋友圈评论按钮大小
#define AlbumCommentButtonWidth 25
#define AlbumCommentButtonHeight 25

@interface Album : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy) NSString *profileAvatarUrlString;

@property (nonatomic, copy) NSString *albumShareContent;

@property (nonatomic, strong) NSArray *albumSharePhotos;

@property (nonatomic, strong) NSArray *albumShareComments;

@property (nonatomic, strong) NSArray *albumShareLikes;

@property (nonatomic, strong) NSDate *timestamp;

@end
