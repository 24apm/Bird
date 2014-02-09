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
    self.currentState = LadyBugViewStateTutorialMode;
    [self refresh];
}

- (void)refresh {
    switch (self.currentState) {
        case LadyBugViewStateTutorialMode:
            self.properties.rotation = 0.f;
            self.properties.acceleration = CGPointMake(0.f, 0.f);
            self.properties.accelerationMin = CGPointMake(0.f, 0.00f);
            self.properties.accelerationMax = CGPointMake(0.f, 0.00);
            
            self.properties.speed = CGPointMake(0.f, 2.f);
            self.properties.speedMin = CGPointMake(0.f, -3.f);
            self.properties.speedMax = CGPointMake(0.f, 3.f);
            
            self.properties.gravity = CGPointMake(0.f, 0.f);
            
            break;
        case LadyBugViewStateGameMode:
            self.properties.rotation = 0.f;
            self.properties.acceleration = CGPointMake(0.f, 0.f);
            self.properties.accelerationMin = CGPointMake(0.f, 0.00f);
            self.properties.accelerationMax = CGPointMake(0.f, 1.50f);
            
            self.properties.speed = CGPointMake(0.f, 2.f);
            self.properties.speedMin = CGPointMake(0.f, TAP_SPEED_INCREASE);
            self.properties.speedMax = CGPointMake(0.f, 14.f);
            
            self.properties.gravity = CGPointMake(0.f, GRAVITY);
            
            break;
        default:
            break;
    }
    self.imageView.transform =
    CGAffineTransformMakeRotation(DegreesToRadians(0.f));

}

- (void)paused {
    self.properties.speed = CGPointMake(0.f, 0.f);
    self.properties.acceleration = CGPointMake(0.f, 0.f);
    self.properties.gravity = CGPointMake(0.f, 0.f);
}

- (void)resume {
    self.properties.speed = CGPointMake(0.f, 2.f);
    self.properties.acceleration = CGPointMake(0.f, 0.f);
    self.properties.gravity = CGPointMake(0.f, GRAVITY);
}

- (void)drawGameStep {
    if(self.properties.speed.y < 0) {
        self.properties.rotation = -20;
    } else if (self.properties.speed.y > 0){
        self.properties.rotation = -20 + (110.f * self.properties.speed.y/self.properties.speedMax.y);
    } else {
        self.properties.rotation = 90.f;
        
    }
    
    // capped
    if(self.properties.rotation > 90.f) {
        self.properties.rotation = 90.f;
    } else if (self.properties.rotation < -20.f) {
        self.properties.rotation = -20.f;
    }
    
    self.imageView.transform =
    CGAffineTransformMakeRotation(DegreesToRadians(self.properties.rotation));
}

- (void)drawTutorialStep {
    if (self.center.y > self.startingPoint.y + self.height/2.f) {
        self.properties.speed = CGPointMake(0.f, -5.f);
    } else if (self.center.y < self.startingPoint.y - self.height/2.f) {
        self.properties.speed = CGPointMake(0.f, 5.f);
    }
}

- (void)drawStep {
    [super drawStep];
    switch (self.currentState) {
        case LadyBugViewStateTutorialMode:
            [self drawTutorialStep];
            break;
        case LadyBugViewStateGameMode:
            [self drawGameStep];
            break;
        default:
            break;
    }

}

@end
