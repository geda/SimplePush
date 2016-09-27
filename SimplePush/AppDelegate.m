//
//  AppDelegate.m
//  SimplePush
//
//  Created by David Gerber on 25.09.16.
//  Copyright © 2016 David Gerber. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Register the supported interaction types.
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    // Register for remote notifications.
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    // init notifications
    SecondViewController *secVC = (SecondViewController *)[[((UITabBarController *)self.window.rootViewController) viewControllers] objectAtIndex:1];
    NSDictionary *notificationPlist = [self readNotificationPlist];
    if (notificationPlist != nil) {
        secVC.notifications = [[NSMutableDictionary alloc] initWithDictionary:notificationPlist];
    } else {
        secVC.notifications = [[NSMutableDictionary alloc]init];
        [secVC.notifications setObject:[[NSMutableArray alloc]init] forKey:@"notifications"];
    }
   
    
    return YES;
}

// Handle remote notification registration.
- (void)application:(UIApplication *)app
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    
    
    FirstViewController *fistVC = (FirstViewController *)[[((UITabBarController *)self.window.rootViewController) viewControllers] objectAtIndex:0];
    
    fistVC.deviceToken.text=[self stringWithDeviceToken:devToken];
    
    [self sendProviderDeviceToken:devToken]; // custom method
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    if(application.applicationState == UIApplicationStateInactive) {
        NSLog(@"Inactive");
        //Show the view with the content of the push
        
    } else if (application.applicationState == UIApplicationStateBackground) {
        
        NSLog(@"Background");
        
        //Refresh the local model
        
    } else {
        
        NSLog(@"Active");
        //Show an in-app banner
    }
   
    [self alertMe:userInfo];
    
    SecondViewController *secVC = (SecondViewController *)[[((UITabBarController *)self.window.rootViewController) viewControllers] objectAtIndex:1];

    NSMutableDictionary *pushNotificationDict =  [[NSMutableDictionary alloc]initWithDictionary:userInfo];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"dd.MM.yyyy HH:mm:ss"];
    
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    
    [pushNotificationDict setObject:stringFromDate forKey:@"receiveDate"];
    
    [[secVC.notifications objectForKey:@"notifications" ] addObject:pushNotificationDict];
    [secVC.tableView reloadData];
    [self persistNotificationPlist:secVC.notifications];
    
}
-(NSDictionary*) readNotificationPlist {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
   
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"notifications.plist"];
    NSLog(@"%@", plistPath);
    NSDictionary *list = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return list;
}

-(void) persistNotificationPlist:(NSDictionary *) notifications {
    // save NSDictionary to plist file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"notifications.plist"];
    NSLog(@"%@", plistPath);
   
    [notifications writeToFile:plistPath atomically: YES];
}

- (NSString *)stringWithDeviceToken:(NSData *)deviceToken {
    const char *data = [deviceToken bytes];
    NSMutableString *token = [NSMutableString string];
    
    for (NSUInteger i = 0; i < [deviceToken length]; i++) {
        [token appendFormat:@"%02.2hhX", data[i]];
    }
    
    return [token copy];
}

- (void)application:(UIApplication *)app
didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

- (void) sendProviderDeviceToken:(NSData *) devToken {
    NSLog(@"My token is: %@", devToken);
}


-(void) alertMe:(NSDictionary *)dict {
    
    NSLog(@"remote notification: %@",[dict description]);
    NSDictionary *apsInfo = [dict objectForKey:@"aps"];
    
    NSString *alert = [apsInfo objectForKey:@"alert"];
        
    NSLog(@"Received Push Alert: %@", alert);
        
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Notification" message: [dict description] delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        
    [alertView show];

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
