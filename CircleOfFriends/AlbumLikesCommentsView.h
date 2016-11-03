//
//  AlbumLikesCommentsView.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumLikesCommentsView : UIView

@property (nonatomic, strong) NSArray *likes;
@property (nonatomic, strong) NSArray *comments;

- (void)reloadData;

@end
