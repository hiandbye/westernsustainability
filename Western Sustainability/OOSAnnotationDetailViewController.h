//
//  OOSAnnotationDetailViewController.h
//  Sustainability
//
//  Created by Ryan Hachtel on 1/28/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OOSAnnotationDetailViewController : UIViewController

@property (strong, nonatomic)UIScrollView *scrollView;

@property (strong, nonatomic)NSString *titleHeader;
@property (strong, nonatomic)NSString *description1;
@property (strong, nonatomic)NSString *description2;
@property (strong, nonatomic)NSString *imageURL;
@property (strong, nonatomic)UIImage *dlImage;

@end
