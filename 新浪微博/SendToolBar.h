//
//  SendToolBar.h
//  新浪微博
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SendToolBar;
typedef enum {
    ToolBarButtonTypeCamera,
    ToolBarButtonTypePicture,
    ToolBarButtonTypeTrend,
    ToolBarButtonTypeEmotion,
    ToolBarButtonTypeMention
} ToolBarButtonType;

@protocol SendToolBarDelegate <NSObject>

-(void)sendToolBar:(SendToolBar*)stb didClick:(ToolBarButtonType)btntype;

@end
@interface SendToolBar : UIView
@property(weak,nonatomic)id<SendToolBarDelegate>delegate;
@end
