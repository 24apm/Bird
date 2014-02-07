//
//  GameLoopTimer.m
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "GameLoopTimer.h"

@implementation GameLoopTimer

+ (GameLoopTimer *)instance {
    static GameLoopTimer *gameLoopTimer;
    if (!gameLoopTimer) {
        gameLoopTimer = [[GameLoopTimer alloc] init];
    }
    return gameLoopTimer;
}

- (void) initialize
{
    //
    // init timer to perform animations
    //
#ifdef USE_NSTIMER
    [self initializeTimerWithNSTimer];
#else
    [self initializeTimerWithCADisplayLink];
#endif
}

#pragma mark -
#pragma mark Private Methods

- (void)initializeTimerWithNSTimer {
    CGFloat interval = 1.0f / 60.0f;
    [NSTimer scheduledTimerWithTimeInterval:interval
                                     target:self
                                   selector:@selector(performStepNSTimer:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)initializeTimerWithCADisplayLink {
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(performStepCADisplayLink)];
    _timer.frameInterval = 2;
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)performStepNSTimer:(NSTimer *)timer
{
    [self drawStep];
}

- (void)performStepCADisplayLink
{
    [self drawStep];
}

- (void)drawStep {
    [[NSNotificationCenter defaultCenter] postNotificationName:DRAW_STEP_NOTIFICATION object:nil];
}


@end
