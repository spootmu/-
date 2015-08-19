//
//  UIImage+Extension.m
//  新浪微博
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+(instancetype)resizableImageWithName:(NSString *)imageName
{
    UIImage *img=[self imageNamed:imageName];
    CGFloat left=img.size.width*0.5;
    CGFloat top=img.size.height*0.5;
    
    img=[img stretchableImageWithLeftCapWidth:left topCapHeight:top];
    return img;
}
@end
