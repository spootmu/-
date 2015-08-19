//
//  PopView.m
//  新浪微博
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "PopView.h"

@interface PopView ()
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,weak)UIButton *cover;
@property(nonatomic,weak)UIImageView *imgPop;
@end

@implementation PopView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame])
    {
        Log(@"initWithFrame");
        UIButton *cover=[[UIButton alloc]init];
        cover.backgroundColor=[UIColor clearColor];

        [cover addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        
        self.cover=cover;
        
        UIImageView *imgPop=[[UIImageView alloc]init];
        imgPop.image=[UIImage resizableImageWithName:@"popover_background"];
        [cover addSubview:imgPop];
        self.imgPop=imgPop;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.cover.frame=self.bounds;
}
-(instancetype)initWithContentView:(UIView *)content
{
    self=[super init];
    if(self)
    {
        self.contentView=content;
        Log(@"initWithContentView");
    }
    return self;
}

+(instancetype)PopViewWithContentView:(UIView *)content
{
    return [[self alloc]initWithContentView:content];
}

-(void)showWithRect:(CGRect)rect
{
    UIApplication *app= [UIApplication sharedApplication];
    self.frame=app.keyWindow.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.imgPop.frame=rect;
    self.imgPop.userInteractionEnabled=YES;
    [self.imgPop addSubview:self.contentView];
    
    self.contentView.x=10;
    self.contentView.y=15;
}
-(void)dismiss
{
    if([self.delegate respondsToSelector:@selector(PopViewdidDismiss:)])
    {
        [self.delegate PopViewdidDismiss:self];
    }
    [self removeFromSuperview];
}
@end
