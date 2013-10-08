//
//  DateWrap.m
//  IosDayToDay
//
// Copyright (C) 2013 Doyle Young
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "DateWrap.h"
#import <math.h>

static NSString *const DATE_FORMAT = @"MM/dd/yyyy";

@implementation DateWrap

/**
 * Calculate date which is numDays from given date and return it as a string.
 */
+ (NSString *)fromDate:(NSString *)numDays date:(NSString *)date {    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FORMAT];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:[numDays integerValue]];
    
    NSDate *theDate = [dateFormat dateFromString:date];

    if (theDate != nil) {
        return [dateFormat stringFromDate:[gregorian dateByAddingComponents:offsetComponents toDate:theDate options:0]];
    } else {
        // XXX invalid date
        return nil;
    }
}

/**
 * Calculate the number of days between the given dates and return it as an int.
 */
+ (NSInteger)daysBetweenDates:(NSString *)firstDate
                   secondDate:(NSString *)secondDate {
    NSDateComponents *components = [DateWrap componentsBetweenDates:firstDate
                                                         secondDate:secondDate
                                                              units:NSDayCalendarUnit];
    if (components) {
        return abs([components day]);
    } else {
        // XXX invalid date
        return -1;
    }
}

+ (NSInteger)weeksBetweenDates:(NSString *)firstDate
                    secondDate:(NSString *)secondDate {
    NSDateComponents *components = [DateWrap componentsBetweenDates:firstDate
                                                         secondDate:secondDate
                                                              units:NSWeekCalendarUnit];
    if (components) {
        return abs([components week]);
    } else {
        // XXX invalid date
        return -1;
    }
}

+ (NSInteger)monthsBetweenDates:(NSString *)firstDate
                     secondDate:(NSString *)secondDate {
    NSDateComponents *components = [DateWrap componentsBetweenDates:firstDate
                                                         secondDate:secondDate
                                                              units:NSMonthCalendarUnit];
    if (components) {
        return abs([components month]);
    } else {
        // XXX invalid date
        return -1;
    }
}

+ (NSDateComponents *)componentsBetweenDates:(NSString *)firstDate
                                  secondDate:(NSString *)secondDate
                                       units:(NSUInteger)unitFlags {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FORMAT];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *fromDate = [dateFormat dateFromString:firstDate];
    NSDate *toDate = [dateFormat dateFromString:secondDate];
    
    if(fromDate != nil && toDate != nil) {
        return [gregorian components:unitFlags
                            fromDate:fromDate
                              toDate:toDate
                             options:0];
    } else {
        // XXX invalid date
        return nil;
    }
}

/**
 * Get a date formatter populated with the standard date format.
 */
+ (NSDateFormatter *)getFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    return formatter;
}

+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!"
                format:@"Static class 'DateWrap' cannot be instantiated!"];
    return nil;
}

@end
