//
//  NSDate+Extension.h
//  新浪微博
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
-(BOOL)isToday;
-(BOOL)isYesterday;
-(BOOL)isThisYear;
-(NSDate*)dateWithYMD;
-(NSDateComponents*)deltaWithNow;
@end
