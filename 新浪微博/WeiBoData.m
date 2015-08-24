//
//  WeiBoData.m
//  新浪微博
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "WeiBoData.h"

@implementation WeiBoData
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if(self=[super init])
    {
        [self setValuesForKeysWithDictionary:dic];
        NSDictionary *userDic=dic[@"user"];
    }
    return self;
}
@end
