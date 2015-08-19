//
//  TitleButton.m
//  新浪微博
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.imageView.contentMode=UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted=YES;
//        

        [self setBackgroundImage:[UIImage resizableImageWithName:@"navigationbar_filter_background_highlighted" ] forState:UIControlStateHighlighted];
    }
    return self;
}

//-(void)setHighlighted:(BOOL)highlighted
//{
//    
//}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    
     NSDictionary *attributes = @{NSFontAttributeName:self.titleLabel.font};
//    CGFloat w= [title boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    
    CGSize titleSize=[title sizeWithAttributes:attributes];
    self.w=titleSize.width+26;
    self.h=35;
//    Log(@"%f,%f",w,self.titleLabel.w);
    [super setTitle:title forState:state];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    Log(@"%f",contentRect.size.width);
    return CGRectMake(0, 0, contentRect.size.width-26, contentRect.size.height);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width-26, 0, 26, contentRect.size.height);
}


@end
