//
//  AnimUtil.m
//  Fighting
//
//  Created by 15inch on 5/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AnimUtil.h"
#import <QuartzCore/QuartzCore.h>

@implementation AnimUtil

+ (void)plop:(UIView *)view {
    float scale = 1.2f;
    [UIView animateWithDuration:0.3f animations:^{
        view.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        view.transform = CGAffineTransformIdentity;
    }];
}

+ (void)blink:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.toValue = [NSNumber numberWithFloat: 0.7f];
    animation.repeatCount = 3;
    animation.duration = 0.3f;
    animation.autoreverses = YES;
    [view.layer addAnimation:animation forKey:@"blink"];
}

+ (void)animate:(UIView *)view from:(CGPoint)starting to:(CGPoint)ending duration:(float)duration{
    view.center = starting;
    [UIView animateWithDuration:0.3f animations:^{
        view.center = ending;
    } completion:^(BOOL finished) {
        view.center = ending;
    }];
}

@end
