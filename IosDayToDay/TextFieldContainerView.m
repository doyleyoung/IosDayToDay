//
//  TextFieldContainerView.m
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

#import "TextFieldContainerView.h"


@interface TextFieldContainerView ()
@property (nonatomic, weak) IBOutlet UIView *border;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *borderHeight;
@end

@implementation TextFieldContainerView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.border.backgroundColor = [UIColor colorWithWhite:0.15f alpha:1.0f];
    self.borderHeight.constant = 1.0f / [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
}

@end
