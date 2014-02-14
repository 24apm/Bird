//
//  FloorView.m
//  Bird
//
//  Created by MacCoder on 2/13/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "FloorView.h"
#import "GameConstants.h"

@interface FloorView()

@property (nonatomic) CGPoint speed;

@end

@implementation FloorView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [super setup];
    self.speed = CGPointMake(2.f * IPAD_SCALE, 0);
   }

- (void)drawStep {
    CGRect floorFrame = self.floorImage.frame;
    floorFrame.origin.x -= self.speed.x * IPAD_SCALE;
    
    // background reaches endpoint and resets
    if (floorFrame.origin.x + floorFrame.size.width < self.frame.size.width) {
        floorFrame.origin.x = 0.f;
    }
    
    self.floorImage.frame = floorFrame;
}
@end