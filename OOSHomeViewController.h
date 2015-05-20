//
//  OOSHomeViewController.h
//  Sustainability
//
//  Created by Ryan Hachtel on 2/26/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OOSHomeViewController : UIViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIGestureRecognizerDelegate>



@property (strong, nonatomic)NSArray *sections;
@property (strong, nonatomic)NSArray *events;
@property (strong, nonatomic)NSString *TOD;

@end
