//
//  HomeBarBtn.m
//  新浪微博
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "HomeBarBtn.h"

@implementation HomeBarBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithImage:(UIImage*)norImg highlightedImage:(UIImage *)highlightedImage
{
    self=[super init];
    if(self)
    {
        [self setBackgroundImage:norImg forState:UIControlStateNormal];
        [self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        self.size=self.currentImage.size;
    }
    return self;
}


@end
