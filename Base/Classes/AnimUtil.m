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

+ (void)wobble:(UIView *)view duration:(float)duration angle:(CGFloat)angle {
    [self wobble:view duration:duration angle:angle repeatCount:1];
}

+ (void)wobble:(UIView *)view duration:(float)duration angle:(CGFloat)angle repeatCount:(float)repeatCount {
    [view.layer removeAnimationForKey:@"iconShake"];
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [anim setFromValue:[NSNumber numberWithDouble:angle]]; // rotation angle
    [anim setToValue:[NSNumber numberWithFloat:-angle]];
    [anim setDuration:duration];
    [anim setRepeatCount:repeatCount];
    [anim setAutoreverses:YES];
    [view.layer addAnimation:anim forKey:@"iconShake"];
}

@end
