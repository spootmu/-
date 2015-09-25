//
//  SendTV.m
//  新浪微博
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "SendTV.h"

@interface SendTV()<UITextViewDelegate>
@property(weak,nonatomic)UILabel *lblinfo;
@end
@implementation SendTV

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=placeholder;
    self.lblinfo.text=_placeholder;
    NSDictionary *attributes = @{NSFontAttributeName:nameFont};

    CGSize size= [_placeholder boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    self.lblinfo.size=size;
    self.lblinfo.numberOfLines=0;
    
    
}

-(void)setPlaceholdercolor:(UIColor *)placeholdercolor
{
    _placeholdercolor=placeholdercolor;
    self.lblinfo.textColor=_placeholdercolor;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        UILabel *lblinfo=[[UILabel alloc]init];
        lblinfo.x=5;
        lblinfo.y=5;
        lblinfo.textColor=[UIColor grayColor];
        lblinfo.font=nameFont;
        [self addSubview:lblinfo];
        self.lblinfo=lblinfo;
        
        //注册通知,自己调自己不用代理方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
        
        self.font=nameFont;
    }
    return self;
}

//注册通知后必须调用销毁方法，否则报错
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChange
{
    if([self.text isEqualToString:@""])
    {
        self.lblinfo.hidden=NO;
    }
    else
    {
        self.lblinfo.hidden=YES;
    }
}
//-(void)drawRect:(CGRect)rect
//{
//    NSString *str=@"在这里输入文字";
//    [str drawAtPoint:CGPointMake(0, 0) withAttributes:nil];
//}

@end
