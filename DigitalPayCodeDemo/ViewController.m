//
//  ViewController.m
//  DigitalPayCodeDemo
//
//  Created by 陈博文 on 16/11/1.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"
#import "CBWDigitalPayView.h"

@interface ViewController ()<CBWDigitalPayViewDelegate>
@property (weak, nonatomic) IBOutlet CBWDigitalPayView *digitalPayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.digitalPayView.delegate = self;
    
    
}


#pragma mark - delegate

/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(CBWDigitalPayView *)passWord{
    
    NSLog(@"%s==%@",__func__,passWord.textStore);
    
}

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(CBWDigitalPayView *)passWord{
    
    NSLog(@"%s==%@",__func__,passWord.textStore);
    
}

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(CBWDigitalPayView *)passWord{
    
    NSLog(@"%s==%@",__func__,passWord.textStore);
}



@end
