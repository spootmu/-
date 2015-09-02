//
//  MainTabbarControl.m
//  新浪微博
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "MainTabbarControl.h"
#import "HomeTableViewController.h"
#import "MsgTableViewController.h"
#import "ZoneTableViewController.h"
#import "SettingTableViewController.h"
#import "IWTabBar.h"
#import "IWNavBar.h"
@interface MainTabbarControl()<IWTabBarDelegate>
@property(nonatomic,weak) IWTabBar *cust_tabbar;

@end
@implementation MainTabbarControl

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [self setupTabBar];
        
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    IWTabBar *cust_tabbar=[[IWTabBar alloc]init];
    cust_tabbar.frame=self.tabBar.bounds;
    
    [self.tabBar addSubview:cust_tabbar];
    
    self.cust_tabbar=cust_tabbar;
    cust_tabbar.delegate=self;
    Log(@"%@",self.tabBar.subviews);
}

-(void)viewWillAppear:(BOOL)animated
{
    Log(@"%@",self.tabBar.subviews);
    for (UIView *sub in self.tabBar.subviews) {
        if([sub isKindOfClass:[UIControl class]])
        {
            [sub removeFromSuperview];
        }
    }
}
-(void)IWTabBar:(IWTabBar *)tabbar selectButtonTagFrom:(NSInteger)from selectButtonTagTo:(NSInteger)to
{
    Log(@"%ld---%ld",(long)from,to);
    
    self.selectedIndex=to;
}
-(void)setupTabBarButton
{
//    [self.cust_tabbar addTabBarButton:@"首页" nomalImg:[UIImage imageNamed:@"tabbar_home_os7"] selectImg:[UIImage imageNamed:@"tabbar_home_selected_os7"]];
//    [self.cust_tabbar addTabBarButton:@"消息" nomalImg:[UIImage imageNamed:@"tabbar_message_center_os7"] selectImg:[UIImage imageNamed:@"tabbar_message_center_selected_os7"]];
//    [self.cust_tabbar addTabBarButton:@"广场" nomalImg:[UIImage imageNamed:@"tabbar_discover_os7"] selectImg:[UIImage imageNamed:@"tabbar_discover_selected_os7"]];
//    [self.cust_tabbar addTabBarButton:@"我" nomalImg:[UIImage imageNamed:@"tabbar_profile_os7"] selectImg:[UIImage imageNamed:@"tabbar_profile_selected_os7"]];
}

- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    childVc.title=title;
    childVc.tabBarItem.title=title;
    childVc.tabBarItem.image=[UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImageName];
    IWNavBar *nav=[[IWNavBar alloc]init];
    [nav addChildViewController:childVc];
    [self addChildViewController:nav];
    [self.cust_tabbar addTabBarButton:childVc.tabBarItem];
}
-(void)setupTabBar
{
    HomeTableViewController *home=[[HomeTableViewController alloc]init];
    [self addOneChildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    MsgTableViewController *msg=[[MsgTableViewController alloc]init];

    [self addOneChildVc:msg title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    ZoneTableViewController *zone=[[ZoneTableViewController alloc]init];

    [self addOneChildVc:zone title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    SettingTableViewController *setting=[[SettingTableViewController alloc]init];

    [self addOneChildVc:setting title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

@end
