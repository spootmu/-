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
#import "Tools.h"
#import "SendWeiBoView.h"
@interface MainTabbarControl()<IWTabBarDelegate>
@property(nonatomic,weak) IWTabBar *cust_tabbar;
@property(weak,nonatomic)  HomeTableViewController *home;
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
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(unReadCount) userInfo:nil repeats:YES];
}


-(void)IWTabBarDidClickPlusBtn:(IWTabBar *)tabbar
{
    SendWeiBoView *sendView=[[SendWeiBoView alloc]init];
    
    IWNavBar *nav=[[IWNavBar alloc]initWithRootViewController:sendView];
    
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *  未读消息数量
 */
-(void)unReadCount
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=[Tools ReadAccount].access_token;
    parameters[@"uid"]=[Tools ReadAccount].uid;
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        Log(@"%@",responseObject[@"status"]);
        
        //设置按钮提醒数字
        self.home.tabBarItem.badgeValue=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
        //设置app提醒数字
        [UIApplication sharedApplication].applicationIconBadgeNumber=self.home.tabBarItem.badgeValue.integerValue;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        Log(@"%@",error);
    }];
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
    
    //刷新数据
    if(to==0 && from==0)
    {
        [self.home tabRefreshClick];
    }
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
    self.home=home;
    
    MsgTableViewController *msg=[[MsgTableViewController alloc]init];

    [self addOneChildVc:msg title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    ZoneTableViewController *zone=[[ZoneTableViewController alloc]init];

    [self addOneChildVc:zone title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    SettingTableViewController *setting=[[SettingTableViewController alloc]init];

    [self addOneChildVc:setting title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

@end
