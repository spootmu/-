//
//  PopView.h
//  新浪微博
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopView;
@protocol PopViewDelegate <NSObject>

@optional
-(void)PopViewdidDismiss:(PopView*)popMenu;

@end
@interface PopView : UIView
-(instancetype)initWithContentView:(UIView*)content;
+(instancetype)PopViewWithContentView:(UIView*)content;
-(void)showWithRect:(CGRect)rect;
-(void)dismiss;
@property(nonatomic,weak)id<PopViewDelegate>delegate;
@end
