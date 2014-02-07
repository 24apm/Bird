//
//  LadyBugView.m
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "LadyBugView.h"
#import "Utils.h"
#import "GameConstants.h"

@interface LadyBugView()

@end

@implementation LadyBugView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [super setup];
    self.properties.rotation = 0.f;
    self.properties.acceleration = CGPointMake(0.f, 0.f);
    self.properties.accelerationMin = CGPointMake(0.f, -1.6f);
    self.properties.accelerationMax = CGPointMake(0.f, 0.20f);

    self.properties.speed = CGPointMake(0.f, 2.f);
    self.properties.speedMin = CGPointMake(0.f, -3.0f);
    self.properties.speedMax = CGPointMake(0.f, 5.f);

    self.properties.gravity = CGPointMake(0.f, GRAVITY);
    
}

- (void)paused {
    self.properties.speed = CGPointMake(0.f, 0.f);
    self.properties.acceleration = CGPointMake(0.f, 0.f);
    self.properties.gravity = CGPointMake(0.f, 0.f);
}

- (void)drawStep {
    [super drawStep];

    self.properties.rotation += 10.0f * self.properties.acceleration.y;
    
    if(self.properties.rotation > 90.f) {
        self.properties.rotation = 90.f;
    } else if (self.properties.rotation < -20.f) {
        self.properties.rotation = -20.f;
    }

    self.imageView.transform =
    CGAffineTransformMakeRotation(DegreesToRadians(self.properties.rotation));
}

@end
