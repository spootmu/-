//
//  UIBarButtonItem+Extension.h
//  新浪微博
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(instancetype)barButtonItemWithImageName:(NSString*)imageName highlightImageName:(NSString*)highlightImageName target:(id)target sel:(SEL)sel;
@end
