//
//  DoneBar.m
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

#import "DoneBar.h"


@interface DoneBar()
@property (nonatomic, strong, readwrite) UIBarButtonItem *doneButtonItem;
@end

@implementation DoneBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    self.items = @[space, self.doneButtonItem];
}

@end


#pragma mark -

@interface TodayBar()
@property (nonatomic, strong, readwrite) UIBarButtonItem *todayButtonItem;
@end

@implementation TodayBar

- (void)setup {
    [super setup];
    self.todayButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStylePlain target:nil action:nil];
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.items];
    [items insertObject:self.todayButtonItem atIndex:0];
    self.items = items;
}

@end
