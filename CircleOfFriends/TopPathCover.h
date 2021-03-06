//
//  TopPathCover.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/1.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

// user info key for Dictionary
extern NSString *const XHUserNameKey;
extern NSString *const XHBirthdayKey;

@interface TopPathCover : UIView

// parallax background
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UIImageView *bannerImageViewWithImageEffects;

// user info
@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *birthdayLabel;


//scrollView call back
@property (nonatomic) BOOL touching;
@property (nonatomic) CGFloat offsetY;

// parallax background origin Y for parallaxHeight
@property (nonatomic, assign) CGFloat parallaxHeight; // default is 170， this height was not self heigth.

@property (nonatomic, assign) BOOL isZoomingEffect; // default is NO， if isZoomingEffect is YES, will be dissmiss parallax effect
@property (nonatomic, assign) BOOL isLightEffect; // default is YES
@property (nonatomic, assign) CGFloat lightEffectPadding; // default is 80
@property (nonatomic, assign) CGFloat lightEffectAlpha; // default is 1.12 (between 1 - 2)

@property (nonatomic, copy) void(^handleRefreshEvent)(void);

@property (nonatomic, copy) void(^handleTapBackgroundImageEvent)(void);

// stop Refresh
- (void)stopRefresh;

// background image
- (void)setBackgroundImage:(UIImage *)backgroundImage;
// custom set url for subClass， There is not work
- (void)setBackgroundImageUrlString:(NSString *)backgroundImageUrlString;

// avatar image
- (void)setAvatarImage:(UIImage *)avatarImage;
// custom set url for subClass， There is not work
- (void)setAvatarUrlString:(NSString *)avatarUrlString;

// set info, Example : NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:@"Jack", @"userName", @"1990-10-19", @"birthday", nil];
- (void)setInfo:(NSDictionary *)info;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
