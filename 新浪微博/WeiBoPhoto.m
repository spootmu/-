//
//  WeiBoPhoto.m
//  新浪微博
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoPhoto.h"
#import "WeiBoImg.h"

@interface WeiBoPhoto()
@property(nonatomic,weak) UIImageView *gifView;
@end
@implementation WeiBoPhoto
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.userInteractionEnabled=YES;
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds=YES;
        [self SetupGif];

//        UITapGestureRecognizer *tapClick=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClick:)];
//        [self addGestureRecognizer:tapClick];
    }
    return self;
}

//-(void)photoClick:(WeiBoPhoto*)photo
//{
//    MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
//    
//    browser.photos=nil;
//    
//    [browser show];
//}

-(void)SetupGif
{
    UIImageView *imgGif=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
    
    [self addSubview:imgGif];
    self.gifView=imgGif;
}

-(void)layoutSubviews
{
    self.gifView.x=self.w-self.gifView.w;
    self.gifView.y=self.h-self.gifView.h;
}

-(void)setPhoto:(WeiBoImg *)photo
{
    _photo=photo;
    [self sd_setImageWithURL:[NSURL URLWithString:_photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    Log(@"%@",_photo.thumbnail_pic);
    if([[_photo.thumbnail_pic lowercaseString] hasSuffix:@".gif"])
    {
        self.gifView.hidden=NO;
    }
    else
    {
        self.gifView.hidden=YES;
    }
}
@end
