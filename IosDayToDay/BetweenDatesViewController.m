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
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet DateTextField *beginDateField;
@property (nonatomic, weak) IBOutlet DateTextField *endDateField;
@property (nonatomic, weak) IBOutlet UIView *answerView;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


#pragma mark - IBAction Methods

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    [self calculateTimeBetween];
}

- (IBAction)unitChanged:(UISegmentedControl *)sender {
    [self calculateTimeBetween];
}


#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    NSNumber *duration = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSValue *frame = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = CGRectGetHeight(frame.CGRectValue);
        self.scrollView.contentInset = insets;
        
        insets = self.scrollView.scrollIndicatorInsets;
        insets.bottom = CGRectGetHeight(frame.CGRectValue);
        self.scrollView.scrollIndicatorInsets = insets;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSNumber *duration = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = 0.0f;
        self.scrollView.contentInset = insets;
        
        insets = self.scrollView.scrollIndicatorInsets;
        insets.bottom = 0.0f;
        self.scrollView.scrollIndicatorInsets = insets;
    }];
}


#pragma mark - Private Methods

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
        
        self.answerLabel.text = [NSString stringWithFormat:@"%ld", (long)units];
        self.unitControl.hidden = NO;
    } else {
        self.answerLabel.text = @"";
    }
}

@end
