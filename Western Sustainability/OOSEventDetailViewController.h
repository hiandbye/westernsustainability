//
//  OOSEventDetailViewController.h
//  Sustainability
//
//  Created by Ryan Hachtel on 3/10/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "OOSCalendar.h"
#import "FUIButton.h"
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIAlertView.h"

@interface OOSEventDetailViewController : UIViewController <FUIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventTime;
@property (strong, nonatomic) IBOutlet UILabel *eventDate;
@property (strong, nonatomic) IBOutlet UILabel *eventCategory;
@property (strong, nonatomic) IBOutlet UITextView *eventDescriptLong;
@property (strong, nonatomic) IBOutlet FUIButton *addToCalendar;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *descriptionLong;
@property (strong, nonatomic) NSString *startFormatDate;
@property (strong, nonatomic) NSString *endFormatDate;


-(void) popBack;
-(void) addEventToCalendar;

@end
