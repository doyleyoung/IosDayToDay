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

@interface BetweenDatesViewController()
@property (nonatomic) Boolean firstSelected;
- (void)betweenDates;
- (void)fadeInResetButton;
- (void)fadeOutResetButton;
@end

@implementation BetweenDatesViewController
@synthesize firstDateText = _firstDateText;
@synthesize secondDateText = _secondDateText;
@synthesize answerInSwitch = _answerInSwitch;
@synthesize answerText = _answerText;
@synthesize resetButton = _resetButton;
@synthesize dateChooserVisible = _dateChooserVisible;
@synthesize firstSelected = _firstSelected;
@synthesize popover = _popover;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_firstDateText addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_secondDateText addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_firstDateText addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    [_secondDateText addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    [_answerInSwitch addTarget:self action:@selector(answerInSelected:) forControlEvents:UIControlEventValueChanged];
    _resetButton.hidden = YES;
}

- (void)viewDidUnload
{
    [self setFirstDateText:nil];
    [self setSecondDateText:nil];
    [self setAnswerInSwitch:nil];
    [self setResetButton:nil];
    [self setAnswerText:nil];
    [super viewDidUnload];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pop_seg2"] ||
       [segue.identifier isEqualToString:@"pop_seg3"]) {
        _popover = [(UIStoryboardPopoverSegue *)segue popoverController];
    }
    
    ((DateChooserViewController*)segue.destinationViewController).delegate = self;
}

#pragma mark - Actions

- (IBAction)firstDatePickPressed:(id)sender
{
    _firstSelected = YES;
}

- (IBAction)secondDatePickPressed:(id)sender
{
    _firstSelected = NO;
}

- (IBAction)resetPressed:(id)sender {
    [_firstDateText setText:@""];
    [_secondDateText setText:@""];
    [_answerInSwitch setSelectedSegmentIndex:0];
    [_answerText setText:@""];
    [self.view endEditing:TRUE];
    [self fadeOutResetButton];
}

#pragma mark - Delegate methods

-(void)setDate:(NSDate *)date {
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    
    NSDateFormatter *formatter = [DateWrap getFormatter];
    if(_firstSelected) {
        [_firstDateText setText:[formatter stringFromDate:date]];
    } else {
        [_secondDateText setText:[formatter stringFromDate:date]];
    }
    [self betweenDates];
}

- (void)dateCancelled {
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
}

#pragma mark - Text field interaction

- (void)checkTextField:(id)sender {
    UITextField *textField = (UITextField *)sender;
    if ([textField.text length] > 0) {
        [self betweenDates];
    }
}

- (void)answerInSelected:(id)sender {
    [self betweenDates];
}

- (IBAction)textFieldFinished:(id)sender {
    [sender resignFirstResponder];
}

#pragma mark - Private helpers

- (void)betweenDates {
    if (([_firstDateText text] != nil && ![@"" isEqualToString:[_firstDateText text]]) &&
        ([_secondDateText text] != nil && ![@"" isEqualToString:[_secondDateText text]])) {
        NSInteger numDays = [DateWrap daysBetweenDates:[_firstDateText text] secondDate:[_secondDateText text]];
        
        if([_answerInSwitch selectedSegmentIndex] == 0) {
            [_answerText setText:[NSString stringWithFormat:@"%d", numDays]];
        } else {
            [_answerText setText:[NSString stringWithFormat:@"%d", ((int)numDays / 7)]];
        }

        [self.view endEditing:TRUE];
        [self fadeInResetButton];
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
