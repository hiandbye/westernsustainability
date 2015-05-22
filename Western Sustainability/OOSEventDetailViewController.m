//
//  OOSEventDetailViewController.m
//  Sustainability
//
//  Created by Ryan Hachtel on 3/10/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSEventDetailViewController.h"

@interface OOSEventDetailViewController ()

@end

static EKEventStore *eventStore = nil;

@implementation OOSEventDetailViewController

#pragma mark - OSSEventDetailController Setup

/*
 FUNCTION:      [initWithNibName:
                bundle:]
 PARAMETERS:
                nibNameOrNil    -   TYPE: NSString
                nibBundleOrNil  -   TYPE: NSBundle
 
 RETURN:        id
 Notes:         Inital Setup from xib file
*/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 FUNCTION:      [viewDidLoad]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         Additonal setup of view, fills in correct information passed from previous view
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Populate the view with the information passed from previous view controller
    self.eventTitle.text = self.title;
    self.eventTitle.font = [UIFont fontWithName:@"ManifoldCF-Bold" size:18];
    
    self.eventTime.text = self.time;
    self.eventTime.font = [UIFont fontWithName:@"ManifoldCF-DemiBold" size:16];
    
    self.eventDate.text = self.date;
    self.eventDate.font = [UIFont fontWithName:@"ManifoldCF-DemiBold" size:16];
    
    self.eventCategory.text = self.category;
    self.eventCategory.font = [UIFont fontWithName:@"ManifoldCF-ExtraBoldOblique" size:20];
    
    self.eventDescriptLong.text  = self.descriptionLong;
    self.eventDescriptLong.font = [UIFont fontWithName:@"ManifoldCF-Regular" size:14];
    
    //Create back button image
    UIImage *backImage = [UIImage imageNamed:@"back_button_solid.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 20, 45.0f, 15.0f)];
    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    //AddToCalendar button setup
    self.addToCalendar.titleLabel.font = [UIFont fontWithName:@"ManifoldCF-Bold" size:16];
    self.addToCalendar.buttonColor = [UIColor cloudsColor];
    self.addToCalendar.shadowColor = [UIColor greenSeaColor];
    self.addToCalendar.shadowHeight = 3.0f;
    self.addToCalendar.cornerRadius = 6.0f;
    [self.addToCalendar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addToCalendar addTarget:self action:@selector(addEventToCalendar) forControlEvents:UIControlEventTouchUpInside];


}

#pragma mark - Calender Add Function

/*
 FUNCTION:      [addEventToCalendar]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         Processes date information from the view and addes the event to the user's defautl calendar,
                and displays an alert view upon success or if an error is received
*/
-(void) addEventToCalendar
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:self.startFormatDate];
    NSDate *endDate = [dateFormatter dateFromString:self.endFormatDate];
    
    [OOSCalendar requestAccess:^(BOOL granted, NSError *error) {
        if (granted) {
            BOOL result = [OOSCalendar addEventAt:startDate endAt:endDate withTitle:self.title inLocation:self.location withDescription:self.descriptionLong];
            if (result) {
                //added to Calendar
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   //Show alert view stating Event was created
                                   FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Success!" message:@"The event was added to your calendar." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                                   
                                   alertView.delegate = self;
                                   alertView.titleLabel.textColor = [UIColor cloudsColor];
                                   alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
                                   alertView.messageLabel.textColor = [UIColor cloudsColor];
                                   alertView.messageLabel.font = [UIFont flatFontOfSize:14];
                                   alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor]colorWithAlphaComponent:0.8];
                                   alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
                                   alertView.defaultButtonColor = [UIColor cloudsColor];
                                   alertView.defaultButtonShadowColor = [UIColor asbestosColor];
                                   alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
                                   alertView.defaultButtonTitleColor = [UIColor asbestosColor];
                                   [alertView show];

                               });
                
                
            } else {
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   //unable to create event/calendar
                                   FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Oops!" message:@"Something went wrong, try adding the event again!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                                   alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
                
                                   alertView.delegate = self;
                                   alertView.titleLabel.textColor = [UIColor cloudsColor];
                                   alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
                                   alertView.messageLabel.textColor = [UIColor cloudsColor];
                                   alertView.messageLabel.font = [UIFont flatFontOfSize:14];
                                   alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor]colorWithAlphaComponent:0.8];
                                   alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
                                   alertView.defaultButtonColor = [UIColor cloudsColor];
                                   alertView.defaultButtonShadowColor = [UIColor asbestosColor];
                                   alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
                                   alertView.defaultButtonTitleColor = [UIColor asbestosColor];
                                   [alertView show];
                               });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               // you don't have permissions to access Calendars
                               FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Oops!" message:@"You need to give this App access to your calendar in your settings." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                               alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
            
                               alertView.delegate = self;
                               alertView.titleLabel.textColor = [UIColor cloudsColor];
                               alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
                               alertView.messageLabel.textColor = [UIColor cloudsColor];
                               alertView.messageLabel.font = [UIFont flatFontOfSize:14];
                               alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor]colorWithAlphaComponent:0.8];
                               alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
                               alertView.defaultButtonColor = [UIColor cloudsColor];
                               alertView.defaultButtonShadowColor = [UIColor asbestosColor];
                               alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
                               alertView.defaultButtonTitleColor = [UIColor asbestosColor];
                               [alertView show];
                           });
        }
    }];


}

#pragma mark - OOSEventDetailViewController Actions

/*
 FUNCTION:      [popBack]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         When the back arrow is selected, it pops the current view off of the navigation stack
*/
//Pop current view off navigation stack
-(void) popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Defaults



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
