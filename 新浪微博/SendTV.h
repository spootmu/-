//
//  SendTV.h
//  新浪微博
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendTV : UITextView
/**
 *  设置提示文本
 */
@property (nonatomic,copy) NSString *placeholder;
/**
 *  提示文本颜色
 */
@property(nonatomic,strong) UIColor *placeholdercolor;
@end
