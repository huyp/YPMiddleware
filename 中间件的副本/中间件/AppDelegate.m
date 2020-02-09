//
//  AppDelegate.m
//  中间件
//
//  Created by KCY_HYP on 2019/12/18.
//  Copyright © 2019 smz. All rights reserved.
//

#import "AppDelegate.h"
#import "YPRouter.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController * navigationVC  = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = navigationVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // YPMiddlewareDemo://ViewController2
//    YPRouter * router = [YPRouter routerWithAppScheme:@"YPMiddlewareDemo" nativeSchemeAttay:@[] webViewController:<#(__kindof UIViewController *)#>];
//    [router parseURL:url webCallback:nil nativeCallback:nil failed:^(NSError *error) {
//        NSLog(@"openURL error:%@",error);
//    }];
    return YES;
}


@end
