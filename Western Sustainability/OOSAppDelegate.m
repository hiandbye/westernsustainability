//
//  OOSAppDelegate.m
//  Sustainability
//
//  Created by Ryan Hachtel on 1/13/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSAppDelegate.h"
#import "OOSHomeViewController.h"
#import "OOSCollectionProgramsViewController.h"
#import "OOSMapViewController.h"
#import "FlatUIKit.h"

@implementation OOSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Creating URL Session for JSON Request
    NSURLSessionConfiguration *configEvent = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configEvent.allowsCellularAccess = YES;
    configEvent.timeoutIntervalForRequest = 30.0;
    configEvent.timeoutIntervalForResource = 30.0;
    
    _sessionTOD = [NSURLSession sessionWithConfiguration:configEvent
                                                delegate:nil
                                           delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *requestString = @"http://www.wwu.edu/sustain/osapplication/TOD.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //Creating Data Task to receive the correct tip of the day
    NSURLSessionDataTask *dataTask =
    [self.sessionTOD dataTaskWithRequest:request
                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                           
                           NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                           
                           
                           
                           dispatch_async(dispatch_get_main_queue(), ^{
                               NSDate *date = [NSDate date];
                               NSCalendar *gregorian = [NSCalendar currentCalendar];
                               NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:date];
                               NSInteger day = [dateComponents day];
                               
                               self.TOD = [jsonObject objectAtIndex:(day-1)];
                               
                               self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                               
                               //Creating overView VC
                               OOSHomeViewController *mainView = [[OOSHomeViewController alloc] init];
                               
                               if(error){
                                   NSLog(@"Error: %@", error.localizedDescription);
                                   mainView.TOD = @"Remeber to turn off your lights!";
                                   
                               } else {
                                   
                                   mainView.TOD = self.TOD;
                               }
                               
                               UINavigationController *mainNavVC = [[UINavigationController alloc] initWithRootViewController:mainView];
                               mainNavVC.navigationBar.barTintColor = [UIColor whiteColor];
                               
                               self.window.rootViewController = mainNavVC;
                               
                               [self.window makeKeyAndVisible];
                               
                           });
                           
                           
                       }];
    
    [dataTask resume];
    
    return YES;
    
    /*
     Its very possible this will break the entire app if a internet connection is not possible. I plan on testing connectivity issues when an I am able to run tests on an actual phone.
     
     
     */
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
