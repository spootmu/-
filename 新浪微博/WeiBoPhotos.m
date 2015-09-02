//
//  WeiBoPhotos.m
//  新浪微博
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoPhotos.h"
#import "WeiBoData.h"
#import "WeiBoImg.h"
#import "WeiBoPhoto.h"
@interface WeiBoPhotos()
@property(strong,nonatomic)NSMutableArray *imgArr;
@end
@implementation WeiBoPhotos

-(NSMutableArray *)imgArr
{
    if(!_imgArr)
    {
        _imgArr=[NSMutableArray array];
    }
    return _imgArr;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {

    }
    return self;
}

-(void)setPhotos:(NSArray *)photos
{
    _photos=photos;
    
    NSInteger count=_photos.count;
    if(count==0)
    {
        self.hidden=YES;
        return;
    }
    else
    {
        self.hidden=NO;
    }
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i=0; i<count; i++) {
        WeiBoPhoto *imgview=[[WeiBoPhoto alloc]init];
        imgview.photo=_photos[i];
        [self addSubview:imgview];
    }
}

-(void)layoutSubviews
{
    NSInteger count=self.photos.count;
    NSInteger maxCol=count==4?2:3;
    NSInteger photoColNum=count>maxCol?maxCol:count;
    
    for (int i=0; i<count; i++) {
        WeiBoPhoto *imgview=self.subviews[i];
        NSInteger col=i%photoColNum;
        NSInteger row=i/photoColNum;
        CGFloat imgX=col*(photoW+photoPadding);
        CGFloat imgY=row*(photoH+photoPadding);
        imgview.frame=(CGRect){{imgX,imgY},{photoW,photoH}};
    }
}
@end
