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
    self.properties = [[WorldObjectProperties alloc] init];
    self.properties.rotation = 0.f;
    self.properties.speed = CGPointMake(0.f, 2.f);
    self.properties.acceleration = CGPointMake(0.f, 0.f);
    self.properties.gravity = CGPointMake(0.f, GRAVITY);
}

- (void)paused {
    self.properties.speed = CGPointMake(0.f, 0.f);
    self.properties.acceleration = CGPointMake(0.f, 0.f);
    self.properties.gravity = CGPointMake(0.f, 0.f);
}

- (void)drawStep {
    CGPoint center = self.center;
    CGFloat newX = center.x + self.properties.speed.x;
    CGFloat newY = center.y + self.properties.speed.y;
    self.center = CGPointMake(newX, newY);
    
    self.properties.acceleration = CGPointMake(0.f, self.properties.acceleration.y + self.properties.gravity.y);
    
    // Cap flying and falling to reduce acceleration crazyness
    if (self.properties.acceleration.y > MAX_ACCELATION_DOWN) {
        self.properties.acceleration = CGPointMake(0.f, MAX_ACCELATION_DOWN);
    }
    
    if (self.properties.acceleration.y < MAX_ACCELATION_UP) {
        self.properties.acceleration = CGPointMake(0.f, -MAX_ACCELATION_UP);
    }
    
    self.properties.speed = CGPointMake(0.f, self.properties.speed.y + self.properties.acceleration.y);
    if (self.properties.speed.y > 0.f) {
        self.properties.rotation += 10.0f * self.properties.acceleration.y;
    }
    if(self.properties.rotation > 90.f) {
        self.properties.rotation = 90.f;
    } else if (self.properties.rotation < 0.f) {
        self.properties.rotation = 0.f;
    }
    
    self.imageView.transform =
    CGAffineTransformMakeRotation(DegreesToRadians(self.properties.rotation));

}

@end
