//
//  OOSAppDelegate.h
//  Sustainability
//
//  Created by Ryan Hachtel on 1/13/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OOSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *TOD;
@property (strong, nonatomic) NSURLSession *sessionTOD;

@end
