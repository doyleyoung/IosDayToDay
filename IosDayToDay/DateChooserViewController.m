//
//  DateChooserViewController.m
//  DateTest
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

#import "DateChooserViewController.h"

@interface DateChooserViewController()
@property (strong, nonatomic) NSDate *curDate;
@end

@implementation DateChooserViewController
@synthesize delegate = _delegate;
@synthesize datePicker = _datePicker;
@synthesize curDate = _curDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [DateChooserViewController class];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)finishDateChooser:(id)sender {
    [(id)self.delegate setDate:_datePicker.date];
}

- (IBAction)dismissDateChooser:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [(id)self.delegate dateCancelled];
}

- (void)viewWillDisappear:(BOOL)animated {
    [(id)self.delegate setDateChooserVisible:NO];
}

- (void)viewDidAppear:(BOOL)animated {
}
@end
