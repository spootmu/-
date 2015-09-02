//
//  WeiBoFrame.m
//  新浪微博
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoFrame.h"
#define magin 10
#define screenW [UIScreen mainScreen].bounds.size.width

@implementation WeiBoFrame

-(void)setData:(WeiBoData *)data
{
    _data=data;

    [self setupTopView];
    [self setupBottomView];
    
    _cellHeght=CGRectGetMaxY(_toolbarViewF);
}

/**
 *  微博视图
 */
-(void)setupTopView
{
    [self setupOriginal];
    
    [self setupRepost];
    
    CGFloat topH=0;
    if(_data.retweeted_status)
    {
        topH=CGRectGetMaxY(_reViewF);
    }
    else
    {
        topH=CGRectGetMaxY(_originalViewF);
    }
    
    CGFloat topX=0;
    CGFloat topY=5;
    CGFloat topW=screenW;
    _topViewF=CGRectMake(topX, topY, topW, topH);
}

/**
 *  底部工具条
 */
-(void)setupBottomView
{
    CGFloat toolbarX=0;
    CGFloat toolbarY=CGRectGetMaxY(_topViewF);
    CGFloat toolbarW=screenW;
    CGFloat toolbarH=35;
    _toolbarViewF=CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

/**
 *  转发微博
 */
-(void)setupRepost
{
    NSDictionary *attributes = @{NSFontAttributeName:nameFont};
    NSDictionary *contextAttributes=@{NSFontAttributeName:contextFont};
    _data.retweeted_status.user.name=[NSString stringWithFormat:@"@%@",_data.retweeted_status.user.name];
    CGFloat renameX=magin;
    CGFloat renameY=magin;
    CGSize renameMaxSize=CGSizeMake(screenW-magin*2, MAXFLOAT);
    CGSize renameSize=[_data.retweeted_status.user.name boundingRectWithSize:renameMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    _reNameF=(CGRect){{renameX,renameY},renameSize};
    
    CGFloat reContextX=magin;
    CGFloat reContextY=CGRectGetMaxY(_reNameF)+magin;;
    CGSize  reContextMaxSize=CGSizeMake(screenW-magin*2, MAXFLOAT);
    CGSize reContextSize=[_data.retweeted_status.text boundingRectWithSize:reContextMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contextAttributes context:nil].size;
    _reContextF=(CGRect){{reContextX,reContextY},reContextSize};
    
    CGFloat reViewH=0;
    NSArray *photosArr=_data.retweeted_status.pic_urls;
    NSInteger photoCount=photosArr.count;
    if(photoCount>0)
    {
        CGSize rePhotoSize=[self setupPhotos:photoCount];
        CGFloat rePhotoViewX=magin;
        CGFloat rePhotoViewY=CGRectGetMaxY(_reContextF)+magin;
        
        _rePhotosViewF=(CGRect){{rePhotoViewX,rePhotoViewY},rePhotoSize};
        reViewH=CGRectGetMaxY(_rePhotosViewF)+magin;
    }
    else
    {
        reViewH=CGRectGetMaxY(_reContextF)+magin;
    }
    
    CGFloat reViewX=0;
    CGFloat reViewY=CGRectGetMaxY(_contextViewF)+magin;
    CGFloat reViewW=screenW;
    _reViewF=CGRectMake(reViewX, reViewY, reViewW, reViewH);
}

/**
 *  计算配图大小
 *
 *  @param count 图片数量
 *
 *  @return view大小
 */
-(CGSize)setupPhotos:(NSInteger)count
{
    NSInteger photoCount=count;
    NSInteger maxCol=photoCount==4?2:3;
    NSInteger photoColNum=photoCount>maxCol?maxCol:photoCount;
    NSInteger photoRowNum=photoCount/maxCol;
    if(photoCount%maxCol !=0)
    {
        photoRowNum++;
    }
    
    CGFloat PhotoViewW=photoColNum*photoW+(photoColNum-1)*photoPadding;
    CGFloat PhotoViewH=photoRowNum*photoH+(photoRowNum-1)*photoPadding;
    return CGSizeMake(PhotoViewW, PhotoViewH);
}
/**
 *  原创微博
 */
-(void)setupOriginal
{
    NSDictionary *attributes = @{NSFontAttributeName:nameFont};
    CGFloat iconX=magin;
    CGFloat iconY=magin;
    CGFloat iconW=35;
    CGFloat iconH=35;
    _iconViewF=CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX=CGRectGetMaxX(_iconViewF)+magin;
    CGFloat nameY=magin;
    CGSize nameSize=[_data.user.name sizeWithAttributes:attributes];
    _nameLableF=(CGRect){{nameX,nameY},nameSize};
    
    CGFloat vipX=CGRectGetMaxX(_nameLableF)+magin;
    CGFloat vipY=magin;
    CGFloat vipW=17;
    CGFloat vipH=17;
    _vipViewF=CGRectMake(vipX, vipY, vipW, vipH);
    
    CGFloat rankX=CGRectGetMaxX(_vipViewF)+magin;
    CGFloat rankY=magin;
    CGFloat rankW=14;
    CGFloat rankH=14;
    _rankViewF=CGRectMake(rankX, rankY, rankW, rankH);
    
    NSDictionary *timeAttributes=@{NSFontAttributeName:timeFont};
    CGFloat timeX=CGRectGetMaxX(_iconViewF)+magin;
    CGFloat timeY=CGRectGetMaxY(_nameLableF)+magin-2;
    CGSize timeSize=[_data.created_at sizeWithAttributes:timeAttributes];
    _timeLabelF=(CGRect){{timeX,timeY},timeSize};
    
    NSDictionary *sourceAttributes=@{NSFontAttributeName:sourceFont};
    CGFloat sourceX=CGRectGetMaxX(_timeLabelF)+magin;
    CGFloat sourceY=timeY;
    CGSize sourceSize=[_data.source sizeWithAttributes:sourceAttributes];
    _sourceViewF=(CGRect){{sourceX,sourceY},sourceSize};
    
    NSDictionary *contextAttributes=@{NSFontAttributeName:contextFont};
    CGFloat contextX=magin;
    CGFloat contextY=CGRectGetMaxY(_iconViewF)+magin;
    CGSize  contextMaxSize=CGSizeMake(screenW-magin*2, MAXFLOAT);
    CGSize contextSize=[_data.text boundingRectWithSize:contextMaxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:contextAttributes context:nil].size;
    _contextViewF=(CGRect){{contextX,contextY},contextSize};
    
    CGFloat originalViewH=0;
    
    NSArray *photosArr=_data.pic_urls;
    NSInteger photoCount=photosArr.count;
    if(photoCount>0)
    {
        CGSize originalPhotoSize=[self setupPhotos:photoCount];
        CGFloat originalPhotoViewX=magin;
        CGFloat originalPhotoViewY=CGRectGetMaxY(_contextViewF)+magin;
        
        _originalPhotosViewF=(CGRect){{originalPhotoViewX,originalPhotoViewY},originalPhotoSize};
         originalViewH=CGRectGetMaxY(_originalPhotosViewF)+magin;
    }
    else
    {
         originalViewH=CGRectGetMaxY(_contextViewF)+magin;
    }
    
    CGFloat originalViewX=0;
    CGFloat originalViewY=0;
    CGFloat originalViewW=screenW;
    
    _originalViewF=CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
}
@end
