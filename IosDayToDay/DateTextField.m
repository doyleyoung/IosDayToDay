//
//  DateTextField.m
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

#import "DateTextField.h"
#import "DoneBar.h"


@interface DateTextField ()
@property (nonatomic, weak) UIDatePicker *datePicker;
@end

@implementation DateTextField

- (void)setDateFormatter:(NSDateFormatter *)dateFormatter {
    _dateFormatter = dateFormatter;
    self.placeholder = dateFormatter.dateFormat.lowercaseString;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIDatePicker *picker = [UIDatePicker new];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.backgroundColor = [UIColor whiteColor];
    [picker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.datePicker = picker;
    self.inputView = picker;
    
    TodayBar *bar = [TodayBar new];
    bar.doneButtonItem.target = self;
    bar.doneButtonItem.action = @selector(doneButtonPressed:);
    bar.todayButtonItem.target = self;
    bar.todayButtonItem.action = @selector(todayButtonPressed:);
    self.inputAccessoryView = bar;
}

- (void)doneButtonPressed:(UIBarButtonItem *)sender {
    [self resignFirstResponder];
}

- (void)todayButtonPressed:(UIBarButtonItem *)sender {
    [self.datePicker setDate:[NSDate date] animated:YES];
    [self datePickerValueChanged:self.datePicker];
}

- (void)datePickerValueChanged:(UIDatePicker *)sender {
    self.text = [self.dateFormatter stringFromDate:sender.date];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

@end
