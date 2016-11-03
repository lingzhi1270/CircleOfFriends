//
//  StoreManager.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreManager : NSObject
+ (instancetype)shareStoreManager;

- (NSMutableArray *)getAlbumConfigureArray;
@end
