//
//  CBWDigitalPayView.m
//  DigitalPayCodeDemo
//
//  Created by 陈博文 on 16/11/1.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWDigitalPayView.h"

#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height 45  //每一个输入框的高度
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define lineColor [UIColor grayColor]
#define dotColor [UIColor blackColor]
#define textFieldBorderColor [UIColor blackColor]

@interface CBWDigitalPayView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点

@end

@implementation CBWDigitalPayView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    //    self.backgroundColor = [UIColor greenColor];
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self addSubview:self.textField];
    //页面出现时让键盘弹出
    [self.textField becomeFirstResponder];
    
    [self initPwdTextField];
    
    self.textField.frame = self.bounds;
}

- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat w = self.frame.size.width / kDotCount;
    CGFloat h = self.frame.size.height;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * w, 0, 1, h)];
        lineView.backgroundColor = lineColor;
        [self addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(0 + (w - kDotCount) / 2 + i * w, 0 + (h - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = dotColor;
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

#pragma mark - delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([self.delegate respondsToSelector:@selector(passWordBeginInput:)]) {
        
        [self.delegate passWordBeginInput:self];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    
    _textStore = textField.text.mutableCopy;
    
    
    if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
        
        [self.delegate passWordDidChange:self];
    }
    
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
        
        if ([self.delegate respondsToSelector:@selector(passWordCompleteInput:)]) {
            [self.delegate passWordCompleteInput:self];
        }
    }
}

#pragma mark - init

- (UITextField *)textField
{
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor clearColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = lineColor.CGColor;
        _textField.layer.borderWidth = 1;
        _textField.layer.masksToBounds = YES;
        
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end
