//
//  WeiBoFrame.m
//  新浪微博
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoFrame.h"
#define magin 10

@implementation WeiBoFrame

-(void)setData:(WeiBoData *)data
{
    NSDictionary *attributes = @{NSFontAttributeName:nameFont};
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    
    
    _data=data;
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
    CGFloat vipW=14;
    CGFloat vipH=14;
    _vipViewF=CGRectMake(vipX, vipY, vipW, vipH);
    
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
    
    
    CGFloat topX=0;
    CGFloat topY=0;
    CGFloat topW=screenW;
    CGFloat topH=CGRectGetMaxY(_contextViewF)+magin;
    _topViewF=CGRectMake(topX, topY, topW, topH);
    
    CGFloat toolbarX=0;
    CGFloat toolbarY=CGRectGetMaxY(_contextViewF)+magin;
    CGFloat toolbarW=screenW;
    CGFloat toolbarH=35;
    _toolbarViewF=CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    _cellHeght=CGRectGetMaxY(_toolbarViewF);
}
@end
