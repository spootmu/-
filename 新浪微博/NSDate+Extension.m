//
//  NSDate+Extension.m
//  新浪微博
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
-(BOOL)isToday
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    
    NSDateComponents *nowCmps=[calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents *selfCmps=[calendar components:unit fromDate:self];
    
    return (selfCmps.year==nowCmps.year)&&
           (selfCmps.month==nowCmps.month)&&
    (selfCmps.day==nowCmps.day);
}

-(BOOL)isYesterday
{
    NSDate *nowDate=[[NSDate date] dateWithYMD];
    NSDate *selfDate=[self dateWithYMD];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *cmps=[calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day==1;
}

-(NSDate*)dateWithYMD
{
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd";
    NSString *selStr=[fmt stringFromDate:self];
    return [ fmt dateFromString:selStr];
}

-(BOOL)isThisYear
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitYear;
    
    NSDateComponents *nowCmps=[calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps=[calendar components:unit fromDate:self];
    
    return nowCmps.year==selfCmps.year;
}

-(NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    int unit=NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
@end
