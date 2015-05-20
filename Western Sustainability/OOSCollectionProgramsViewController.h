//
//  OOSCollectionProgramsViewController.h
//  Sustainability
//
//  Created by Ryan Hachtel on 2/3/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OOSCollectionProgramsViewController : UIViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (strong, nonatomic)NSArray *programList;

-(void) popBack;

@end
