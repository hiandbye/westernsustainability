//
//  OOSHomeViewController.m
//  Sustainability
//
//  Created by Ryan Hachtel on 2/26/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSHomeViewController.h"
#import "OOSSectionCell.h"
#import "OOSCollectionProgramsViewController.h"
#import "OOSMapViewController.h"
#import "OOSEventsTableViewController.h"
#import "OOSWesternSustainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FlatUIKit.h"

@interface OOSHomeViewController ()

@property (strong, nonatomic)NSURLSession *sessionEvent;
@property (strong, nonatomic)UICollectionView *homeView;
@property (strong, nonatomic)NSMutableArray *indexPaths;

@end

@implementation OOSHomeViewController

#pragma mark - UIViewController Setup

/*
 FUNCTION:      [initWithNibName:
                bundle:]
 PARAMETERS:
                nibNameOrNil    -   TYPE: NSString
                nibBundleOrNil  -   TYPE: NSBundle
 
 RETURN:        id
 NOTES:         Some visual and model setup
*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Sustainability At Western";
        
        self.sections = @[@"------- Tip Of The Day -------", @"EVENTS", @"GET INVOLVED", @"SUSTAINABLE WESTERN", @"SUSTAINABLE MAP"];
        
        
        //Creating URL Session for JSON Request
        NSURLSessionConfiguration *configEvent = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        configEvent.allowsCellularAccess = YES;
        configEvent.timeoutIntervalForRequest = 30.0;
        configEvent.timeoutIntervalForResource = 30.0;
        
        _sessionEvent = [NSURLSession sessionWithConfiguration:configEvent
                                                 delegate:nil
                                            delegateQueue:[NSOperationQueue mainQueue]];
        
    }
    
    return self;
}

/*
 FUNCTION:      [prefersStatusBarHidden]
 PARAMETERS:    N/A
 RETURN:        BOOL
 NOTES:         Hide the status bar that shows cell carrier/battery/time info
*/
- (BOOL)prefersStatusBarHidden {
    return YES;
}


/*
FUNCTION:   [viewDidLoad]
PARAMETERS: N/A
RETURN:     void
NOTES:      Inital setup of the viewController as well as NSURL Session to retrieve the events for the
            OOSEventsTableViewController
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Hide the navbar
    [self.navigationController setNavigationBarHidden:YES];
    
    
    //Create the Request to get the events for this month
    NSString *requestString = @"http://www.wwu.edu/sustain/osapplication/events.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //Starting datatask to get the data for the events section
    NSURLSessionDataTask *dataTask =
    [self.sessionEvent dataTaskWithRequest:request
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                        
                        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        self.events = jsonObject;
                        
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                        });
                        
                        
                    }];
    
    [dataTask resume];

    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Creating CollectionView and neccessary setup
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    
    self.homeView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    [self.homeView setDataSource:self];
    [self.homeView  setDelegate:self];
    
    [self.homeView  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifer"];
    [self.homeView  setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.homeView];
    
    
}

/*
 FUNCTION:      [collectionView:
                cellForItemAtIndexPath:]
 PARAMETERS:
                collectionView  -   TYPE: UICollectionView, the current Collection View
                indexPath       -   TYPE: NSIndexPath, indexPath of the current cell being created
 
 RETURN:        OOSSectionCell - Custom Subclass
 NOTES:         Returns the created cell for the indexPath loaded with correct information
*/
-(OOSSectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.homeView registerClass:[OOSSectionCell class] forCellWithReuseIdentifier:@"cellIdentifer"];
    
    OOSSectionCell *cell = [self.homeView dequeueReusableCellWithReuseIdentifier:@"cellIdentifer" forIndexPath:indexPath];
    
    cell.title = self.sections[indexPath.row];
    
    //Header Cell
    if(indexPath.row == 0){
        
        UIImageView *homeImage = [[UIImageView alloc] initWithFrame:cell.frame];
        NSString *homeImageString = [[NSBundle mainBundle] pathForResource:@"HomeViewImage" ofType:@"jpg"];
        homeImage.image = [[UIImage alloc] initWithContentsOfFile:homeImageString];
        homeImage.contentMode = UIViewContentModeScaleToFill;
        [homeImage setClipsToBounds:YES];
        [cell addSubview:homeImage];
        
        UITextField *title = [[UITextField alloc] init];
        title.frame = CGRectMake(0, cell.frame.size.height-80, 320, 40);
        title.userInteractionEnabled = NO;
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont fontWithName:@"ManifoldCF-BoldOblique" size:13];
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        title.text = self.sections[indexPath.row];
        title.textAlignment = YES;
        [cell addSubview:title];
        
        UITextView *TOD = [[UITextView alloc] init];
        TOD.frame = CGRectMake(0, cell.frame.size.height-40, 320, 40);
        TOD.userInteractionEnabled = NO;
        TOD.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        TOD.textColor = [UIColor whiteColor];
        TOD.font = [UIFont fontWithName:@"ManifoldCF-BOLD" size:18];
        TOD.text = self.TOD;
        TOD.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
        TOD.textAlignment = YES;
        [cell addSubview:TOD];
        
        //Last Cell
    }else if (indexPath.row == ([self.sections count] -1) ){
        UITextField *title = [[UITextField alloc] init];
        title.frame = CGRectMake(50, (cell.frame.size.height/2)-20, 220, 40);
        title.userInteractionEnabled = NO;
        title.text = self.sections[indexPath.row];
        title.font = [UIFont fontWithName:@"ManifoldCF-RegularOblique" size:20];
        title.textAlignment = YES;
        [cell addSubview:title];
        
        //Middle Cells
    } else {
        
        UITextField *title = [[UITextField alloc] init];
        title.frame = CGRectMake(50, (cell.frame.size.height/2)-20, 220, 40);
        title.userInteractionEnabled = NO;
        title.text = self.sections[indexPath.row];
        title.font = [UIFont fontWithName:@"ManifoldCF-RegularOblique" size:20];
        title.textAlignment = YES;
        [cell addSubview:title];
        
        UITextView *lineBreak = [[UITextView alloc] init];
        lineBreak.frame = CGRectMake(0, cell.frame.size.height-2, 320, 2);
        lineBreak.userInteractionEnabled = NO;
        lineBreak.backgroundColor = [UIColor turquoiseColor];
        [cell addSubview:lineBreak];
        
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    return cell;
    
    
}


#pragma mark - UICollectionView Attributes

/*
 FUNCTION:       [collectionView:
                numberOfItemsInSection:]
 PARAMETERS:
                collectionView  -   type: UICollectionView, the current Collection View
                section         -   type: NSInteger, which section

 RETURN:         NSInteger
 NOTES:          Returns how many cells will be in this section
*/
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.sections count];
}


/*
FUNCTION:       [collectionView:
                layout:
                sizeForItemAtIndexPath:]
PARAMETERS:
                collectionView          -   TYPE: UICollectionView - current viewController
                collectionViewLayout    -   TYPE: UICollectionViewLayout - layout view of the viewController
                indexPath               -   TYPE: NSIndexPath - current working indexPath
 
RETURN:         CGSize
Notes:          Returns the correct size for the collectionview cell for the specific indexPath
*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int width = 320;
    int height;
    
    if (indexPath.row == 0) {
        height = 340;
    } else {
        //submenu selections cells will scale according to size of device
        height = (self.view.bounds.size.height - 340)  /4;
    }
    
    return CGSizeMake(width, height);
    
}

/*
 FUNCTION:      [collectionView:
                layout:
                insetForSectionAtIndex:]
 PARAMETERS:
                collectionView          -   TYPE: UICollectionView - current viewController
                collectionViewLayout    -   TYPE: UICollectionViewLayout - layout vew of the viewController
                section                 -   TYPE: NSInteger - value for the current section
 
 Return:        UIEdgeInsets
 Notes:         Returns the correct inset(spacing) values for the section
*/
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - UICollectionView Actions
/*
 FUNCTION:      [collectionView:
                didSelectItemAtIndexPath:]
 PARAMETERS:
                collectionView  -   TYPE: UICollectionView - current viewController
                indexPath       -   TYPE: NSIndexPath - correct indexPath value for selection view
 
 Return:        void
 Notes:         Pushes the correct subview onto the navigation stack when a collectionView item is selected
*/

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row==0) {
        //Don't do anything, header doesn't lead to another VC
    }else if (indexPath.row == 1) {
        
        //Create and Push Events View Controller
        OOSEventsTableViewController *eventsVC = [[OOSEventsTableViewController alloc] init];
        eventsVC.eventList = self.events;
        
        
        [self.navigationController pushViewController:eventsVC animated:YES];
        
    } else if (indexPath.row == 2) {
        
        //Create and Push Involved View Controller
        OOSCollectionProgramsViewController *programVC = [[OOSCollectionProgramsViewController alloc] init];
        
        [self.navigationController pushViewController:programVC animated:YES];
        
    } else if (indexPath.row == 3) {
        
        //Create and Push overview View Controller
        OOSWesternSustainViewController *westernSustainVC = [[OOSWesternSustainViewController alloc] init];
        
        [self.navigationController pushViewController:westernSustainVC animated:YES];
        
    } else {
        
        //Create and Push Map Controller
        OOSMapViewController *mapVC = [[OOSMapViewController alloc] init];
        
        [self.navigationController pushViewController:mapVC animated:YES];
    }
    
}


//***These functions are for the Tap Highlight effect, sorta hacked together but it works*******
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0){
        
        OOSSectionCell *cell = (OOSSectionCell *)[self.homeView cellForItemAtIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor greenSeaColor];
        
    }
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    OOSSectionCell *cell = (OOSSectionCell *)[self.homeView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    OOSSectionCell *cell = (OOSSectionCell *)[self.homeView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
}

//*************************************

#pragma mark - Defaults

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
