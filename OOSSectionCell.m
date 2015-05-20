//
//  OOSSectionCell.m
//  Sustainability
//
//  Created by Ryan Hachtel on 2/26/15.
//  Copyright (c) 2015 Office Of Sustainability. All rights reserved.
//

#import "OOSSectionCell.h"
#import "FlatUIKit.h"


@implementation OOSSectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Allow Users to click cell to show next VC
        self.userInteractionEnabled = YES;

    }
    return self;
}


-(void)viewDidLoad
{
    self.backgroundColor = [UIColor whiteColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



@end
