//
//  ResultView.m
//  Bird
//
//  Created by MacCoder on 2/8/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "ResultView.h"
@implementation ResultView

- (IBAction)playAgainPressed:(id)sender {
    [self hideResult];
}


- (void)showResult {
    [UIView animateWithDuration:0.3f animations:^{
        self.y = 0.f;
    } completion:^(BOOL complete) {
    }];
}

- (void)hideResult {
    [UIView animateWithDuration:0.3f animations:^{
        self.y = self.height;
    } completion:^(BOOL complete) {
    }];
}


@end
