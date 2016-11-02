//
//  AlbumOperationView.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/2.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "AlbumOperationView.h"
#define AlbumOperationViewSize CGSizeMake(120, 34)
#define AlbumSpatorY 5


@interface AlbumOperationView()

@property (nonatomic,strong)UIButton *replyButton;
@property (nonatomic,strong)UIButton *likeButton;

@property (nonatomic,assign)CGRect targetRect;

@end

@implementation AlbumOperationView

+ (instancetype)initailzerAlbumOperationView
{
    AlbumOperationView *albumOperationView = [[AlbumOperationView alloc] initWithFrame:CGRectZero];
    return albumOperationView;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.800];
        self.layer.masksToBounds  = YES;
        self.layer.cornerRadius = 5.0;
        [self addSubview:self.replyButton];
        [self addSubview:self.likeButton];

    }
    return self;
}


#pragma mark- getter
- (UIButton *)replyButton
{
    if (_replyButton == nil) {
        _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _replyButton.tag = 0;
        [_replyButton addTarget:self action:@selector(operationDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        _replyButton.frame = CGRectMake(0, 0, AlbumOperationViewSize.width/2.0, AlbumOperationViewSize.height);
        [_replyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _replyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    }
    
    return _replyButton;
}

- (UIButton *)likeButton
{
    if (_likeButton == nil) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.tag = 1;
        [_likeButton addTarget:self action:@selector(operationDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        _likeButton.frame = CGRectMake(CGRectGetMaxX(_replyButton.frame), 0, CGRectGetWidth(_replyButton.bounds), CGRectGetHeight(_replyButton.bounds));
        [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _likeButton.titleLabel.font = [UIFont systemFontOfSize:14];

    }
    
    return _likeButton;
}

#pragma mark - ButtonAction
- (void)operationDidClicked:(UIButton *)sender
{
    [self dismiss];
    if (self.didSelectedOperationCompleted) {
        self.didSelectedOperationCompleted(sender.tag);
    }
    
}

- (void)showAtView:(UIView *)containerView rect:(CGRect)targetRect
{
    self.targetRect = targetRect;
    if (self.shouldShowed) {
        return;
    }
    [containerView addSubview:self];
    CGFloat width = AlbumOperationViewSize.width;
    CGFloat height = AlbumOperationViewSize.height;
    
    //先设置宽度为零  隐藏
    self.frame = CGRectMake(targetRect.origin.x, targetRect.origin.y-AlbumSpatorY, 0, height);
    self.shouldShowed = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.frame = CGRectMake(targetRect.origin.x, targetRect.origin.y-AlbumSpatorY, width, height);
        
    } completion:^(BOOL finished) {
    
        [_replyButton setTitle:@"评论" forState:UIControlStateNormal];
        [_likeButton setTitle:@"赞" forState:UIControlStateNormal];
        
    }];
}


- (void)dismiss
{
    if (!self.shouldShowed) {
        return;
    }
    self.shouldShowed = NO;
    
    [UIView animateWithDuration:0.25f animations:^{
        [_replyButton setTitle:nil forState:UIControlStateNormal];
        [_likeButton setTitle:nil forState:UIControlStateNormal];
        
        CGFloat height = AlbumOperationViewSize.height;
        self.frame = CGRectMake(self.targetRect.origin.x, self.targetRect.origin.y, 0, height);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
