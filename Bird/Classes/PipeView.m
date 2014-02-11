//
//  PipView.m
//  Bird
//
//  Created by MacCoder on 2/7/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "PipeView.h"
#import "GameConstants.h"

@interface PipeView()

@property (nonatomic) float gapDistance;
@property (nonatomic) float gapCenterY;

@end

@implementation PipeView

- (void)setup {
    [super setup];
    self.properties.speedMin = CGPointMake(OBSTACLE_SPEED * IPAD_SCALE, 0.f);
    self.properties.speedMax = CGPointMake(0.f, 0.f);
    self.properties.speed = CGPointMake(OBSTACLE_SPEED * IPAD_SCALE, 0.f);
}

- (void)setupGapDistance:(float)gapDistance gapCenterY:(float)gapCenterY {
    self.pipeTopView.center = CGPointMake(self.pipeTopView.center.x,
                                          gapCenterY - gapDistance/2.f - self.pipeTopView.frame.size.height/2.f);
    
    self.pipeDownView.center = CGPointMake(self.pipeDownView.center.x,
                                          gapCenterY + gapDistance/2.f + self.pipeDownView.frame.size.height/2.f);
}

@end
