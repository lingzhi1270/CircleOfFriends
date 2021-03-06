//
//  AlbumLikesCommentsView.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "AlbumLikesCommentsView.h"
#import "NSString+Extension.h"

#define AlbumLikeLabelBaseTag 100

@interface AlbumCommentTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) id item;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)setupItem:(id)item atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation AlbumCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.commentLabel];
   
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect userNameLabelFrame = self.userNameLabel.frame;
    
    CGRect commentLabelFrame = self.commentLabel.frame;
    commentLabelFrame.origin.x = CGRectGetMaxX(userNameLabelFrame);
    commentLabelFrame.size = CGSizeMake(100, 16);
    self.commentLabel.frame = commentLabelFrame;
}

- (void)setupItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    self.item = item;
    self.indexPath = indexPath;
    
    self.userNameLabel.text = @"Leslie";
    self.commentLabel.text = [NSString stringWithFormat:@": %@", item];

}

#pragma  mark- getter

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 30, 16)];
        _userNameLabel.textColor = [UIColor blueColor];
        _userNameLabel.font = [UIFont systemFontOfSize:10];
    }
    return _userNameLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.textColor = [UIColor blackColor];
        _commentLabel.font = [UIFont systemFontOfSize:10];
    }
    return _commentLabel;
}

@end



@interface AlbumLikesCommentsView ()<UITableViewDelegate,UITableViewDataSource>
{

        NSInteger likeLabelWith_X;
}

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIView *likeContainerView;
@property (nonatomic, strong) UIImageView *likeIconImageView;

@property (nonatomic, strong) UITableView *commmentTableView;

@end

@implementation AlbumLikesCommentsView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.likeContainerView];
        [self addSubview:self.commmentTableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)updateUserInterface {
    BOOL shouldShowLike = self.likes.count > 0;
    BOOL shouldShowComment = self.comments.count > 0;
    
    self.likeContainerView.hidden = !shouldShowLike;
    self.commmentTableView.hidden = !shouldShowComment;
    
    if (!shouldShowLike && !shouldShowComment) {
        self.frame = CGRectZero;
        return;
    }
    
    CGRect likeContainerViewFrame = CGRectZero;
    
    if (shouldShowLike) {
        likeContainerViewFrame = CGRectMake(0, 4, CGRectGetWidth(self.bounds), 14);
        self.likeContainerView.frame = likeContainerViewFrame;
    }
    
    CGRect commentTableViewFrame = CGRectZero;
    if (shouldShowComment) {
        commentTableViewFrame = self.commmentTableView.frame;
        commentTableViewFrame.origin.y = CGRectGetMaxY(likeContainerViewFrame) + (shouldShowLike ? 0 : 4);
        commentTableViewFrame.size.height = self.comments.count * 16;
        self.commmentTableView.frame = commentTableViewFrame;
    }
    
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY((shouldShowComment ? commentTableViewFrame : likeContainerViewFrame));
    self.frame = frame;
}

#pragma mark - Propertys

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundImageView.image = [[UIImage imageNamed:@"Album_likes_comments_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 24, 8, 8) resizingMode:UIImageResizingModeStretch];
    }
    return _backgroundImageView;
}

- (UIView *)likeContainerView {
    if (!_likeContainerView) {
        _likeContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        [_likeContainerView addSubview:self.likeIconImageView];
    }
    return _likeContainerView;
}
- (UIImageView *)likeIconImageView {
    if (!_likeIconImageView) {
        _likeIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Album_like_icon"]];
        CGRect likeIconImageViewFrame = _likeIconImageView.frame;
        likeIconImageViewFrame.origin = CGPointMake(5, 0);
        _likeIconImageView.frame = likeIconImageViewFrame;
    }
    return _likeIconImageView;
}

- (UITableView *)commmentTableView {
    if (!_commmentTableView) {
        _commmentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _commmentTableView.separatorColor = [UIColor clearColor];
        _commmentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_commmentTableView registerClass:[AlbumCommentTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
        _commmentTableView.dataSource = self;
        _commmentTableView.scrollEnabled = NO;
        _commmentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _commmentTableView.backgroundColor = [UIColor clearColor];
        _commmentTableView.rowHeight = 16;
    }
    return _commmentTableView;
}

#pragma mark - 公开方法

- (void)reloadLikes {
    for (UIView *view in self.likeContainerView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            view.hidden = YES;
        }
    }
    CGRect likeLabelFrame = CGRectZero;
    for (int i = 0; i < self.likes.count; i ++) {
        //TODO:赞的人显示Label
        
        
        CGFloat likeLabelH = CGRectGetHeight(self.likeIconImageView.bounds);
        
        
        
        NSString *likeLabelText = [NSString stringWithFormat:@"%@%@", self.likes[i], (i == self.likes.count - 1) ? @"" : @","];;
        //自适应宽度
        NSInteger likeLabelW = [likeLabelText sizeWithFont:[UIFont systemFontOfSize:10] maxH:likeLabelH].width;
        
    
        
        likeLabelFrame = CGRectMake(CGRectGetMaxX(self.likeIconImageView.frame) + likeLabelWith_X, CGRectGetMinY(self.likeIconImageView.frame), likeLabelW+5, CGRectGetHeight(self.likeIconImageView.bounds));
        likeLabelWith_X += likeLabelW;
        
        UILabel *likeLabel = (UILabel *)[self.likeContainerView viewWithTag:AlbumLikeLabelBaseTag + i];
        if (!likeLabel) {
            likeLabel = [[UILabel alloc] initWithFrame:likeLabelFrame];
        }
        likeLabel.hidden = NO;
        likeLabel.font = [UIFont systemFontOfSize:10];
        likeLabel.textColor = [UIColor blueColor];
        likeLabel.text = likeLabelText;
        [self.likeContainerView addSubview:likeLabel];
    }
}

- (void)reloadData {
    [self.commmentTableView reloadData];
    [self reloadLikes];
    [self updateUserInterface];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    [cell setupItem:self.comments[indexPath.row] atIndexPath:indexPath];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
