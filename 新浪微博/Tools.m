//
//  Tools.m
//  新浪微博
//
//  Created by apple on 15/8/21.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "Tools.h"
#import "OAuthData.h"
@implementation Tools
+(OAuthData*)ReadAccount
{
    NSString *path=AccountFile;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
+(void)WriteAccount:(OAuthData*)account
{
    NSString *path=AccountFile;
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}
@end
