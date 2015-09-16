//
//  SendTV.m
//  新浪微博
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "SendTV.h"

@interface SendTV()

@end
@implementation SendTV
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        UILabel *lblinfo=[[UILabel alloc]init];
        lblinfo.text=@"在这里输入文字...";
        lblinfo.x=5;
        lblinfo.y=5;
        lblinfo.w=200;
        lblinfo.h=20;
        lblinfo.textColor=[UIColor grayColor];
        [self addSubview:lblinfo];
    }
    return self;
}

//-(void)drawRect:(CGRect)rect
//{
//    NSString *str=@"在这里输入文字";
//    [str drawAtPoint:CGPointMake(0, 0) withAttributes:nil];
//}

@end
