//
//  WeiBoOriginalView.m
//  新浪微博
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoOriginalView.h"
#import "WeiBoFrame.h"
#import "WeiBoData.h"
#import "user.h"

@interface WeiBoOriginalView()
@property(weak,nonatomic) UIImageView *imgHead;
@property(weak,nonatomic) UIImageView *imgVip;
@property(weak,nonatomic) UIImageView *imgRank;
@property(weak,nonatomic) UILabel *lblName;
@property(weak,nonatomic) UILabel *lblTime;
@property(weak,nonatomic) UILabel *lblSource;
@property(weak,nonatomic) UILabel *lblContext;
@end
@implementation WeiBoOriginalView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        UIImageView *imgHead=[[UIImageView alloc] init];
        [self addSubview:imgHead];
        self.imgHead=imgHead;
        
        UIImageView *imgVip=[[UIImageView alloc]init];
        [self addSubview:imgVip];
        self.imgVip=imgVip;
        
        UIImageView *imgRank=[[UIImageView alloc] init];
        [self addSubview:imgRank];
        self.imgRank=imgRank;
        
        UILabel *lblName=[[UILabel alloc]init];
        lblName.font=nameFont;
        [self addSubview:lblName];
        self.lblName=lblName;
        
        UILabel *lblTime=[[UILabel alloc]init];
        lblTime.font=timeFont;
        lblTime.textColor=[UIColor orangeColor];
        [self addSubview:lblTime];
        self.lblTime=lblTime;
        
        UILabel *lblSource=[[UILabel alloc]init];
        lblSource.font=sourceFont;
        [self addSubview:lblSource];
        self.lblSource=lblSource;
        
        UILabel *lblContext=[[UILabel alloc]init];
        lblContext.numberOfLines=0;
        lblContext.font=contextFont;
        [self addSubview:lblContext];
        self.lblContext=lblContext;
    }
    return self;
}

-(void)setCellFrame:(WeiBoFrame *)cellFrame
{
    _cellFrame=cellFrame;
    self.frame=cellFrame.reViewF;
    [self setupData];
    [self setupFrame];
}

-(void)setupFrame
{
    self.frame=self.cellFrame.originalViewF;
    self.imgHead.frame=self.cellFrame.iconViewF;
    self.lblName.frame=self.cellFrame.nameLableF;
    self.imgVip.frame=self.cellFrame.vipViewF;
    self.imgRank.frame=self.cellFrame.rankViewF;
    self.lblTime.frame=self.cellFrame.timeLabelF;
    self.lblSource.frame=self.cellFrame.sourceViewF;
    self.lblContext.frame=self.cellFrame.contextViewF;
}

-(void)setupData
{
    WeiBoData *data=self.cellFrame.data;
    user *userinfo=data.user;
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:userinfo.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.lblName.text=userinfo.name;
    self.lblTime.text=data.created_at;
    self.lblSource.text=data.source;
    if(userinfo.verified)
    {
        self.imgVip.hidden=NO;
        self.imgVip.image=[UIImage imageNamed:@"avatar_vip"];
        self.lblName.textColor=[UIColor orangeColor];
    }
    else
    {
        self.imgVip.hidden=YES;
        self.lblName.textColor=[UIColor blackColor];
    }
    
    if(userinfo.mbtype>0)
    {
        self.imgVip.hidden=NO;
        NSString *imgStr=@"common_icon_membership_expired";
        if(userinfo.mbrank>0)
        {
            imgStr=[NSString stringWithFormat:@"common_icon_membership_level%d",userinfo.mbrank];
        }
        UIImage *imgRank=[UIImage imageNamed:imgStr];
        self.imgRank.image=imgRank;
    }
    else {
        self.imgRank.hidden=YES;
    }
    self.lblContext.text=data.text;
}
@end
