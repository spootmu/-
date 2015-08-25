//
//  WeiBoData.m
//  新浪微博
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoData.h"
#import "WeiBoImg.h"
@implementation WeiBoData
+(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[WeiBoImg class]};
}
@end
