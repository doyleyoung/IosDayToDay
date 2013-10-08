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

@interface BetweenDatesViewController() <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *beginDateField;
@property (nonatomic, weak) IBOutlet UIButton *beginDateSelectButton;
@property (nonatomic, weak) IBOutlet UIView *beginDateFieldBorder;
@property (nonatomic, weak) IBOutlet UIDatePicker *beginDatePicker;
@property (nonatomic, weak) IBOutlet UIView *endDateAndAnswerView;
@property (nonatomic, weak) IBOutlet UITextField *endDateField;
@property (nonatomic, weak) IBOutlet UIButton *endDateSelectButton;
@property (nonatomic, weak) IBOutlet UIView *endDateFieldBorder;
@property (nonatomic, weak) IBOutlet UIDatePicker *endDatePicker;
@property (nonatomic, weak) IBOutlet UIView *answerView;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;
@property (nonatomic, weak) IBOutlet UISegmentedControl *unitControl;
@property (nonatomic) BOOL beginDatePickerVisible;
@property (nonatomic) BOOL endDatePickerVisible;
@end

@implementation BetweenDatesViewController

static CGFloat const ANIMATION_DURATION = 0.3f;
static CGFloat const SELECT_BUTTON_MARGIN = 12.0f;

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showBeginDatePicker:NO];
    [self showEndDatePicker:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.beginDateField) {
        [self.beginDateField resignFirstResponder];
        [self showBeginDatePicker:YES];
        [self showEndDatePicker:NO];
    } else if (textField == self.endDateField) {
        [self.endDateField resignFirstResponder];
        [self showBeginDatePicker:NO];
        [self showEndDatePicker:YES];
    }
    
    return NO;
}

- (void)showBeginDatePicker:(BOOL)show {
    if (self.beginDatePickerVisible != show) {
        self.beginDatePickerVisible = show;
        self.beginDateSelectButton.userInteractionEnabled = show;
        
        id animations = ^{
            CGFloat modifier = show ? 1.0f : -1.0f;
            CGRect frame = self.endDateAndAnswerView.frame;
            frame.origin.y += self.beginDatePicker.frame.size.height * modifier;
            self.endDateAndAnswerView.frame = frame;
            
            CGFloat delta = self.beginDateSelectButton.frame.size.width + SELECT_BUTTON_MARGIN;
            
            modifier = show ? -1.0f : 1.0f;
            frame = self.beginDateField.frame;
            frame.size.width += delta * modifier;
            self.beginDateField.frame = frame;
            
            frame = self.beginDateFieldBorder.frame;
            frame.size.width += delta * modifier;
            self.beginDateFieldBorder.frame = frame;
            
            self.beginDateSelectButton.alpha = show ? 1.0f : 0.0f;
        };
        
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:animations
                         completion:NULL];
    }
}

- (void)showEndDatePicker:(BOOL)show {
    if (self.endDatePickerVisible != show) {
        self.endDatePickerVisible = show;
        self.endDateSelectButton.userInteractionEnabled = show;
        
        id animations = ^{
            CGFloat modifier = show ? 1.0f : -1.0f;
            CGRect frame = self.answerView.frame;
            frame.origin.y += self.endDatePicker.frame.size.height * modifier;
            self.answerView.frame = frame;
            
            CGFloat delta = self.endDateSelectButton.frame.size.width + SELECT_BUTTON_MARGIN;
            
            modifier = show ? -1.0f : 1.0f;
            frame = self.endDateField.frame;
            frame.size.width += delta * modifier;
            self.endDateField.frame = frame;
            
            frame = self.endDateFieldBorder.frame;
            frame.size.width += delta * modifier;
            self.endDateFieldBorder.frame = frame;
            
            self.endDateSelectButton.alpha = show ? 1.0f : 0.0f;
        };
        
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:animations
                         completion:NULL];
    }
}

- (IBAction)dateSelected:(UIButton *)sender {
    if (sender == self.beginDateSelectButton) {
        self.beginDateField.text = [[DateWrap getFormatter]
                                    stringFromDate:self.beginDatePicker.date];
        [self showBeginDatePicker:NO];
    } else if (sender == self.endDateSelectButton) {
        self.endDateField.text = [[DateWrap getFormatter]
                                  stringFromDate:self.endDatePicker.date];
        [self showEndDatePicker:NO];
    }
    
    [self calculateTimeBetween];
}

- (IBAction)dateChanged:(UIDatePicker *)sender {
    if (sender == self.beginDatePicker) {
        self.beginDateField.text = [[DateWrap getFormatter] stringFromDate:sender.date];
    } else if (sender == self.endDatePicker) {
        self.endDateField.text = [[DateWrap getFormatter] stringFromDate:sender.date];
    }
    
    [self calculateTimeBetween];
}

- (IBAction)unitChanged:(UISegmentedControl *)sender {
    [self calculateTimeBetween];
}

- (void)calculateTimeBetween {
    if (![self.beginDateField.text isEqualToString:@""]
        && ![self.endDateField.text isEqualToString:@""]) {
        NSString *begin = self.beginDateField.text;
        NSString *end = self.endDateField.text;
        NSInteger units = 0;
        if (self.unitControl.selectedSegmentIndex == 0) {
            units = [DateWrap daysBetweenDates:begin secondDate:end];
        } else if (self.unitControl.selectedSegmentIndex == 1) {
            units = [DateWrap weeksBetweenDates:begin secondDate:end];
        } else if (self.unitControl.selectedSegmentIndex == 2) {
            units = [DateWrap monthsBetweenDates:begin secondDate:end];
        }
        
        self.answerLabel.text = [NSString stringWithFormat:@"%d", units];
        self.unitControl.hidden = NO;
    } else {
        self.answerLabel.text = @"";
    }
}

@end
