//
//  AlbumOperationView.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/2.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AlbumOperationType){
    
    AlbumOperationTypeReply = 0,
    AlbumOperationTypeLike = 1,
    
};

typedef void(^DidSelectedOperationBlock)(AlbumOperationType operationType);

@interface AlbumOperationView : UIView

@property (nonatomic,assign)BOOL shouldShowed;

@property (nonatomic,copy)DidSelectedOperationBlock didSelectedOperationCompleted;

+ (instancetype)initailzerAlbumOperationView;

- (void)showAtView:(UIView *)containerView rect:(CGRect)targetRect;

- (void)dismiss;



@end
