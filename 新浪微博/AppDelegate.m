//
//  AppDelegate.m
//  新浪微博
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 spoot. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabbarControl.h"
#import "NewFeaturesVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    MainTabbarControl *mainTab=[[MainTabbarControl alloc]init];
    NewFeaturesVC *nvc=[[NewFeaturesVC alloc]init];
    
    //用户偏好设置
    //kCFBundleVersionKey等同于@"CFBundleVersion"
    NSString *key=(__bridge_transfer NSString *)kCFBundleVersionKey;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *localVersion=[defaults objectForKey:key];
    
    NSDictionary *dicPlist=[NSBundle mainBundle].infoDictionary;
    NSString *currentVersion=dicPlist[key];
//    Log(@"%@",dicPlist[@"CFBundleVersion"]);
    
    //字符串对比如果是降序状态,要么第一次，要么升级了
    if([currentVersion compare:localVersion]==NSOrderedDescending)
//    if(YES)
    {
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        self.window.rootViewController=nvc;
    }
    else
    {
        self.window.rootViewController=mainTab;
    }
    
    
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
