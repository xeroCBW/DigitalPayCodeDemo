//
//  CBWDigitalPayView.h
//  DigitalPayCodeDemo
//
//  Created by 陈博文 on 16/11/1.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBWDigitalPayView;

@protocol CBWDigitalPayViewDelegate <NSObject>

@optional
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(CBWDigitalPayView *)passWord;

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(CBWDigitalPayView *)passWord;

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(CBWDigitalPayView *)passWord;


@end

@interface CBWDigitalPayView : UIView

@property (weak, nonatomic) IBOutlet id<CBWDigitalPayViewDelegate> delegate;
@property (strong, nonatomic, readonly) NSMutableString *textStore;//保存密码的字符串

@end
