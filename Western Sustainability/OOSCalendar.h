//
//  OOSCalendar.h
//  Sustainability
//
//  The following code for the calendar is credited to https://gist.github.com/martinsik/5115383
//  NOT my own code
//

#import <Foundation/Foundation.h>

@interface OOSCalendar : NSObject

+ (void)requestAccess:(void (^)(BOOL granted, NSError *error))callback;
+ (BOOL)addEventAt:(NSDate *)startDate endAt:(NSDate *)endDate withTitle:(NSString *)title inLocation:(NSString *)location withDescription:(NSString *)notes;


@end
