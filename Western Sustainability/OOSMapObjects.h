//
//  OOSMapObjects.h
//  Sustainability
//
//  Created by Ryan Hachtel on 1/15/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//
//Custom MKMap Annotation Object
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface OOSMapObjects : NSObject <MKAnnotation>

@property CLLocationCoordinate2D coordinate;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *subtitle;
@property (strong, nonatomic)NSString *description1;
@property (strong, nonatomic)NSString *description2;
@property (strong, nonatomic)NSString *imageURL;

@end
