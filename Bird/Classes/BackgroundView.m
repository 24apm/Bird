//
//  BackgroundView.m
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "BackgroundView.h"

@interface BackgroundView()

@property (nonatomic) CGPoint speed;

@end

@implementation BackgroundView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [super setup];
    self.speed = CGPointMake(2.f, 2.f);
    self.backgroundImage.frame = CGRectMake(0.f,
                                0.f,
                                self.backgroundImage.frame.size.width,
                                self.backgroundImage.frame.size.height);
  
}

- (void)drawStep {
    CGRect backgroundFrame = self.backgroundImage.frame;
    backgroundFrame.origin.x -= self.speed.x;
    
    // background reaches endpoint and resets
    if (backgroundFrame.origin.x + backgroundFrame.size.width < self.frame.size.width) {
        backgroundFrame.origin.x = 0.f;
    }
    
    self.backgroundImage.frame = backgroundFrame;
}

@end
