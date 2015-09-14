//
//  WeiBoImg.m
//  新浪微博
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoImg.h"

@implementation WeiBoImg
-(NSString *)bmiddle_pic
{
    return [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
