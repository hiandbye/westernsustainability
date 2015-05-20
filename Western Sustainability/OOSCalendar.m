//
//  OOSCalendar.m
//  Sustainability
//
//  The following code for the calendar is credited to https://gist.github.com/martinsik/5115383
//  NOT my own code.
//

#import "OOSCalendar.h"
#import <EventKit/EventKit.h>



static EKEventStore *eventStore = nil;

@implementation OOSCalendar


+ (void) requestAccess:(void (^)(BOOL granted, NSError *error))callback
{
    if(eventStore == nil) {
        eventStore = [[EKEventStore alloc] init];
    }
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:callback];
}

+ (BOOL) addEventAt:(NSDate *)startDate endAt:(NSDate *)endDate withTitle:(NSString *)title inLocation:(NSString *)location withDescription:(NSString *)notes
{
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    
    EKCalendar *calendar = nil;
    
    NSString *calendarIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"myCalendarIdentifier"];
    
    //when identifer exists, my calendar probably already exists
    //Note that user can delete my calendar. In that case create it again.
    if(calendarIdentifier) {
        calendar = [eventStore calendarWithIdentifier:calendarIdentifier];
    }
    
    //Calendar doesn't exist, create it and save it's identifer
    if(!calendar) {
        
        calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
        
        [calendar setTitle:@"Sustainability Events"];
        
        for(EKSource *s in eventStore.sources) {
            if(s.sourceType == EKSourceTypeLocal) {
                calendar.source = s;
                break;
            }
        }
        
        //Save this in NSUserDefaults data for retrieval later
        NSString *calendarIdentifier = [calendar calendarIdentifier];
        
        NSError *error = nil;
        
        BOOL saved = [eventStore saveCalendar:calendar commit:YES error:&error];
        
        if(saved) {
            //saved successfully, store it's identifier in NSUserDefaults
            [[NSUserDefaults standardUserDefaults] setObject:calendarIdentifier forKey:@"myCalendarIdentifier"];
            
        } else {
            //unable to save calendar
            return NO;
        }
    }
    
    //this shouldn't happen
    if(!calendar) {
        return NO;
    }
    
    //assign basic information to the event
    event.calendar = calendar;
    
    event.title = title;
    event.startDate = startDate;
    event.endDate = endDate;
    event.notes = notes;
    NSLog(@"%@", notes);
    event.location = location;
    
    NSError *error = nil;
    
    BOOL result = [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&error];
    if(result) {
        return YES;
        NSLog(@"event saved succesfully");
    } else {
        NSLog(@"Error saving Event: %@", error);
        //unable to save event to the calendar
        return NO;
    }
    
}

@end
