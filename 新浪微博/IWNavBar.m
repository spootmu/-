//
//  IWNavBar.m
//  新浪微博
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "IWNavBar.h"

@implementation IWNavBar

//只执行一次
+(void)initialize
{
    if([[UIDevice currentDevice].systemVersion floatValue]<7.0)
    {
        UINavigationBar *bar=[UINavigationBar appearance];
        [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    }
    
    //设置右边按钮主题
    UIBarButtonItem *barBtn=[UIBarButtonItem appearance];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName]=[UIColor orangeColor];
    dic[NSFontAttributeName]=[UIFont systemFontOfSize:14.0];
    
    NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithDictionary:dic];
    dic2[NSForegroundColorAttributeName]=[UIColor grayColor];
    
    [barBtn setTitleTextAttributes:dic forState:UIControlStateNormal];
    [barBtn setTitleTextAttributes:dic2 forState:UIControlStateHighlighted];
    
    

}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

-(void)goRoot
{
    [self popToRootViewControllerAnimated:YES];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count>0)
    {
        viewController.hidesBottomBarWhenPushed=YES;
        
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImageName:@"navigationbar_back" highlightImageName:@"navigationbar_back_highlighted" target:self sel:@selector(back)];
        
        viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImageName:@"navigationbar_more" highlightImageName:@"navigationbar_more_highlighted" target:self sel:@selector(goRoot)];
    }
    [super pushViewController:viewController animated:animated];
}
@end
