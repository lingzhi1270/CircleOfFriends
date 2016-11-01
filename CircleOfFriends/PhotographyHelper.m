//
//  PhotographyHelper.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/1.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "PhotographyHelper.h"
#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface PhotographyHelper()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,copy)DidFinishTakeMediaCompletedBlock didFinishTakeMediaCompled;

@end

@implementation PhotographyHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }

    return self;
}


- (void)showOnpickerViewControllerSourceType:(UIImagePickerControllerSourceType)sourceType onViewController:(UIViewController *)viewController completed:(DidFinishTakeMediaCompletedBlock)completed
{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        completed(nil, nil);
        return;
    }
    self.didFinishTakeMediaCompled = [completed copy];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.editing = YES;
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.mediaTypes =  [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [viewController presentViewController:imagePickerController animated:YES completion:nil];

}

- (void)dismissPickerViewController:(UIImagePickerController *)picker {
    WEAKSELF
    [picker dismissViewControllerAnimated:YES completion:^{
        weakSelf.didFinishTakeMediaCompled = nil;
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    if (self.didFinishTakeMediaCompled) {
        self.didFinishTakeMediaCompled(image, editingInfo);
    }
    [self dismissPickerViewController:picker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (self.didFinishTakeMediaCompled) {
        self.didFinishTakeMediaCompled(nil, info);
    }
    [self dismissPickerViewController:picker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissPickerViewController:picker];
}


- (void)dealloc
{
    self.didFinishTakeMediaCompled = nil;
}
@end
