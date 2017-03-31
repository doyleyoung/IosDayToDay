//
//  SecondViewController.m
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

#import "BetweenDatesViewController.h"
#import "DateWrap.h"
#import "DateTextField.h"


#pragma mark - Private Interface

@interface BetweenDatesViewController()
@property (nonatomic, weak) IBOutlet DateTextField *beginDateField;
@property (nonatomic, weak) IBOutlet DateTextField *endDateField;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;
@property (nonatomic, weak) IBOutlet UISegmentedControl *unitControl;
@end


#pragma mark - Implementation

@implementation BetweenDatesViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.beginDateField.dateFormatter = [DateWrap getFormatter];
    self.endDateField.dateFormatter = [DateWrap getFormatter];
}


#pragma mark - IBAction Methods

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    [self calculateTimeBetween];
}

- (IBAction)unitChanged:(UISegmentedControl *)sender {
    [self calculateTimeBetween];
}


#pragma mark - Private Methods

- (void)calculateTimeBetween {
    if (![self.beginDateField.text isEqualToString:@""]
        && ![self.endDateField.text isEqualToString:@""]) {
        NSString *begin = self.beginDateField.text;
        NSString *end = self.endDateField.text;
        NSString *answer = nil;
        if (self.unitControl.selectedSegmentIndex == 0) {
            answer = [NSString stringWithFormat:@"%ld", [DateWrap daysBetweenDates:begin secondDate:end]];
        } else if (self.unitControl.selectedSegmentIndex == 1) {
            answer = [NSString stringWithFormat:@"%ld", [DateWrap weeksBetweenDates:begin secondDate:end]];
        } else if (self.unitControl.selectedSegmentIndex == 2) {
            answer = [NSString stringWithFormat:@"%ld", [DateWrap monthsBetweenDates:begin secondDate:end]];
        } else if (self.unitControl.selectedSegmentIndex == 3) {
            answer = [DateWrap naturalLanguageBetweenDates:begin secondDate:end];
        }
        
        self.answerLabel.text = [NSString stringWithFormat:@"%@", answer];
        self.unitControl.hidden = NO;
    } else {
        self.answerLabel.text = @"";
    }
}

@end
