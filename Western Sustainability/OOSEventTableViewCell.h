//
//  OOSEventTableViewCell.h
//  Sustainability
//
//  Created by Ryan Hachtel on 3/9/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OOSEventTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UITextField *eventDate;
@property (strong, nonatomic) IBOutlet UITextField *eventLocation;
@property (strong, nonatomic) IBOutlet UITextField *eventTime;


@end
