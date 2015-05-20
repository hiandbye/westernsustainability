//
//  OOSEventsTableViewController.h
//  Sustainability
//
//  Created by Ryan Hachtel on 3/9/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OOSEventsTableViewController : UITableViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic)NSArray *eventList;
@property (strong, nonatomic)UIImage *image;

-(void) popBack;

@end
