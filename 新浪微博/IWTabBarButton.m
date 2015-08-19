//
//  IWTabBarButton.m
//  新浪微博
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "IWTabBarButton.h"
#define btnPer 0.6
@implementation IWTabBarButton

-(void)setItem:(UITabBarItem *)item
{
    _item=item;
    [self setTitle:item.title forState:UIControlStateNormal];
    // 设置默认状态的图片
    [self setImage:item.image forState:UIControlStateNormal];
    // 设置选中状态的图片
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*btnPer);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0,contentRect.size.height*btnPer, contentRect.size.width, contentRect.size.height-(contentRect.size.height*btnPer));
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.imageView.contentMode=UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted
{
    
}
@end
