//
//  SendToolBar.m
//  新浪微博
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "SendToolBar.h"

@interface SendToolBar()

@end

@implementation SendToolBar
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self setupBtnsWithIcon:@"compose_camerabutton_background_os7" highlighted:@"compose_camerabutton_background_highlighted_os7" Tag:ToolBarButtonTypeCamera];
        
        [self setupBtnsWithIcon:@"compose_toolbar_picture_os7" highlighted:@"compose_toolbar_picture_highlighted_os7" Tag:ToolBarButtonTypePicture];
        
        [self setupBtnsWithIcon:@"compose_emoticonbutton_background_os7" highlighted:@"compose_emoticonbutton_background_highlighted_os7" Tag:ToolBarButtonTypeEmotion];
        
        [self setupBtnsWithIcon:@"compose_trendbutton_background_os7" highlighted:@"compose_trendbutton_background_highlighted_os7" Tag:ToolBarButtonTypeTrend];
        
        [self setupBtnsWithIcon:@"compose_mentionbutton_background_os7" highlighted:@"compose_mentionbutton_background_highlighted_os7" Tag:ToolBarButtonTypeMention];
        
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
    }
    return self;
}

-(void)setupBtnsWithIcon:(NSString *)icon highlighted:(NSString*) icon2 Tag:(ToolBarButtonType) tag
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon2] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    btn.tag=tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick:(UIButton*)btn
{
    if([self.delegate respondsToSelector:@selector(sendToolBar:didClick:)])
    {
        [self.delegate sendToolBar:self didClick:btn.tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count=self.subviews.count;
    CGFloat btnW=self.w/count;
    CGFloat btnH=self.h;
    
    for (int i=0; i<count; i++) {
        CGFloat btnX=btnW*i;
        UIButton *btn=self.subviews[i];
        btn.frame=CGRectMake(btnX, 0, btnW, btnH);
    }
    
}
@end
