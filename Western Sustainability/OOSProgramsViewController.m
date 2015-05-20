//
//  OOSProgramsViewController.m
//  Sustainability
//
//  Created by Ryan Hachtel on 2/2/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSProgramsViewController.h"

@interface OOSProgramsViewController ()

-(void)popBack;

@end

@implementation OOSProgramsViewController

#pragma mark - OOSProgramViewController Setup

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
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Creating ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320, 700);
    
    [self.view addSubview:self.scrollView];
    
    //Creating ImageDetailView
    UIImage *logo = [[UIImage alloc] initWithContentsOfFile:self.detailImageString];
    UIImageView *imageDetail = [[UIImageView alloc] initWithImage:logo];
    imageDetail.frame = CGRectMake(117, 10, 75, 75);
    imageDetail.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.scrollView addSubview:imageDetail];
    
    //Creating First Label
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(10, 100, 300, 30);
    label1.text = @"How to get involved:";
    label1.font = [UIFont fontWithName:@"ManifoldCF-Bold" size:20];
    
    [self.scrollView addSubview:label1];
    
    //Creating First description field
    UITextView *description1 = [[UITextView alloc] init];
    description1.frame = CGRectMake(10, 140, 300, 100);
    description1.text = self.description1;
    description1.editable = NO;
    description1.font = [UIFont fontWithName:@"ManifoldCF-Light" size:14];
    
    [self.scrollView addSubview:description1];
    
    //Creating Second Label
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(10, 300, 300, 30);
    label2.text = @"More About This Program:";
    label2.font = [UIFont fontWithName:@"ManifoldCF-Bold" size:20];
    
    [self.scrollView addSubview:label2];
    
    //Creating Second description field
    UITextView *description2 = [[UITextView alloc] init];
    description2.frame = CGRectMake(10, 340, 300, 100);
    description2.text = self.description2;
    description2.editable = NO;
    description2.font = [UIFont fontWithName:@"ManifoldCF-light" size:14];
    
    [self.scrollView addSubview:description2];
    
    //Creating backbutton
    UIImage *backImage = [UIImage imageNamed:@"back_button.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 45.0f, 15.0f)];
    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:backButton];
}

#pragma mark - OOSProgramViewController Actions

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
