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
-(NSString *)source
{
    NSUInteger startloc=[_source rangeOfString:@">"].location+1;
    NSUInteger endloc=[_source rangeOfString:@"</"].location;
    NSUInteger length=endloc-startloc;
    if(_source.length>0)
    {
        NSString *finalstr=[_source substringWithRange:NSMakeRange(startloc, length)];
//        Log(@"s:%lu,e:%lu,str:%@",startloc,(unsigned long)endloc,finalstr);
        return [@"来自:" stringByAppendingString:finalstr];
    }
    return _source;
}
-(NSString *)created_at
{
    if(_created_at)
    {
//    Log(@"%@",_created_at);
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    dateFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate=[dateFormatter dateFromString:_created_at];
//    Log(@"%@,%@",createDate,[dateFormatter stringFromDate:createDate]);
    
    
        if([createDate isThisYear])
        {
            if([createDate isToday])
            {
                NSDateComponents *cmps=[createDate deltaWithNow];
                if(cmps.hour>=1)
                {
                    dateFormatter.dateFormat=[NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
                    return [dateFormatter stringFromDate:createDate];
                }
                else if(cmps.minute<60)
                {
                    dateFormatter.dateFormat=[NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
                    return [dateFormatter stringFromDate:createDate];
                }
            }
            else if([createDate isYesterday])
            {
                dateFormatter.dateFormat=@"昨天 HH时mm分";
                return [dateFormatter stringFromDate:createDate];
            }
            else{
                dateFormatter.dateFormat=@"MM月dd日 HH时mm分";
                return [dateFormatter stringFromDate:createDate];
            }
        }
        else{
                dateFormatter.dateFormat=@"yyyy年MM月dd日 HH时mm分";
                return [dateFormatter stringFromDate:createDate];
        }
    }
    return _created_at;
}


@end
