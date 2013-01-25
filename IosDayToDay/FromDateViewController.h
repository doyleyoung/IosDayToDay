//
//  FirstViewController.h
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DateChooserViewController.h"

@interface FromDateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *numDaysText;
@property (weak, nonatomic) IBOutlet UITextField *fromDateText;
@property (weak, nonatomic) IBOutlet UILabel *answerText;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (nonatomic) Boolean dateChooserVisible;
@property (weak, nonatomic) UIPopoverController *popover;

- (IBAction)textFieldFinished:(id)sender;
- (IBAction)resetPressed:(id)sender;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)checkTextField:(id)sender;

- (void)setDate:(NSDate *)date;
- (void)dateCancelled;

@end
