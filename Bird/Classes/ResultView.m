//
//  ResultView.m
//  Bird
//
//  Created by MacCoder on 2/8/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "ResultView.h"
#import "iRate.h"

@implementation ResultView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.y = self.height;
    }
    return self;
}

- (IBAction)playAgainPressed:(id)sender {
    [self hide];
}

- (void)show {
    [UIView animateWithDuration:0.3f animations:^{
        self.y = 0.f;
    } completion:^(BOOL complete) {
    }];
    
    [[iRate sharedInstance] promptIfNetworkAvailable];
}

- (IBAction)ratePressed:(id)sender {
	[[iRate sharedInstance] promptIfNetworkAvailable];
}

- (void)hide {
    [UIView animateWithDuration:0.3f animations:^{
        self.y = self.height;
    } completion:^(BOOL complete) {
        [[NSNotificationCenter defaultCenter] postNotificationName:RESULT_VIEW_DISMISSED_NOTIFICATION object:self];
    }];
}


@end
