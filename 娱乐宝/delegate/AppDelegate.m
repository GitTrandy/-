//
//  AppDelegate.m
//  推送测试
//
//  Created by Zhang_JK on 15/3/27.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "RootViewController.h"
#import "MainViewController.h"
#import "MoreViewController.h"
#import "MusicViewController.h"
#import "NovelViewController.h"
#import "MovesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    MainViewController *mainCtr   = [[MainViewController alloc] init];
    MoreViewController *moreCtr   = [[MoreViewController alloc] init];
    MusicViewController *musicCtr = [[MusicViewController alloc] init];
    NovelViewController *novelCtr = [[NovelViewController alloc] init];
    MovesViewController *movesCtr = [[MovesViewController alloc] init];
    
    mainCtr.title  = @"主页";
    moreCtr.title  = @"更多";
    musicCtr.title = @"Music";
    movesCtr.title = @"影音";
    novelCtr.title = @"绘图动画";
    
    
    UINavigationController *mainNaCtr  = [[UINavigationController alloc] initWithRootViewController:mainCtr];
    UINavigationController *moreNaCtr  = [[UINavigationController alloc] initWithRootViewController:moreCtr];
    UINavigationController *musicNaCtr = [[UINavigationController alloc] initWithRootViewController:musicCtr];
    UINavigationController *novelNaCtr = [[UINavigationController alloc] initWithRootViewController:novelCtr];
    UINavigationController *movesNaCtr = [[UINavigationController alloc] initWithRootViewController:movesCtr];
    
    UITabBarItem *mainItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"face@2x.png"] selectedImage:[UIImage imageNamed:@"ReceiverVoiceNodePlaying"]];
    
    mainCtr.tabBarItem = mainItem;
    movesCtr.tabBarItem.image = [UIImage imageNamed:@"face@2x.png"];
    musicCtr.tabBarItem.image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying@2x"];
    moreCtr.tabBarItem.image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying@2x"];
    novelCtr.tabBarItem.image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying"];

    mainNaCtr.tabBarItem.badgeValue = @"9";
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = [[NSArray alloc] initWithObjects:mainNaCtr,musicNaCtr,movesNaCtr,novelNaCtr,moreNaCtr, nil];
    tabController.delegate = self;
    
    
    
    self.window.rootViewController = tabController;
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    //viewController.tabBarItem.title = @"被选中";

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [APService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
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
