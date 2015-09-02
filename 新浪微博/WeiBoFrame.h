//
//  WeiBoFrame.h
//  新浪微博
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <Foundation/Foundation.h>

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
//@property(assign,nonatomic,readonly) CGRect repostViewF;
@property(nonatomic,assign,readonly) CGRect reViewF;
@property(nonatomic,assign,readonly) CGRect reNameF;
@property(assign,nonatomic,readonly) CGRect reContextF;
@property(nonatomic,assign,readonly) CGRect toolbarViewF;
@property(nonatomic,assign,readonly) CGFloat cellHeght;

@property(assign,nonatomic,readonly)CGRect originalViewF;

@property(nonatomic,assign,readonly) CGRect originalPhotosViewF;
@property(nonatomic,assign,readonly) CGRect rePhotosViewF;
@end
