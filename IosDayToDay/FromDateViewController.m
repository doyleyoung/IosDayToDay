//
//  FromDateViewController.m
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

#import "FromDateViewController.h"
#import "DateWrap.h"


#pragma mark - Private Interface

@interface FromDateViewController() <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *numDaysField;
@property (nonatomic, weak) IBOutlet UITextField *fromDateField;
@property (nonatomic, weak) IBOutlet UIView *fromDateFieldBorder;
@property (nonatomic, weak) IBOutlet UIButton *selectButton;
@property (nonatomic, weak) IBOutlet UIDatePicker *fromDatePicker;
@property (nonatomic, weak) IBOutlet UIView *answerView;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;
@property (nonatomic) BOOL fromDatePickerVisible;
@end


#pragma mark - Implementation

@implementation FromDateViewController

static CGFloat const ANIMATION_DURATION = 0.3f;
static CGFloat const SELECT_BUTTON_MARGIN = 12.0f;


#pragma mark - View lifecycle

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showDatePicker:NO];
}


#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.fromDateField) {
        [self.numDaysField resignFirstResponder];
        [self showDatePicker:YES];
        return NO;
    } else if (textField == self.numDaysField) {
        [self showDatePicker:NO];
    }
    
    return YES;
}


#pragma mark - IBAction Methods

- (IBAction)dateSelected:(UIButton *)sender {
    self.fromDateField.text = [[DateWrap getFormatter]
                               stringFromDate:self.fromDatePicker.date];
    [self showDatePicker:NO];
    [self calculateDate];
}

- (IBAction)dateChanged:(UIDatePicker *)sender {
    self.fromDateField.text = [[DateWrap getFormatter] stringFromDate:sender.date];
    [self calculateDate];
}

- (IBAction)numberChanged:(UITextField *)sender {
    [self calculateDate];
}


#pragma mark - Private Methods

- (void)showDatePicker:(BOOL)show {
    if (self.fromDatePickerVisible != show) {
        self.fromDatePickerVisible = show;
        self.selectButton.userInteractionEnabled = show;
        
        id animations = ^{
            CGFloat modifier = show ? 1.0f : -1.0f;
            CGRect frame = self.answerView.frame;
            frame.origin.y += self.fromDatePicker.frame.size.height * modifier;
            self.answerView.frame = frame;
            
            CGFloat delta = self.selectButton.frame.size.width + SELECT_BUTTON_MARGIN;
            
            modifier = show ? -1.0f : 1.0f;
            frame = self.fromDateField.frame;
            frame.size.width += delta * modifier;
            self.fromDateField.frame = frame;
            
            frame = self.fromDateFieldBorder.frame;
            frame.size.width += delta * modifier;
            self.fromDateFieldBorder.frame = frame;
            
            self.selectButton.alpha = show ? 1.0f : 0.0f;
        };
        
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:animations
                         completion:NULL];
    }
}

- (void)calculateDate {
    if (![self.numDaysField.text isEqualToString:@""]
        && ![self.fromDateField.text isEqualToString:@""]) {
        NSString *date = [DateWrap fromDate:self.numDaysField.text
                                       date:self.fromDateField.text];
        self.answerLabel.text = date;
    } else {
        self.answerLabel.text = @"";
    }
}

@end
