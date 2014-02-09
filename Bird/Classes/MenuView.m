//
//  MenuView.m
//  Bird
//
//  Created by MacCoder on 2/8/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    }
    return self;
}

- (IBAction)startButtonPressed:(id)sender {
    [self hide];
}

- (void)show {
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.0f;
    } completion:^(BOOL complete) {
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        self.alpha = 0.0f;
    } completion:^(BOOL complete) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MENU_VIEW_DISMISSED_NOTIFICATION object:self];
    }];
}


@end
