//
//  CircleTableViewCell.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/2.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Album.h"

@protocol CircleTableViewCellDelegate <NSObject>
@optional

- (void)didShowOperationView:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

@end

@interface CircleTableViewCell : UITableViewCell

@property (nonatomic,assign)id<CircleTableViewCellDelegate>circleCellDelegate;
@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,strong)Album *currentAlbum;

+ (CGFloat)calculateCellHeightWithAlbum:(Album *)currentAlbum;

@end
