//
//  StoreManager.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "StoreManager.h"
#import "Album.h"
@implementation StoreManager

+ (instancetype)shareStoreManager
{
    static StoreManager *storeManager;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        storeManager = [[[StoreManager class] alloc] init];
        
    });
    return storeManager;
    
}


- (NSMutableArray *)getAlbumConfigureArray
{
    NSMutableArray *albumConfigureArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 60; i ++) {
        Album *currnetAlbum = [[Album alloc] init];
        currnetAlbum.userName = @"Leslie";
        currnetAlbum.profileAvatarUrlString = @"http://childapp.pailixiu.com/jack/meIcon@2x.png";
        currnetAlbum.albumShareContent = @"朋友圈分享内容，😗😗😗😗😗这里做图片加载，😗😗😗😗😗还是混排好呢？😜😜😜😜😜如果不混排，感觉CoreText派不上场啊！😄😄😄你说是不是？😗😗😗😗😗如果有混排的需要就更好了！😗😗😗😗😗";
        currnetAlbum.albumSharePhotos = [NSArray arrayWithObjects:@"http://childapp.pailixiu.com/jack/JieIcon@2x.png", @"http://childapp.pailixiu.com/jack/JieIcon@2x.png", @"http://childapp.pailixiu.com/jack/JieIcon@2x.png", @"http://childapp.pailixiu.com/jack/JieIcon@2x.png", @"http://childapp.pailixiu.com/jack/JieIcon@2x.png", @"http://childapp.pailixiu.com/jack/JieIcon@2x.png", @"http://childapp.pailixiu.com/jack/JieIcon@2x.png", @"http://childapp.pailixiu.com/jack/JieIcon@2x.png", @"http://childapp.pailixiu.com/jack/JieIcon@2x.png", nil];
        currnetAlbum.timestamp = [NSDate date];
        currnetAlbum.albumShareLikes = @[@"Jackjssjjsfjk", @"华仔"];
        currnetAlbum.albumShareComments = @[@"评论啊！", @"再次评论啊！"];
        [albumConfigureArray addObject:currnetAlbum];
    }
    
    return albumConfigureArray;

}
@end
