//
//  CircleTableViewCell.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/2.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "CircleTableViewCell.h"

#import "AlbumRichTextView.h"
// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


@interface CircleTableViewCell ()

@property (nonatomic, strong) AlbumRichTextView *albumRichTextView;

@end

@implementation CircleTableViewCell

+ (CGFloat)calculateCellHeightWithAlbum:(Album *)currentAlbum {
    return [AlbumRichTextView calculateRichTextHeightWithAlbum:currentAlbum];
}

#pragma mark - Propertys

- (void)setCurrentAlbum:(Album *)currentAlbum {
    if (!currentAlbum)
        return;
    _currentAlbum = currentAlbum;
    
    self.albumRichTextView.displayAlbum = currentAlbum;
}

- (AlbumRichTextView *)albumRichTextView {
    if (!_albumRichTextView) {
        _albumRichTextView = [[AlbumRichTextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 40)];
        WEAKSELF
        _albumRichTextView.commentButtonDidSelectedCompletion = ^(UIButton *sender){
            STRONGSELF
            if ([strongSelf.circleCellDelegate respondsToSelector:@selector(didShowOperationView:indexPath:)]) {
                [strongSelf.circleCellDelegate didShowOperationView:sender indexPath:strongSelf.indexPath];
            }
        };
    }
    return _albumRichTextView;
}

#pragma mark - Life Cycle

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.albumRichTextView];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    _currentAlbum = nil;
    self.albumRichTextView = nil;
}

@end
