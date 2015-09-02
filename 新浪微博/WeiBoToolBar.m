//
//  WeiBoToolBar.m
//  新浪微博
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoToolBar.h"
#import "WeiBoData.h"
#import "user.h"
@interface WeiBoToolBar()
@property(strong,nonatomic) NSMutableArray *btnsArr;
@property(strong,nonatomic) NSMutableArray *dividersArr;
@property(weak,nonatomic)UIButton *btnTurnPost;
@property(weak,nonatomic) UIButton *btnComment;
@property(weak,nonatomic) UIButton *btnGood;
@end
@implementation WeiBoToolBar


-(NSMutableArray *)btnsArr
{
    if(!_btnsArr)
    {
        _btnsArr=[NSMutableArray array];
    }
    return _btnsArr;
}

-(NSMutableArray *)dividersArr
{
    if(!_dividersArr)
    {
        _dividersArr=[NSMutableArray array];
    }
    return _dividersArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.image=[UIImage imageNamed:@"timeline_card_bottom_background"];
        self.userInteractionEnabled=YES;
       self.btnTurnPost= [self addButtonWithText:@"转发" ImageNor:[UIImage imageNamed:@"timeline_icon_retweet"]];
       self.btnComment= [self addButtonWithText:@"评论" ImageNor:[UIImage imageNamed:@"timeline_icon_comment"]];
       self.btnGood = [self addButtonWithText:@"赞" ImageNor:[UIImage imageNamed:@"timeline_icon_unlike"]];
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

-(void)setupDivider
{
    UIImageView *imgDivider=[[UIImageView alloc]init];
    imgDivider.image=[UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:imgDivider];
    [self.dividersArr addObject:imgDivider];
}

-(UIButton*)addButtonWithText:(NSString*)text ImageNor:(UIImage*)imageNor
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setImage:imageNor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    
    [self.btnsArr addObject:btn];
    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW=(self.w/self.btnsArr.count);
    CGFloat btnH=self.h;
    CGFloat btnY=0;
    
    for (int i=0; i<self.btnsArr.count; i++) {
        UIButton *btn=self.btnsArr[i];
        CGFloat btnX=i*(self.w/self.btnsArr.count);
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    CGFloat divW=1;
    CGFloat divH=self.h;
    CGFloat divY=0;
    for (int i=0; i<self.dividersArr.count; i++) {
        UIImageView *div=self.dividersArr[i];
        CGFloat divX=(i+1)*btnW;
        div.frame=CGRectMake(divX, divY, divW, divH);
    }
}

-(void)setBtn:(UIButton*)btn count:(int)count originalTitle:(NSString*)title
{
    if(count>0)
    {
        NSString *countTitle=nil;
        if(count>=10000)
        {
            double caculateCount=count/10000.0;
            countTitle=[NSString stringWithFormat:@"%.1f万",caculateCount];
            countTitle=[countTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        else{
            countTitle=[NSString stringWithFormat:@"%zd",count];
        }
        [btn setTitle:countTitle forState:UIControlStateNormal];
    }
    else {
        [btn setTitle:title  forState:UIControlStateNormal];
    }
}

-(void)setData:(WeiBoData *)data
{
    _data=data;
    [self setBtn:self.btnTurnPost count:_data.reposts_count.intValue originalTitle:@"转发"];
    [self setBtn:self.btnComment count:_data.comments_count.intValue originalTitle:@"评论"];
    [self setBtn:self.btnGood count:_data.attitudes_count.intValue originalTitle:@"赞"];
}

@end
