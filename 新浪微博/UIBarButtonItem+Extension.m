//
//  UIBarButtonItem+Extension.m
//  新浪微博
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(instancetype)barButtonItemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target sel:(SEL)sel
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    btn.size=btn.currentImage.size;
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}
@end
