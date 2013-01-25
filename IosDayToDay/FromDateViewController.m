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

@interface FromDateViewController()
- (void)calculateDate;
- (void)fadeInResetButton;
- (void)fadeOutResetButton;
@end

@implementation FromDateViewController
@synthesize numDaysText = _numDaysText;
@synthesize fromDateText = _fromDateText;
@synthesize answerText = _answerText;
@synthesize resetButton = _resetButton;
@synthesize dateChooserVisible = _dateChooserVisible;
@synthesize popover = _popover;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_fromDateText addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_numDaysText addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    [_fromDateText addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    _resetButton.hidden = YES;
}

- (void)viewDidUnload
{
    [self setNumDaysText:nil];
    [self setFromDateText:nil];
    [self setAnswerText:nil];
    [self setResetButton:nil];
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pop_seg1"]) {
        _popover = [(UIStoryboardPopoverSegue *)segue popoverController];
    }
    
    ((DateChooserViewController*)segue.destinationViewController).delegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Actions

- (IBAction)resetPressed:(id)sender {
    [_numDaysText setText:@""];
    [_fromDateText setText:@""];
    [_answerText setText:@""];
    [self.view endEditing:TRUE];
    [self fadeOutResetButton];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_numDaysText resignFirstResponder];
}

#pragma mark - Delegate methods

- (void)setDate:(NSDate *)date {
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
 
    NSDateFormatter *formatter = [DateWrap getFormatter];
    [_fromDateText setText:[formatter stringFromDate:date]];
    [self calculateDate];
}

- (void)dateCancelled {
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
}

#pragma mark - Text field interaction

- (IBAction)textFieldFinished:(id)sender {
    [self.view endEditing:TRUE];
    [sender resignFirstResponder];
}

- (void)checkTextField:(id)sender {
    UITextField *textField = (UITextField *)sender;
    if ([textField.text length] > 0) {
        [self calculateDate];
    }
}

#pragma mark - Private helpers

- (void)calculateDate {
    if (![@"" isEqualToString:[_numDaysText text]] &&
        ([_fromDateText text] != nil && ![@"" isEqualToString:[_fromDateText text]])) {
        NSString *fromDate = [DateWrap fromDate:[_numDaysText text] date:[_fromDateText text]];

        if(fromDate == nil) {
            _fromDateText.layer.borderWidth = 1;
            _fromDateText.layer.borderColor = [[UIColor redColor] CGColor];
        } else {
            _fromDateText.layer.borderWidth = 0;
            [_answerText setText:fromDate];
            [self fadeInResetButton];
        }
    }
}

- (void)fadeInResetButton {
    if(_resetButton.hidden == YES) {
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.4;
        [_resetButton.layer addAnimation:animation forKey:nil];
        
        _resetButton.hidden = NO;
    }
}

- (void)fadeOutResetButton {
    if(_resetButton.hidden == NO) {
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.8;
        [_resetButton.layer addAnimation:animation forKey:nil];
        
        _resetButton.hidden = YES;
    }
}

@end
