//
//  AppDelegate.m
//  2
//
//  Created by bytedance on 2020/7/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [[ViewController alloc] init];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    self.window = window;
    
//    NSLog(@"Window is ok");
    
    
    
    
    return YES;
}

@end
