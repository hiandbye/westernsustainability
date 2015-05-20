//
//  OOSMapViewController.h
//  Sustainability
//
//  Created by Ryan Hachtel on 1/13/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface OOSMapViewController : UIViewController <MKMapViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic)MKMapView *mapView;
@property (strong, nonatomic)NSArray *locations;
@property (strong, nonatomic)NSArray *interests;

-(void)fetchMapAnnotations:(NSString *)title;
-(void)displayMapAnnotations:(NSString *)title;
-(NSString *)getURLEndString:(NSString *)title;
-(void)showActionSheet:(id)sender;

@end
