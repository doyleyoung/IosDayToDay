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

static NSString * const DATE_TEMPLATE = @"MMddyyyy";

@implementation DateWrap

/**
 * Calculate date which is numDays from given date and return it as a string.
 */
+ (NSString *)fromDate:(NSString *)numDays date:(NSString *)date {    
    NSDateFormatter *dateFormat = [DateWrap getFormatter];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
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
                                                              units:NSCalendarUnitDay];
    if (components) {
        return ABS([components day]);
    } else {
        // XXX invalid date
        return -1;
    }
}

+ (NSInteger)weeksBetweenDates:(NSString *)firstDate
                    secondDate:(NSString *)secondDate {
    NSDateComponents *components = [DateWrap componentsBetweenDates:firstDate
                                                         secondDate:secondDate
                                                              units:NSCalendarUnitWeekOfYear];
    if (components) {
        return ABS([components weekOfYear]);
    } else {
        // XXX invalid date
        return -1;
    }
}

+ (NSInteger)monthsBetweenDates:(NSString *)firstDate
                     secondDate:(NSString *)secondDate {
    NSDateComponents *components = [DateWrap componentsBetweenDates:firstDate
                                                         secondDate:secondDate
                                                              units:NSCalendarUnitMonth];
    if (components) {
        return ABS([components month]);
    } else {
        // XXX invalid date
        return -1;
    }
}

+ (NSDateComponents *)componentsBetweenDates:(NSString *)firstDate
                                  secondDate:(NSString *)secondDate
                                       units:(NSUInteger)unitFlags {
    NSDateFormatter *dateFormat = [DateWrap getFormatter];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
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

+ (NSString *)naturalLanguageBetweenDates:(NSString *)firstDate
                               secondDate:(NSString *)secondDate {
    NSDateFormatter *dateFormat = [DateWrap getFormatter];
    NSDate *fromDate = [dateFormat dateFromString:firstDate];
    NSDate *toDate = [dateFormat dateFromString:secondDate];
    NSTimeInterval interval = fabs([toDate timeIntervalSinceDate:fromDate]);
    
    NSDateComponentsFormatter *formatter = [NSDateComponentsFormatter new];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
    formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay;
    
    return [formatter stringFromTimeInterval:interval];
}

/**
 * Get a date formatter populated with the localized date format.
 */
+ (NSDateFormatter *)getFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =
    [NSDateFormatter dateFormatFromTemplate:DATE_TEMPLATE
                                    options:0
                                     locale:[NSLocale currentLocale]];
    return formatter;
}

+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!"
                format:@"Static class 'DateWrap' cannot be instantiated!"];
    return nil;
}

@end
