//
//  AlbumCollectionViewFlowLayout.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "AlbumCollectionViewFlowLayout.h"
#import "Album.h"


@implementation AlbumCollectionViewFlowLayout
- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(AlbumPhotoSize, AlbumPhotoSize);
        self.minimumInteritemSpacing = AlbumPhotoInsets;
        self.minimumLineSpacing = AlbumPhotoInsets;
    }
    return self;
}


@end
