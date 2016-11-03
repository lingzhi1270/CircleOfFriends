//
//  AlbumPhotoCollectionViewCell.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface AlbumPhotoCollectionViewCell : BaseCollectionViewCell
@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end
