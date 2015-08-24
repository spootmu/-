//
//  OAuthData.h
//  新浪微博
//
//  Created by apple on 15/8/21.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthData : NSObject<NSCoding>
/** 用于调用access_token，接口获取授权后的access token*/
@property(nonatomic,copy) NSString *access_token;
@property(nonatomic,strong) NSNumber *expires_in;
@property(nonatomic,strong) NSNumber *remind_in;
@property(nonatomic,strong) NSNumber *uid;
-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)OAuthDataWithDic:(NSDictionary*)dic;

@end
