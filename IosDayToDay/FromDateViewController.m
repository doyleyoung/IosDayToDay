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
#import "DateTextField.h"


#pragma mark - Private Interface

@interface FromDateViewController()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UITextField *numDaysField;
@property (nonatomic, weak) IBOutlet DateTextField *fromDateField;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;
@property (nonatomic) BOOL fromDatePickerVisible;
@end


#pragma mark - Implementation

@implementation FromDateViewController


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fromDateField.dateFormatter = [DateWrap getFormatter];
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
    [self calculateDate];
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
