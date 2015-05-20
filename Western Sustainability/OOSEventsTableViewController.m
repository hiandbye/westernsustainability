//
//  OOSEventsTableViewController.m
//  Sustainability
//
//  Created by Ryan Hachtel on 3/9/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSEventsTableViewController.h"
#import "OOSTableHeader.h"
#import "OOSEventTableViewCell.h"
#import "OOSEventDetailViewController.h"
#import "FlatUIKit.h"
#import "NSString+Icons.h"
//#import "MPAnimation.h"

@interface OOSEventsTableViewController ()

//@property(strong, nonatomic)NSIndexPath *currentDayIndexPath;
//@property(strong, nonatomic)OOSEventTableViewCell *currentCell;
//@property(strong, nonatomic)NSDate *foundDate;

@end

//BOOL didScroll;

#pragma mark - OOSEventsTableView Setup

@implementation OOSEventsTableViewController

/*
 FUNCTION:      [initWithStyle:]
 PARAMETERS:    
                style   -   TYPE: UITableViewStyle, what kind of table style
 
 RETURN:        id
 Notes:         Inital Setup
*/

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Upcoming Events";
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
 Notes:         Setup of the tableView
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    //Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"OOSEventTableViewCell" bundle:nil];
    
    //Register this NIB, which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"OOSEventCell"];
    
    self.tableView.backgroundColor = [UIColor cloudsColor];
    self.tableView.separatorColor = [UIColor turquoiseColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(1, 1, 1, 1);
    
}

/*
 FUNCTION:      [tableView:
                viewForHeaderInSection:]
 PARAMETERS:
                tableView   -   TYPE: UITableView, current view
                section     -   TYPE: NSInteger, correct section value
 
 RETURN:        OOSTableHeader
 Notes:         Creates the Header Cell of the table
*/
-(OOSTableHeader *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OOSTableHeader *header = [[OOSTableHeader alloc] initWithFrame:CGRectMake(0, 0, 320, 165)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 165)];
    NSString *headerImageString = [[NSBundle mainBundle] pathForResource:@"wwu-row" ofType:@"jpg"];
    UIImage *headerImage = [[UIImage alloc] initWithContentsOfFile:headerImageString];
    imageView.image = headerImage;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setClipsToBounds:YES];
    [header addSubview:imageView];
    
    UILabel *titleUpper = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 20)];
    titleUpper.text = @"What's Going On";
    titleUpper.textColor = [UIColor whiteColor];
    titleUpper.font = [UIFont fontWithName:@"ManifoldCF-LightOblique" size:14];
    titleUpper.textAlignment = NSTextAlignmentCenter;
    
    [header addSubview:titleUpper];
    
    UILabel *titleLower = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 20)];
    NSMutableAttributedString *titleLowerText = [[NSMutableAttributedString alloc] initWithString:@"THIS MONTH"];
    [titleLowerText addAttribute:NSKernAttributeName value:@(1.4) range:NSMakeRange(0, 10)];
    [titleLowerText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,10)];
    titleLower.attributedText = titleLowerText;
    titleLower.font = [UIFont fontWithName:@"ManifoldCF-ExtraBold" size:22];
    titleLower.textAlignment = NSTextAlignmentCenter;
    
    [header addSubview:titleLower];
    
    UIImage *backImage = [UIImage imageNamed:@"back_button.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 45.0f, 15.0f)];
    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:backButton];
    
    return header;
}

/*
 FUNCTION:      [tableView:
                cellForRowAtIndexPath:]
 PARAMETERS:
                tableView   -   TYPE: UITableView, current UIView
                indexPath   -   TYPE: NSIndexPath, indexpath for current cell
 
 Return:        OOSEventTableViewCell
 Notes:         Creates the cells for the tableview with the correct information
*/
- (OOSEventTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get the event corresponding to the current cell
    NSDictionary *currentEvent = [self.eventList objectAtIndex:indexPath.row];
    
    OOSEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OOSEventCell" forIndexPath:indexPath];
    
    if(cell == nil ){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OOSEventTableviewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    
    
    //Pull out neccessary info to populate the cell
    NSString *title = [currentEvent objectForKey:@"title"];
    NSString *time = [currentEvent objectForKey:@"time"];
    NSString *date = [currentEvent objectForKey:@"date"];
    NSString *location = [currentEvent objectForKey:@"location"];
    NSString *category = [currentEvent objectForKey:@"category"];
    
    //Populate with the correct info
    cell.eventDate.text = date;
    [cell.eventDate.text uppercaseString];
    cell.eventDate.font = [UIFont fontWithName:@"ManifoldCF-Bold" size:18];
    
    cell.eventTitle.text = title;
    cell.eventTitle.font = [UIFont fontWithName:@"ManifoldCF-Light" size:14];
    
    cell.eventLocation.text = location;
    cell.eventLocation.font = [UIFont fontWithName:@"ManifoldCF-Light" size:14];
    
    cell.eventTime.text = time;
    cell.eventTime.font = [UIFont fontWithName:@"ManifoldCF-Light" size:14];
    
    //Set the Correct Image
    if([category isEqualToString:@"OS"]) {
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"Foot-2" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
        
    } else if([category isEqualToString:@"GEF"]){
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"GEF(notemblem)" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
        
    } else if([category isEqualToString:@"ResRAP"]){
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"ResRAP_LogoResized" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
        
    } else if([category isEqualToString:@"SOC"]){
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"SOC_LogoResized2" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
        
    } else if([category isEqualToString:@"ZeroWaste"]){
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"Zero-Waste_LogoResized" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
        
    } else if([category isEqualToString:@"SW"]){
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"Sweater-Days_LogoResized2" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
        
        
    } else if([category isEqualToString:@"Transportation"]){
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"Transportation_LogoResized" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
        
    } else if([category isEqualToString:@"ESP"]){
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"ESP-2" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
        
    } else if([category isEqualToString:@"AS"]){
        
        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"AS-1" ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageString];
        cell.eventImage.image = image;
    }
    
    cell.eventImage.contentMode = UIViewContentModeScaleAspectFit;
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor greenSeaColor];
    [cell setSelectedBackgroundView:selectedView];
    
    //***Logic to find the day's(or closet day's) date for the auto scroll functionality***
    /*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     
     NSString *dateCheckString = [currentEvent objectForKey:@"dateCheck"];
     NSDate *checkDate = [dateFormatter dateFromString:dateCheckString];
     NSDate *todayDate = [NSDate date];
     
     NSComparisonResult result = [checkDate compare:todayDate];
     
     result = [checkDate compare:todayDate];
     
     if(result == NSOrderedAscending){
     [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
     self.foundDate = checkDate;
     self.currentDayIndexPath = indexPath;
     
     } else if (result == NSOrderedSame){
     [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
     self.foundDate = checkDate;
     self.currentDayIndexPath = indexPath;
     }*/
    //**********************
    
    return cell;
    
    
}


#pragma mark - Defaults

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - OOSEventsTableView Attributes

/*
 FUNCTION:      [tableView:
                numberOfRowsInSection:]
 PARAMETERS:    
                tableView   -   TYPE: UITableView
                section     -   TYPE: NSInteger, value for specific section of the table
 
 RETURN:        NSInteger
 NOTES:         Correct numbers of rows to displayed in the table
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
          
    return [self.eventList count];
    
}


/*
 FUNCTION:      [tableView:
                heightForHeaderInSection:]
 PARAMETERS:    
                tableView   -   TYPE: UITableView
                section     -   TYPE: NSInteger
 
 RETURN:        CGFloat
 NOTES:         Set the height for the headerCell view
*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 165;
}


/*
 FUNCTION:      [tableView:
                heightForRowInSection:]
 PARAMETERS:
                tableView   -   TYPE: UITableView
                indexpath   -   TYPE: NSIndexPath
 
 RETURN:        CGFloat
 NOTES:         Set the height for the cell at the specified indexPath
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Actions

/*
 FUNCTION:      [tableView:
                didSelectRowAtIndexPath:]
 PARAMETERS:
                tableView   -   TYPE: UITableView
                indexPath   -   TYPE: NSIndexPath
 
 RETURN:        void
 NOTES:         Create and Push the correct OOSEventDetailViewController depending on which cell was selected;
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *currentEvent = [self.eventList objectAtIndex:indexPath.row];
    
    OOSEventDetailViewController *eventDetailVC = [[OOSEventDetailViewController alloc] init];
    
    eventDetailVC.title = [currentEvent objectForKey:@"title"];
    eventDetailVC.time = [currentEvent objectForKey:@"time"];
    eventDetailVC.date = [currentEvent objectForKey:@"date"];
    eventDetailVC.location = [currentEvent objectForKey:@"location"];
    eventDetailVC.category = [currentEvent objectForKey:@"category"];
    eventDetailVC.descriptionLong = [currentEvent objectForKey:@"descriptLong"];
    eventDetailVC.startFormatDate = [currentEvent objectForKey:@"startFormatDate"];
    eventDetailVC.endFormatDate = [currentEvent objectForKey:@"endFormatDate"];
    
    [self.navigationController pushViewController:eventDetailVC animated:YES];
}

//Start the Automatic Scroll when cells have loaded
//Code help for first if statement: http://stackoverflow.com/questions/4163579/how-to-detect-the-end-of-loading-of-uitableview
//Second if statement:http://stackoverflow.com/questions/8052999/check-if-a-specific-uitableviewcell-is-visible-in-a-uitableview

/*
-(void) tableView:(UITableView *)tableView willDisplayCell:(OOSEventTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Make it so the automatic scrolling only happens once when the view is first loaded;
    if(!didScroll){
        //end of loading
        
        [self.tableView scrollToRowAtIndexPath:self.currentDayIndexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
        NSLog(@"Scrolling");
        

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *dateCheckString = cell.eventTime.text;
        NSLog(@"%@", dateCheckString);
        NSDate *checkDate = [dateFormatter dateFromString:dateCheckString];
        
        if (checkDate == self.foundDate) {
            didScroll = YES;
            NSLog(@"Found");
        }
        
    }
    
}
*/

/*
 FUNCTION:      [popBack]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         When the back arrow is selected, it pops the current view off of the navigation stack
*/
-(void) popBack {
    //didScroll = NO;
    [self.navigationController popViewControllerAnimated:YES];
}



@end
