//
//  PhotographyHelper.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/1.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DidFinishTakeMediaCompletedBlock)(UIImage *image, NSDictionary *editingInfo);

@interface PhotographyHelper : NSObject

- (void)showOnpickerViewControllerSourceType:(UIImagePickerControllerSourceType)sourceType onViewController:(UIViewController *)viewController completed:(DidFinishTakeMediaCompletedBlock)completed;

@end
