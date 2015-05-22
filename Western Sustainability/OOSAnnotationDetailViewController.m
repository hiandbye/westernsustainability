//
//  OOSAnnotationDetailViewController.m
//  Sustainability
//
//  Created by Ryan Hachtel on 1/28/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSAnnotationDetailViewController.h"

@interface OOSAnnotationDetailViewController ()

@end

@implementation OOSAnnotationDetailViewController

#pragma mark - OOSAnnotationDetailViewController Setup

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
        self.title = self.titleHeader;
    }
    return self;
}

/*
 FUNCTION:      [viewDidLoad]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         Setup of view, creates scrollView and fills in correct information passed from previous view
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Creating ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320, 700);
    
    [self.view addSubview:self.scrollView];
    
    //Creating ImageDetailView
    UIImageView *imageDetail = [[UIImageView alloc] initWithImage:self.dlImage];
    imageDetail.frame = CGRectMake(0, 0, 100, 100);
    imageDetail.image = self.dlImage;
    
    [self.scrollView addSubview:imageDetail];
    
    //Creating First description field
    UITextView *description1 = [[UITextView alloc] init];
    description1.frame = CGRectMake(120, 0, 200, 100);
    description1.text = self.description1;
    description1.editable = NO;
    
    [self.scrollView addSubview:description1];
    
    //Creating Second description field
    UITextView *description2 = [[UITextView alloc] init];
    description2.frame = CGRectMake(0, 120, 320, 200);
    description2.text = self.description2;
    description2.editable = NO;
    
    [self.scrollView addSubview:description2];
    
    //Creating Backbutton
    UIImage *backImage = [UIImage imageNamed:@"back_button_solid.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 45.0f, 15.0f)];
    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:backButton];
    
}

#pragma mark - OOSAnnotationDetailViewController Actions

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
