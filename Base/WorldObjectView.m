//
//  WorldObjectView.m
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "WorldObjectView.h"
#import "Utils.h"

@implementation WorldObjectView

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
}

- (void)drawStep {
    self.properties.acceleration = CGPointMake(0.f, self.properties.acceleration.y + self.properties.gravity.y);
    
    // Cap flying and falling to reduce acceleration crazyness
    if (self.properties.acceleration.y > self.properties.accelerationMax.y) {
        self.properties.acceleration = CGPointMake(0.f, self.properties.accelerationMax.y);
    }
    
    if (self.properties.acceleration.y < self.properties.accelerationMin.y) {
        self.properties.acceleration = CGPointMake(0.f, self.properties.accelerationMin.y);
    }
    
    if (self.properties.speed.y > self.properties.speedMax.y) {
        self.properties.speed = CGPointMake(0.f, self.properties.speedMax.y);
    } else if (self.properties.speed.y < self.properties.speedMin.y) {
        self.properties.speed = CGPointMake(0.f, self.properties.speedMin.y);
    } else {
        self.properties.speed = CGPointMake(0.f, self.properties.speed.y + self.properties.acceleration.y);
    }
    
    CGPoint center = self.center;
    CGFloat newX = center.x + self.properties.speed.x;
    CGFloat newY = center.y + self.properties.speed.y;
    self.center = CGPointMake(newX, newY);
    
}


@end
