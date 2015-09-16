//
//  IWTabBar.h
//  新浪微博
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWTabBar;

@protocol IWTabBarDelegate <NSObject>


-(void)IWTabBar:(IWTabBar*) tabbar selectButtonTagFrom:(NSInteger)from selectButtonTagTo:(NSInteger)to;

-(void)IWTabBarDidClickPlusBtn:(IWTabBar *)tabbar;
@end

@interface IWTabBar : UIView
-(void)addTabBarButton:(UITabBarItem *)item;
@property(nonatomic,weak)id<IWTabBarDelegate> delegate;
@end
