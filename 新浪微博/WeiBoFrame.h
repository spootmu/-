//
//  WeiBoFrame.h
//  新浪微博
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <Foundation/Foundation.h>
#define nameFont  [UIFont systemFontOfSize:14]
#define contextFont  [UIFont systemFontOfSize:13]
#define timeFont  [UIFont systemFontOfSize:10]
#define sourceFont  [UIFont systemFontOfSize:10]
@class WeiBoData;

@interface WeiBoFrame : NSObject
@property(nonatomic,strong) WeiBoData *data;
/**
 *  顶部
 */
@property(nonatomic,assign,readonly) CGRect topViewF;
/**
 *  头像
 */
@property(nonatomic,assign,readonly) CGRect iconViewF;
@property(nonatomic,assign,readonly) CGRect nameLableF;
@property(nonatomic,assign,readonly) CGRect vipViewF;
@property(nonatomic,assign,readonly) CGRect rankViewF;
@property(nonatomic,assign,readonly) CGRect timeLabelF;
@property(nonatomic,assign,readonly) CGRect sourceViewF;
@property(nonatomic,assign,readonly) CGRect contextViewF;
@property(nonatomic,assign,readonly) CGRect toolbarViewF;
@property(nonatomic,assign,readonly) CGFloat cellHeght;
@end
