//
//  OOSMapViewController.m
//  Sustainability
//
//  Created by Ryan Hachtel on 1/13/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSMapViewController.h"
#import "OOSMapObjects.h"
#import "OOSAnnotationDetailViewController.h"
//#import "TSPopoverController.h"
//#import "TSActionSheet.h"
#import "FlatUIKit.h"
//#import "MPAnimation.h"

@interface OOSMapViewController ()
{
    UIPopoverController *_popoverController;
}

@property (strong, nonatomic)NSURLSession *session;
@property (strong, nonatomic)NSURLSession *sessionImage;

@end

@implementation OOSMapViewController

#pragma mark - OOSMapViewController Setup

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
        
        
        
        //Creating URL Session for JSON Request
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        config.allowsCellularAccess = YES;
        config.timeoutIntervalForRequest = 30.0;
        config.timeoutIntervalForResource = 30.0;
        
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:nil
                                            delegateQueue:[NSOperationQueue mainQueue]];
        
        //Creating URL Session for Second JSON Request
        NSURLSessionConfiguration *configImage = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        configImage.allowsCellularAccess = YES;
        configImage.timeoutIntervalForRequest = 30.0;
        configImage.timeoutIntervalForResource = 30.0;
        
        _sessionImage = [NSURLSession sessionWithConfiguration:configImage
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
 FUNCTION:      [viewDidLoad]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         Setup of view, creates the mapView, extra buttons, and sets up for annotations
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
        [NSDictionary dictionaryWithObjectsAndKeys:
         [UIFont fontWithName:@"ManifoldCF-Bold" size:20], NSFontAttributeName, nil]];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    //Setting up the mapView
    self.mapView = [[MKMapView alloc] init];
    self.mapView.mapType = MKMapTypeHybrid;
    self.mapView.frame = self.view.bounds;
    self.mapView.delegate = self;
    self.mapView.scrollEnabled = YES;
    self.mapView.zoomEnabled = YES;
    
    [self.view addSubview:self.mapView];
    
    //When License has been purchased set up so the users location is shown/centered on
    //float userLocationLat = self.mapView.userLocation.coordinate.latitude;
    //float userLocationLng = self.mapView.userLocation.coordinate.longitude;
    
    //For now, Creating opening screen centering on the center of WWU
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(48.737153, -122.485414);
    double regionWidth = 250;
    double regionHeight = 220;
    MKCoordinateRegion openRegion = MKCoordinateRegionMakeWithDistance(centerCoordinate, regionWidth, regionHeight);
    [self.mapView setRegion:openRegion
                   animated:YES];
    
    //loading up self.locations with annotation options
    self.locations = @[@"Refill Stations", @"SOC Buildings", @"GEF Projects", @"Bike Parking", @"Compost Bins"];
    
    //Creating backbutton
    UIImage *backImage = [UIImage imageNamed:@"back_button.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60.0f, 20.0f)];
    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:1]];
    
    
    [self.view addSubview:backButton];
    
    //Creating Search Button
    UIImage *searchImage = [UIImage imageNamed:@"searchBold.png"];
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(145, 20, 30.0f, 20.0f)];
    [searchButton setBackgroundImage:searchImage forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:searchButton];
    
    
}

/*
 FUNCTION:      [mapView:
                viewForAnnotation:]
 PARAMETERS:
                mapView     -   TYPE: MKMapView, main view for this section
                annotation  -   TYPE: id<MKAnnotation>, the annotations("pins") for the map
 
 RETURN:        MKAnnotationView
 Notes:         Setup for displaying the correct annotation image for all possibilites
*/
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    NSString *markerTitle= annotation.title;
    
    
    MKAnnotationView *marker = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"marker"];
    if(!marker){
        marker = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"marker"];
    }
    
    //Logic for correct Annotation Image
    if ([markerTitle  isEqualToString: @"Refill Station"]) {
        NSString *annotationImageString = [[NSBundle mainBundle] pathForResource:@"waterbottlePinLarge" ofType:@"png"];
        UIImage *annotationImage = [[UIImage alloc] initWithContentsOfFile:annotationImageString];
        marker.image = annotationImage;
        marker.frame = CGRectMake(0, 0, 35.0f, 48.3f);
        
    } else if ([markerTitle isEqualToString:@"SOC Building"]){
        NSString *annotationImageString = [[NSBundle mainBundle] pathForResource:@"SOCPinLarge" ofType:@"png"];
        UIImage *annotationImage = [[UIImage alloc] initWithContentsOfFile:annotationImageString];
        marker.image = annotationImage;
        marker.frame = CGRectMake(0, 0, 35.0f, 48.3f);
        
    } else if ([markerTitle isEqualToString:@"GEF Project"]){
        NSString *annotationImageString = [[NSBundle mainBundle] pathForResource:@"GEFPinLarge" ofType:@"png"];
        UIImage *annotationImage = [[UIImage alloc] initWithContentsOfFile:annotationImageString];
        marker.image = annotationImage;
        marker.frame = CGRectMake(0, 0, 35.0f, 48.3f);
        
    } else if ([markerTitle isEqualToString:@"Bike Parking"]){
        NSString *annotationImageString = [[NSBundle mainBundle] pathForResource:@"bikePinLarge" ofType:@"png"];
        UIImage *annotationImage = [[UIImage alloc] initWithContentsOfFile:annotationImageString];
        marker.image = annotationImage;
        marker.frame = CGRectMake(0, 0, 35.0f, 48.3f);
        
    } else if ([markerTitle isEqualToString:@"Compost Bin"]){
        NSString *annotationImageString = [[NSBundle mainBundle] pathForResource:@"compostPinLarge" ofType:@"png"];
        UIImage *annotationImage = [[UIImage alloc] initWithContentsOfFile:annotationImageString];
        marker.image = annotationImage;
        marker.frame = CGRectMake(0, 0, 35.0f, 48.3f);
    }
    
    
    marker.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    marker.canShowCallout = YES;
    
    return marker;
    
}
/*
 FUNCTION:      [showActionSheet:];
 
 PARAMETERS:    sender  -   TYPE: id, what object sent the call
 */




/*
 FUNCTION:      [showActionSheet:
                forEvent:]
 PARAMETERS:
                sender  -   TYPE: id, what object sent the call
                event   -   TYPE: UIEvent, which event should be the trigger
 
 RETURN:        void
 NOTES:         Creates the dropdown menu to select which sustainable collection interest using the TSPopover framework
*/
/*
- (void)showActionSheet:(id)sender forEvent:(UIEvent *)event
{
    
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:@"SUSTAIN INTERESTS"];
    actionSheet.popoverBaseColor = [UIColor cloudsColor];
    
    for (int i = 0; i < [self.locations count]; i++) {
        [actionSheet addButtonWithTitle:self.locations[i] block:^{
            [self fetchMapAnnotations:self.locations[i]];
        }];
    }
    
    [actionSheet showWithTouch:event];
    
}
*/

#pragma mark - OOSMapViewController Actions

/*
 FUNCTION:      [popBack]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         When the back arrow is selected, it pops the current view off of the navigation stack
*/
-(void) popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 FUNCTION:      [mapView:
                annotationView:
                calloutAccessoryControlTapped:]
 PARAMETERS:
                mapView     -   TYPE: MKMapView, map view of the section
                view        -   TYPE: MKAnnotationView, which annotation was tapped
                control     -   TYPE: UIControl, control object
 
 RETURN:        void
 NOTES:         Loads the detail view for the annotation when tapped and requests the image for the new UIView
*/
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    OOSAnnotationDetailViewController *detailView = [[OOSAnnotationDetailViewController alloc] init];
    
    OOSMapObjects *marker = view.annotation;
    
    detailView.titleHeader = marker.title;
    detailView.description1 = marker.description1;
    detailView.description2 = marker.description2;
    detailView.imageURL = marker.imageURL;
    
    NSURL *url = [NSURL URLWithString:marker.imageURL];
    NSLog(@"%@",url);
    
    
    NSURLSessionDownloadTask *dataTask = [self.sessionImage downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
        NSLog(@"%@", location);
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            detailView.dlImage = downloadedImage;
            
            [self.navigationController pushViewController:detailView animated:YES];
            
        });
    }];
    
    [dataTask resume];
    
}

#pragma mark - OOSMapViewController Helper Functions

/*
 FUNCTION:      [fetchMappAnnotations:]
 PARAMETERS:    
                title   -   TYPE: NSString, what collection of annotations to request the json file for
 
 RETURN:        void
 NOTES:         Fetch data for all of the annotations in the collection base upon the specific choice of the user
*/
-(void)fetchMapAnnotations:(NSString *)title
{
    
    
    NSString *URLEnd = [self getURLEndString:title];
    NSString *requestString = [[NSString alloc] initWithFormat:@"http://www.wwu.edu/sustain/osapplication/locations/%@.json", URLEnd];
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithRequest:request
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                        
                        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        
                        
                        //Checking to see if self.interests has been populated before, if so delete past annotations from the mapView
                        if(self.interests){
                            self.interests = nil;
                            [self.mapView removeAnnotations:self.mapView.annotations];
                            self.interests = jsonObject;
                        }else{
                            self.interests = jsonObject;
                        }
                        
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self displayMapAnnotations:title];
                        });
                        
                        
                    }];
    
    [dataTask resume];
    
}

/*
 FUNCTION:      [displayMapAnnotations:]
 PARAMETERS:
                title   -   TYPE: NSString, which collection of annotations
 
 RETURN:        void
 NOTES:         Display all annotations of the specfic collection
*/
-(void)displayMapAnnotations:(NSString *)title
{
    
    //loop through each coordinate object
    for(int i = 0; i < [self.interests count]; i++) {
        
        NSDictionary *interestsDic = [self.interests objectAtIndex:i];
        
        
        CLLocationCoordinate2D annotationCoordinate;
        annotationCoordinate.latitude = [[interestsDic objectForKey:@"lat"] doubleValue];
        annotationCoordinate.longitude = [[interestsDic objectForKey:@"lng"] doubleValue];
        
        //Creating the OOSMapObjects instances for map
        OOSMapObjects *marker = [[OOSMapObjects alloc] init];
        
        marker.coordinate = annotationCoordinate;
        marker.title = interestsDic[@"title"];
        marker.subtitle = interestsDic[@"subtitle"];
        marker.description1 = interestsDic[@"description1"];
        marker.description2 = interestsDic[@"description2"];
        marker.imageURL = interestsDic[@"imageURL"];
        
        
        [self.mapView addAnnotation:marker];
        
    }
}


/*
 FUNCTION:      [getURLEndString:]
 PARAMETERS:
                title   -   TYPE: NSString, what collection type
 
 RETURN:        NSString
 NOTES:         Depending on the group selection, return the correc url end string to be append in the NSURLSession Task
*/
-(NSString *)getURLEndString:(NSString *)title
{
    
    if ([title isEqualToString:@"Refill Stations"]) {
        return @"refillstations";
    } else if ([title isEqualToString:@"SOC Buildings"]) {
        return @"SOCbuildings";
    } else if ([title isEqualToString:@"GEF Projects"]){
        return @"gefprojects";
    } else if ([title isEqualToString:@"Bike Parking"]){
        return @"bikeparking";
    } else if ([title isEqualToString:@"Compost Bins"]){
        return @"compostbins";
    } else {
        return @"";
    }
}

#pragma mark - Default

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mapView = nil;
}
@end
