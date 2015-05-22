//
//  OOSWesternSustainViewController.m
//  Sustainability
//
//  Created by Ryan Hachtel on 3/10/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSWesternSustainViewController.h"

@interface OOSWesternSustainViewController ()

@end

@implementation OOSWesternSustainViewController

#pragma mark - OOSWesternSustainViewController Setup

/*
 FUNCTION:      [initWithNibName:
                bundle:]
 PARAMETERS:
                nibNameOrNil    -   TYPE: NSString
                nibBundleOrNil  -   TYPE: NSBundle
 
 RETURN:        id
 NOTES:         Inital Setup from xib file
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
 NOTES:         Setup of view, creates scrollViews and fills in correct information passed from previous view
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    // Do any additional setup after loading the view.
    
    //Creating Scroll View
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(320, 600);
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    
    //Creating Image Header
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    header.image = [UIImage imageNamed:@"OOS.png"];
    header.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.scrollView addSubview:header];
    
    //Creating Title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 20)];
    title.text = @"Title Here";
    title.font = [UIFont fontWithName:@"ManifoldCF-Bold" size:20];
    
    [self.scrollView addSubview:title];
    
    //Creating Description Text
    UITextView *descript = [[UITextView alloc] initWithFrame:CGRectMake(20, 140, 260, 300)];
    descript.text = @"Insert Description Here: text text text text text text text text text text text text text text text";
    descript.userInteractionEnabled = NO;
    descript.font = [UIFont fontWithName:@"ManifoldCF-Regular" size:16];
    
    [self.scrollView addSubview:descript];
    
    //Creating backbutton
    UIImage *backImage = [UIImage imageNamed:@"back_button_solid.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 45.0f, 15.0f)];
    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:backButton];
    
}

#pragma mark - OOSWesternSustainViewController Actions

/*
 FUNCTION:      [popBack]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         When the back arrow is selected, it pops the current view off of the navigation stack
*/
-(void) popBack {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Default

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
