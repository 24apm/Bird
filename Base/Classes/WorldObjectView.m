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
    self.properties.accelerationMin = CGPointMake(-HUGE_VALF, -HUGE_VALF);
    self.properties.accelerationMax = CGPointMake(HUGE_VALF, HUGE_VALF);
    
    self.properties.speedMin = CGPointMake(-HUGE_VALF, -HUGE_VALF);
    self.properties.speedMax = CGPointMake(HUGE_VALF, HUGE_VALF);
}

- (void)drawStep {
    self.properties.acceleration = CGPointMake(self.properties.acceleration.x, self.properties.acceleration.y + self.properties.gravity.y);
    
    // Cap flying and falling to reduce acceleration crazyness
    if (self.properties.acceleration.y > self.properties.accelerationMax.y) {
        self.properties.acceleration = CGPointMake(self.properties.acceleration.x, self.properties.accelerationMax.y);
    } else if (self.properties.acceleration.y < self.properties.accelerationMin.y) {
        self.properties.acceleration = CGPointMake(self.properties.acceleration.x, self.properties.accelerationMin.y);
    }
    
    if (self.properties.acceleration.x > self.properties.accelerationMax.x) {
        self.properties.acceleration = CGPointMake(self.properties.accelerationMax.x, self.properties.acceleration.y);
    } else if (self.properties.acceleration.x < self.properties.accelerationMin.x) {
        self.properties.acceleration = CGPointMake(self.properties.accelerationMin.x, self.properties.acceleration.y);
    }
    
    self.properties.speed = CGPointMake(self.properties.speed.x + self.properties.acceleration.x, self.properties.speed.y + self.properties.acceleration.y);
    
    if (self.properties.speed.x > self.properties.speedMax.x) {
        self.properties.speed = CGPointMake(self.properties.speedMax.x, self.properties.speed.y);
    } else if (self.properties.speed.x < self.properties.speedMin.x) {
        self.properties.speed = CGPointMake(self.properties.speedMin.x, self.properties.speed.y);
    }
    
    if (self.properties.speed.y > self.properties.speedMax.y) {
        self.properties.speed = CGPointMake(self.properties.speed.x, self.properties.speedMax.y);
    } else if (self.properties.speed.y < self.properties.speedMin.y) {
        self.properties.speed = CGPointMake(self.properties.speed.x, self.properties.speedMin.y);
    }
    
    
   
  
    
    CGPoint center = self.center;
    CGFloat newX = center.x + self.properties.speed.x;
    CGFloat newY = center.y + self.properties.speed.y;
    self.center = CGPointMake(newX, newY);
    
}


@end
