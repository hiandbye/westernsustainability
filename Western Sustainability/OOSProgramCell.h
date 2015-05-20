//
//  OOSProgramCell.h
//  Sustainability
//
//  Created by Ryan Hachtel on 2/4/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OOSProgramCell : UICollectionViewCell <UIGestureRecognizerDelegate>

//-(void)didTapCell:(UITapGestureRecognizer *)recognizer;

@property(strong, nonatomic)NSString *header;
@property(strong, nonatomic)UIImage *logo;
@property(strong, nonatomic)UIImageView *logoView;
@property(strong, nonatomic)NSString *description1;
@property(strong, nonatomic)NSString *description2;


@end
