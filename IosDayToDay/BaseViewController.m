//
//  BaseViewController.m
//  IosDayToDay
//
//  Created by Matt Jones on 3/30/17.
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

#import "BaseViewController.h"

@implementation BaseViewController


#pragma mark - View lifecycle

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

@end
