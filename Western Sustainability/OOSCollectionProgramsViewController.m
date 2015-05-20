//
//  OOSCollectionProgramsViewController.m
//  Sustainability
//
//  Created by Ryan Hachtel on 2/3/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSCollectionProgramsViewController.h"
#import "OOSProgramCell.h"
#import "OOSProgramsViewController.h"
#import "FlatUIKit.h"

@interface OOSCollectionProgramsViewController ()

@property (strong, nonatomic)UICollectionView *involvedView;

@end

@implementation OOSCollectionProgramsViewController

#pragma mark - OOSCollectionProgramsViewController Setup

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
        self.title = @"Get Involved";
        
        //Loading up programList Array with Dictionaries containing all info for the cell
        //and detailView after a user taps the cell
        
        NSDictionary *headerTemp = [[NSDictionary alloc] init];
        
        NSDictionary *GEF = [[NSDictionary alloc] init];
        NSString *GEFImageString = [[NSBundle mainBundle] pathForResource:@"GEF(notemblem)" ofType:@"png"];
        GEF = @{@"title": @"Apply for a GEF Grant Today!",
                @"logoPath": GEFImageString,
                @"description1": @"blah blah blah",
                @"description2": @"blah blah blah"
                };
        
        NSDictionary *ResRAP = [[NSDictionary alloc] init];
        NSString *ResRAPImageString = [[NSBundle mainBundle] pathForResource:@"ResRAP_LogoResized" ofType:@"png"];
        ResRAP = @{@"title": @"Become an ECO Rep!",
                   @"logoPath": ResRAPImageString,
                   @"description1": @"blah blah blah",
                   @"description2": @"blah blah blah"
                   };
        
        NSDictionary *SOC = [[NSDictionary alloc] init];
        NSString *SOCImageString = [[NSBundle mainBundle] pathForResource:@"SOC_LogoResized2" ofType:@"png"];
        SOC = @{@"title": @"Certify Your Office or Workplace!",
                @"logoPath": SOCImageString,
                @"description1": @"blah blah blah",
                @"description2": @"blah blah blah"
                };
        
        NSDictionary *ST = [[NSDictionary alloc] init];
        NSString *STImageString = [[NSBundle mainBundle] pathForResource:@"Transportation2" ofType:@"png"];
        ST = @{@"title": @"Ride Your Bike To Campus!",
               @"logoPath": STImageString,
               @"description1": @"blah blah blah",
               @"description2": @"blah blah blah"
               };
        
        NSDictionary *SD = [[NSDictionary alloc] init];
        NSString *SDImageString = [[NSBundle mainBundle] pathForResource:@"Sweater-Days_LogoResized2" ofType:@"png"];
        SD = @{@"title": @"Wear A Sweater Instead Of Turning On The Heat!",
               @"logoPath": SDImageString,
               @"description1": @"blah blah blah",
               @"description2": @"blah blah blah"
               };
        
        NSDictionary *ZWW = [[NSDictionary alloc] init];
        NSString *ZWWImageString = [[NSBundle mainBundle] pathForResource:@"Zero-Waste_LogoResized" ofType:@"png"];
        ZWW = @{@"title": @"Compost And Recycle At Every Opportunity",
                @"logoPath": ZWWImageString,
                @"description1": @"blah blah blah",
                @"description2": @"blah blah blah"
                };
        
        self.programList = [[NSArray alloc] init];
        self.programList = @[headerTemp, GEF, ResRAP, SOC, ST, SD, ZWW];
        
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
 NOTES:         Additonal setup of view, fills in correct information passed from previous view
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //hides nav bar
    self.navigationController.navigationBarHidden = YES;
    
    // Do any additional setup after loading the view.
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Creating CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.involvedView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    
    [self.involvedView setDataSource:self];
    [self.involvedView setDelegate:self];
    
    [self.involvedView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifer"];
    [self.involvedView setBackgroundColor:[UIColor cloudsColor]];
    
    [self.view addSubview:self.involvedView];
    
    
}


/*
 FUNCTION:      [collectionView:
                cellForItemAtIndexPath:]
 PARAMETERS:
                collectionView              -   TYPE: UICollectionView, current UIView
                cellForItemAtIndexPath      -   TYPE: NSIndexPath, indexpath for current cell
 
 Return:        OOSProgramCell
 Notes:         Creates the cells for the collection view with the correct information
*/
-(OOSProgramCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Store information for the current cell
    NSDictionary *currentCellInfo = [self.programList objectAtIndex:indexPath.row];
    
    [collectionView registerClass:[OOSProgramCell class] forCellWithReuseIdentifier:@"cellIdentifer"];
    
    OOSProgramCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifer" forIndexPath:indexPath];
    
    //Create Header Cell
    if(indexPath.row == 0){
        UIImageView *header = [[UIImageView alloc] initWithFrame:cell.frame];
        NSString *headerImageString = [[NSBundle mainBundle] pathForResource:@"get_involved2" ofType:@"jpg"];
        header.image = [[UIImage alloc] initWithContentsOfFile:headerImageString];
        [header setClipsToBounds:YES];
        header.contentMode = UIViewContentModeScaleToFill;
        
        [cell addSubview:header];
        
        
        UILabel *headerText = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 200, 20)];
        NSMutableAttributedString *hText = [[NSMutableAttributedString alloc] initWithString:@"GET INVOLVED"];
        [hText addAttribute:NSKernAttributeName value:@(1.4) range:NSMakeRange(0, 12)];
        [hText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,12)];
        headerText.attributedText = hText;
        headerText.font = [UIFont fontWithName:@"ManifoldCF-ExtraBold" size:24];
        headerText.textAlignment = NSTextAlignmentCenter;
        
        [cell addSubview:headerText];
        
        
        UITextView *title= [[UITextView alloc] init];
        title.frame = CGRectMake(0, cell.frame.size.height-40, 320, 40);
        title.userInteractionEnabled = NO;
        title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        title.textColor = [UIColor whiteColor];
        title.text = @"For Every Person, For Every Interest";
        title.font = [UIFont fontWithName:@"ManifoldCF-DemiBoldOblique" size:18];
        title.textAlignment = NSTextAlignmentCenter;
        
        [cell addSubview:title];
        
        UIImage *backImage = [UIImage imageNamed:@"back_button.png"];
        UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 10, 45.0f, 15.0f)];
        [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:backButton];
        
        return cell;
        
    //Create last cell
    } else if (indexPath.row == ([self.programList count] -1) ){
        
        cell.header = [[NSString alloc] initWithString:[currentCellInfo objectForKey:@"title"]];
        cell.description1 = [currentCellInfo objectForKey:@"description1"];
        cell.description2 = [currentCellInfo objectForKey:@"description2"];
        
        UIImage *cellLogo = [[UIImage alloc] initWithContentsOfFile:[currentCellInfo objectForKey:@"logoPath"]];
        cell.logo = cellLogo;
        
        
        UIImageView *cellLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12.5, 75, 75)];
        cellLogoView.image = cellLogo;
        cellLogoView.contentMode = UIViewContentModeScaleAspectFit;
        [cell addSubview:cellLogoView];
        
        
        UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(130, 12.5, 170, 75)];
        title.text =[currentCellInfo objectForKey:@"title"];
        title.font = [UIFont fontWithName:@"ManifoldCF-Bold" size:18];
        title.textAlignment = NSTextAlignmentRight;
        title.backgroundColor = [UIColor clearColor];
        title.userInteractionEnabled = NO;
        [cell addSubview:title];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
        
    //Create Middle Cells
    } else {
        
        cell.header = [[NSString alloc] initWithString:[currentCellInfo objectForKey:@"title"]];
        cell.description1 = [currentCellInfo objectForKey:@"description1"];
        cell.description2 = [currentCellInfo objectForKey:@"description2"];
        
        UIImage *cellLogo = [[UIImage alloc] initWithContentsOfFile:[currentCellInfo objectForKey:@"logoPath"]];
        cell.logo = cellLogo;
        
        
        UIImageView *cellLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12.5, 75, 75)];
        cellLogoView.image = cellLogo;
        cellLogoView.contentMode = UIViewContentModeScaleAspectFit;
        [cell addSubview:cellLogoView];
        
        UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(130, 12.5, 170, 75)];
        title.text =[currentCellInfo objectForKey:@"title"];
        title.font = [UIFont fontWithName:@"ManifoldCF-Bold" size:18];
        title.textAlignment = NSTextAlignmentRight;
        title.backgroundColor = [UIColor clearColor];
        title.userInteractionEnabled = NO;
        [cell addSubview:title];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        UITextView *lineBreak = [[UITextView alloc] init];
        lineBreak.frame = CGRectMake(0, cell.frame.size.height-2, 320, 2);
        lineBreak.userInteractionEnabled = NO;
        lineBreak.backgroundColor = [UIColor turquoiseColor];
        [cell addSubview:lineBreak];
        
        return cell;
        
    }
}

#pragma mark - OOSCollectionProgramsviewController Attributes

/*
 FUNCTION:      [collectionView:
                numberOfItemsInSection:]
 PARAMETERS:
                collectionView  -   type: UICollectionView, the current Collection View
                section         -   type: NSInteger, which section
 
 RETURN:        NSInteger
 NOTES:         Returns how many cells will be in this section
*/
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.programList count];
}


/*
 FUNCTION:      [collectionView:
                layout:
                sizeForItemAtIndexPath:]
 PARAMETERS:
                collectionView          -   TYPE: UICollectionView - current viewController
                collectionViewLayout    -   TYPE: UICollectionViewLayout - layout view of the viewController
                indexPath               -   TYPE: NSIndexPath - current working indexPath
 
 RETURN:         CGSize
 Notes:          Returns the correct size for the collectionview cell for the specific indexPath
*/
//Set Correct heights for each cell
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int width = 320;
    
    int height;
    
    if (indexPath.row == 0) {
        height = 220;
        
    } else {
        height = 100;
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

#pragma mark - Default

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OOSCollectionProgramsViewController Actions


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
    
    if(indexPath.row != 0){
        
        OOSProgramsViewController *programVC = [[OOSProgramsViewController alloc] init];
    
        NSDictionary *currentCellInfo = [self.programList objectAtIndex:indexPath.row];
    
        programVC.header = [[NSString alloc] initWithString:[currentCellInfo objectForKey:@"title"]];
        programVC.detailImageString = [currentCellInfo objectForKey:@"logoPath"];
        programVC.description1 = [currentCellInfo objectForKey:@"description1"];
        programVC.description2 = [currentCellInfo objectForKey:@"description2"];
    
        [self.navigationController pushViewController:programVC animated:YES];
    }
}

/*
 FUNCTION:      [popBack]
 PARAMETERS:    N/A
 RETURN:        void
 NOTES:         When the back arrow is selected, it pops the current view off of the navigation stack
*/
-(void) popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

//******These functions are for the Tap Highlight effect, sorta hacked together but it works*********************
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0){
        
        OOSProgramCell *cell = (OOSProgramCell *)[self.involvedView cellForItemAtIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor greenSeaColor];
        
    }
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    OOSProgramCell *cell = (OOSProgramCell *)[self.involvedView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    OOSProgramCell *cell = (OOSProgramCell *)[self.involvedView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
}

//*************************************



@end
