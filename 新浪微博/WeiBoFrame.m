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
    
    
    CGFloat originalViewX=0;
    CGFloat originalViewY=0;
    CGFloat originalViewW=screenW;
    CGFloat originalViewH=CGRectGetMaxY(_contextViewF)+magin;
    _originalViewF=CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
    
    
    
#pragma repost
    CGFloat toolbarY=0;
    CGFloat topH=0;
    if(_data.retweeted_status)
    {
        _data.retweeted_status.user.name=[NSString stringWithFormat:@"@%@",_data.retweeted_status.user.name];
        CGFloat renameX=magin;
        CGFloat renameY=magin;
        CGSize renameMaxSize=contextMaxSize;
        CGSize renameSize=[_data.retweeted_status.user.name boundingRectWithSize:renameMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        _reNameF=(CGRect){{renameX,renameY},renameSize};
        
        CGFloat reContextX=magin;
        CGFloat reContextY=CGRectGetMaxY(_reNameF)+magin;;
        CGSize  reContextMaxSize=contextMaxSize;
        CGSize reContextSize=[_data.retweeted_status.text boundingRectWithSize:reContextMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contextAttributes context:nil].size;
        _reContextF=(CGRect){{reContextX,reContextY},reContextSize};
        
        CGFloat reViewX=0;
        CGFloat reViewY=CGRectGetMaxY(_contextViewF)+magin;
        CGFloat reViewW=screenW;
        CGFloat reViewH=CGRectGetMaxY(_reContextF)+magin;;
        _reViewF=CGRectMake(reViewX, reViewY, reViewW, reViewH);
        
        CGFloat topX=0;
        CGFloat topY=0;
        CGFloat topW=screenW;
        topH=CGRectGetMaxY(_originalViewF)+CGRectGetMaxY(_reViewF);
        _topViewF=CGRectMake(topX, topY, topW, topH);
        toolbarY=CGRectGetMaxY(_reViewF)+magin;
    }
    else {
        CGFloat topX=0;
        CGFloat topY=0;
        CGFloat topW=screenW;
        topH=CGRectGetMaxY(_originalViewF);
        _topViewF=CGRectMake(topX, topY, topW, topH);
        toolbarY=CGRectGetMaxY(_topViewF)+magin;
        
    }
    
    
    
    CGFloat toolbarX=0;
    CGFloat toolbarW=screenW;
    CGFloat toolbarH=35;
    _toolbarViewF=CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    _cellHeght=CGRectGetMaxY(_toolbarViewF);
}
@end
