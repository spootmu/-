//
//  OAuthData.m
//  新浪微博
//
//  Created by apple on 15/8/21.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "OAuthData.h"


//access_token;
//expires_in;
//remind_in;
//uid;


@implementation OAuthData

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if(self=[super init])
        {
            [self setValuesForKeysWithDictionary:dic];
        }
    return self;
}
+(instancetype)OAuthDataWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in=[aDecoder decodeObjectForKey:@"expires_in"];
        self.remind_in=[aDecoder decodeObjectForKey:@"remind_in"];
        self.uid=[aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

@end
