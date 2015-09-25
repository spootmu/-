//
//  SendImgContant.m
//  新浪微博
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "SendImgContant.h"

@interface SendImgContant()

@end

@implementation SendImgContant
-(void)addImage:(UIImage *)img
{
    if(self.subviews.count>=9)return;
    
    UIImageView *imgview=[[UIImageView alloc]init];
    imgview.image=img;
    [self addSubview:imgview];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger maxcol=4;
    NSInteger count=self.subviews.count;
    CGFloat margin=10;
    //（容器宽度－（间隙数量）x间隙）／列数
    CGFloat imgW=(self.w-(maxcol+1)*margin)/maxcol;
    CGFloat imgH=imgW;
 
    for (int i=0; i<count; i++) {
        NSInteger col=i%maxcol;
        NSInteger row=i/maxcol;
        CGFloat imgX=col*(imgW+margin)+margin;
        CGFloat imgY=row*(imgH+margin);
        
        UIImageView *img=self.subviews[i];
        img.frame=CGRectMake(imgX, imgY, imgW, imgH);
    }
}
@end
