//
//  SendMessageView.h
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/3.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendMessageView;

@protocol SendMessageViewDelegate <NSObject>

@optional
- (void)didSendMessage:(NSString *)message albumInputView:(SendMessageView *)sendMessageView;

@end

@interface SendMessageView : UIView

@property (nonatomic, weak) id <SendMessageViewDelegate> sendMessageDelegate;

- (void)becomeFirstResponderForTextField;
- (void)resignFirstResponderForInputTextFields;

- (void)finishSendMessage;

@end
