//
//  AppDelegate.m
//  BanTakeScreenDemo
//
//  Created by LIHH on 2020/2/24.
//  Copyright © 2020 lyz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // ios不可以禁止截屏和录屏，可以在指定页面监听截屏和录屏事件，从监听事件中做一些处理(比如弹框提示)。
    // 可以放在某个页面，也可以放在appdelegate中监听整个app运行期间。
    
    // 截屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeScreenTest) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    // iOS11后中新增了录屏功能
    if (@available(iOS 11.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureScreenTest) name:UIScreenCapturedDidChangeNotification object:nil];
    }
    
    return YES;
}

-(void)takeScreenTest{
    [self alertTakeScreenWithStr:@"您在截屏，请注意保护个人隐私"];
}
-(void)captureScreenTest{
    if (@available(iOS 11.0, *)) {
        // 开始录屏时有弹框提示，结束录屏时就不弹框了。
        if (![UIScreen mainScreen].isCaptured) {
            return;
        }
        [self alertTakeScreenWithStr:@"您在录屏，请注意保护个人隐私"];
    }
}
-(void)alertTakeScreenWithStr:(NSString *)str{
    NSLog(@"监听到截屏或录屏");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
    }];
    [alertController addAction:okAction];
    // 如果是页面，用self；如果在appdelegate中，用self.window.rootViewController
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
