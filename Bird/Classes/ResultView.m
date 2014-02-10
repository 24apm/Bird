//
//  ResultView.m
//  Bird
//
//  Created by MacCoder on 2/8/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "ResultView.h"
#import "iRate.h"

@interface ResultView()

#define RESULT_VIEW_SCORE_LABEL_ANIMATION_TOTAL_DURATION 1.0f
#define RESULT_VIEW_SCORE_LABEL_ANIMATION_STEP_DURATION 0.05f

@property NSTimer *timer;
@property int currentScore;
@property int step;
@property int targetScore;

@end

@implementation ResultView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.y = self.height;
        self.currentScore = 0;
    }
    return self;
}

- (IBAction)playAgainPressed:(id)sender {
    [self hide];
}

- (void)show {
    self.y = self.height;
    self.currentScore = 0;
    self.targetScore = [self.currentScoreLabel.text intValue];
    self.currentScoreLabel.text = [NSString stringWithFormat:@"%d", self.currentScore];
    self.step = ceil((float)self.targetScore / (RESULT_VIEW_SCORE_LABEL_ANIMATION_TOTAL_DURATION/RESULT_VIEW_SCORE_LABEL_ANIMATION_STEP_DURATION));
   
    [UIView animateWithDuration:0.3f animations:^{
        self.y = 0.f;
    } completion:^(BOOL complete) {
        [self animateLabel];
    }];
    [[iRate sharedInstance] promptIfNetworkAvailable];
}

- (void)updateScoreLabel {
    self.currentScoreLabel.text = [NSString stringWithFormat:@"%d", self.currentScore];
    if (self.currentScore >= self.targetScore) {
        [self.timer invalidate], self.timer = nil;
        self.currentScoreLabel.text = [NSString stringWithFormat:@"%d", self.targetScore];
    } else {
        self.currentScore += self.step;
    }
}

- (void)animateLabel {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:RESULT_VIEW_SCORE_LABEL_ANIMATION_STEP_DURATION target:self selector:@selector(updateScoreLabel) userInfo:nil repeats:YES];
    [self.timer fire];
    
//    self.currentScoreLabel.transform = CGAffineTransformIdentity;
//    [UIView animateWithDuration:RESULT_VIEW_SCORE_LABEL_ANIMATION_TOTAL_DURATION/2.f animations:^{
//        self.currentScoreLabel.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
//    } completion:^(BOOL complete) {
//        [UIView animateWithDuration:RESULT_VIEW_SCORE_LABEL_ANIMATION_TOTAL_DURATION/2.f animations:^{
//            self.currentScoreLabel.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL complete) {
//        }];
//    }];
//    
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
