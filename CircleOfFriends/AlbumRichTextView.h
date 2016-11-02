//
//  AlbumRichTextView.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/2.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Album.h"
typedef void(^CommentButtonDidSelectedBlock)(UIButton *sender);

@interface AlbumRichTextView : UIView
@property (nonatomic, strong) NSFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) CGFloat lineSpacing;

//@property (nonatomic, strong) SETextView *richTextView;

@property (nonatomic, strong) Album *displayAlbum;

@property (nonatomic, copy) CommentButtonDidSelectedBlock commentButtonDidSelectedCompletion;

+ (CGFloat)calculateRichTextHeightWithAlbum:(Album *)currentAlbum;
@end
