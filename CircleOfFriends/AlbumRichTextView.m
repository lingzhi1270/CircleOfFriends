//
//  AlbumRichTextView.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/2.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "AlbumRichTextView.h"
#import "MessageAvatarFactory.h"
#import "AlbumLikesCommentsView.h"
#import "AlbumPhotoCollectionViewCell.h"
#import "XHImageViewer.h"
#import "AlbumCollectionViewFlowLayout.h"
#import "Album.h"



#define PhotoCollectionViewCellIdentifier @"PhotoCollectionViewCellIdentifier"
@interface AlbumCollectionView : UICollectionView

@end

@implementation AlbumCollectionView

//此底层实现说明了, 一个view的子控件是如何判断是否接收点击事件的.

//此方法返回的View是本次点击事件需要的最佳View
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSIndexPath *touchIndexPath = [self indexPathForItemAtPoint:point];
    if (!touchIndexPath) {
        return nil;
    }
    return [super hitTest:point withEvent:event];
}

@end



@interface AlbumRichTextView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) AlbumCollectionView *sharePhotoCollectionView;

@property (nonatomic, strong) UILabel *timestampLabel;
@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) AlbumLikesCommentsView *albumLikesCommentsView;

@end



@implementation AlbumRichTextView

+ (CGFloat)getRichTextHeightWithText:(NSString *)text {
    if (!text || !text.length)
        return 0;
    return [SETextView frameRectWithAttributtedString:[[NSAttributedString alloc] initWithString:text] constraintSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - AvatarImageSize - (AlbumAvatarSpacing * 3), CGFLOAT_MAX) lineSpacing:AlbumContentLineSpacing font:AlbumContentFont].size.height;
}

+ (CGFloat)getSharePhotoCollectionViewHeightWithPhotos:(NSArray *)photos {
    // 上下间隔已经在frame上做了
    NSInteger row = (photos.count / 3 + (photos.count % 3 ? 1 : 0));
    return (row * (AlbumPhotoSize) + ((row - 1) * AlbumPhotoInsets));
}

+ (CGFloat)calculateRichTextHeightWithAlbum:(Album *)currentAlbum {
    CGFloat richTextHeight = AlbumAvatarSpacing * 2;
    
    richTextHeight += AlbumUserNameHeigth;
    
    richTextHeight += AlbumContentLineSpacing;
    richTextHeight += [self getRichTextHeightWithText:currentAlbum.albumShareContent];
    
    richTextHeight += AlbumPhotoInsets;
    richTextHeight += [self getSharePhotoCollectionViewHeightWithPhotos:currentAlbum.albumSharePhotos];
    
    richTextHeight += AlbumContentLineSpacing;
    richTextHeight += AlbumCommentButtonHeight;
    
    richTextHeight += 4;
    richTextHeight += 14;
    richTextHeight += currentAlbum.albumShareComments.count * 16;
    
    return richTextHeight;
}

#pragma mark - Actions

- (void)commentButtonDidClicked:(UIButton *)sender {
    if (self.commentButtonDidSelectedCompletion) {
        self.commentButtonDidSelectedCompletion(sender);
    }
}

#pragma mark - Propertys

- (void)setDisplayAlbum:(Album *)displayAlbum {
    if (!displayAlbum)
        return;
    _displayAlbum = displayAlbum;
    
    self.userNameLabel.text = displayAlbum.userName;
    
    self.richTextView.attributedText = [[NSAttributedString alloc] initWithString:displayAlbum.albumShareContent];
    
    self.timestampLabel.text = @"3小时前";
    
    [self.sharePhotoCollectionView reloadData];
    
    self.albumLikesCommentsView.likes = displayAlbum.albumShareLikes;
    self.albumLikesCommentsView.comments = displayAlbum.albumShareComments;
    [self.albumLikesCommentsView reloadData];
    
    [self setNeedsLayout];
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AlbumAvatarSpacing, AlbumAvatarSpacing, AvatarImageSize, AvatarImageSize)];
        _avatarImageView.image = [UIImage imageNamed:@"zgr"];
    }
    return _avatarImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        CGFloat userNameLabelX = CGRectGetMaxX(self.avatarImageView.frame) + AlbumAvatarSpacing;
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabelX, CGRectGetMinY(self.avatarImageView.frame), CGRectGetWidth([[UIScreen mainScreen] bounds]) - userNameLabelX - AlbumAvatarSpacing, AlbumUserNameHeigth)];
        _userNameLabel.backgroundColor = [UIColor clearColor];
        _userNameLabel.textColor = [UIColor colorWithRed:0.294 green:0.595 blue:1.000 alpha:1.000];
        
    }
    return _userNameLabel;
}

- (SETextView *)richTextView {
    if (!_richTextView) {
        _richTextView = [[SETextView alloc] initWithFrame:self.bounds];
        _richTextView.backgroundColor = [UIColor clearColor];
        _richTextView.font = self.font;
        _richTextView.textColor = self.textColor;
        _richTextView.textAlignment = self.textAlignment;
        _richTextView.lineSpacing = self.lineSpacing;
    }
    return _richTextView;
}

- (AlbumCollectionView *)sharePhotoCollectionView {
    if (!_sharePhotoCollectionView) {
        _sharePhotoCollectionView = [[AlbumCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[AlbumCollectionViewFlowLayout alloc] init]];
        _sharePhotoCollectionView.backgroundColor = self.richTextView.backgroundColor;
        [_sharePhotoCollectionView registerClass:[AlbumPhotoCollectionViewCell class] forCellWithReuseIdentifier:PhotoCollectionViewCellIdentifier];
        [_sharePhotoCollectionView setScrollsToTop:NO];
        _sharePhotoCollectionView.delegate = self;
        _sharePhotoCollectionView.dataSource = self;
    }
    return _sharePhotoCollectionView;
}

- (UILabel *)timestampLabel {
    if (!_timestampLabel) {
        _timestampLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timestampLabel.backgroundColor = [UIColor clearColor];
        _timestampLabel.font = [UIFont systemFontOfSize:11];
        _timestampLabel.textColor = [UIColor grayColor];
    }
    return _timestampLabel;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_commentButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_commentButton setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        [_commentButton addTarget:self action:@selector(commentButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

- (AlbumLikesCommentsView *)albumLikesCommentsView {
    if (!_albumLikesCommentsView) {
        _albumLikesCommentsView = [[AlbumLikesCommentsView alloc] initWithFrame:CGRectZero];
    }
    return _albumLikesCommentsView;
}
#pragma mark - Life Cycle

- (void)setup {
    self.font = AlbumContentFont;
    self.textColor = [UIColor blackColor];
    self.textAlignment = NSTextAlignmentLeft;
    self.lineSpacing = AlbumContentLineSpacing;
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.userNameLabel];
    
    [self addSubview:self.richTextView];
    [self addSubview:self.sharePhotoCollectionView];
    
    [self addSubview:self.timestampLabel];
    [self addSubview:self.commentButton];
    
    [self addSubview:self.albumLikesCommentsView];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.font = nil;
    self.textColor = nil;
    self.richTextView = nil;
    _displayAlbum = nil;
    
    self.avatarImageView = nil;
    self.userNameLabel = nil;
    self.sharePhotoCollectionView.delegate = nil;
    self.sharePhotoCollectionView.dataSource = nil;
    self.sharePhotoCollectionView = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat richTextViewX = CGRectGetMinX(self.userNameLabel.frame);
    CGRect richTextViewFrame = CGRectMake(richTextViewX, CGRectGetMaxY(self.userNameLabel.frame) + AlbumContentLineSpacing, CGRectGetWidth([[UIScreen mainScreen] bounds]) - richTextViewX - AlbumAvatarSpacing, [AlbumRichTextView getRichTextHeightWithText:self.displayAlbum.albumShareContent]);
    self.richTextView.frame = richTextViewFrame;
    
    CGRect sharePhotoCollectionViewFrame = CGRectMake(richTextViewX, CGRectGetMaxY(richTextViewFrame) + AlbumPhotoInsets, AlbumPhotoInsets * 4 + AlbumPhotoSize * 3, [AlbumRichTextView getSharePhotoCollectionViewHeightWithPhotos:self.displayAlbum.albumSharePhotos]);
    self.sharePhotoCollectionView.frame = sharePhotoCollectionViewFrame;
    
    CGRect commentButtonFrame = self.commentButton.frame;
    commentButtonFrame.origin = CGPointMake(CGRectGetMaxX(richTextViewFrame) - AlbumCommentButtonWidth, CGRectGetMaxY(sharePhotoCollectionViewFrame) + AlbumContentLineSpacing);
    commentButtonFrame.size = CGSizeMake(AlbumCommentButtonWidth, AlbumCommentButtonHeight);
    self.commentButton.frame = commentButtonFrame;
    
    CGRect timestampLabelFrame = self.timestampLabel.frame;
    timestampLabelFrame.origin = CGPointMake(CGRectGetMinX(richTextViewFrame), CGRectGetMinY(commentButtonFrame));
    timestampLabelFrame.size = CGSizeMake(CGRectGetWidth(self.bounds) - AlbumAvatarSpacing * 3 - AvatarImageSize - AlbumCommentButtonWidth, CGRectGetHeight(commentButtonFrame));
    self.timestampLabel.frame = timestampLabelFrame;
    
    // 这里出现延迟布局的情况，所以就不能正常排版
    CGRect likesCommentsViewFrame = self.albumLikesCommentsView.frame;
    likesCommentsViewFrame.origin = CGPointMake(CGRectGetMinX(richTextViewFrame), CGRectGetMaxY(timestampLabelFrame));
    likesCommentsViewFrame.size.width = CGRectGetWidth(richTextViewFrame);
    self.albumLikesCommentsView.frame = likesCommentsViewFrame;
    
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(likesCommentsViewFrame) + AlbumAvatarSpacing;
    self.frame = frame;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.displayAlbum.albumSharePhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self showImageViewerAtIndexPath:indexPath];
}

- (void)showImageViewerAtIndexPath:(NSIndexPath *)indexPath {
    AlbumPhotoCollectionViewCell *cell = (AlbumPhotoCollectionViewCell *)[self.sharePhotoCollectionView cellForItemAtIndexPath:indexPath];
    
    NSMutableArray *imageViews = [NSMutableArray array];
    
    NSArray *visibleCell = [self.sharePhotoCollectionView visibleCells];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"indexPath" ascending:YES];
    
    visibleCell = [visibleCell sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    [visibleCell enumerateObjectsUsingBlock:^(AlbumPhotoCollectionViewCell *cell, NSUInteger idx, BOOL *stop) {
        [imageViews addObject:cell.photoImageView];
    }];
    
    XHImageViewer *imageViewer = [[XHImageViewer alloc] init];
    [imageViewer showWithImageViews:imageViews selectedView:cell.photoImageView];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
