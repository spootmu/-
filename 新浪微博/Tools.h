//
//  Tools.h
//  新浪微博
//
//  Created by apple on 15/8/21.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthData.h"
@interface Tools : NSObject
+(OAuthData*)ReadAccount;
+(void)WriteAccount:(OAuthData*)account;
@end
