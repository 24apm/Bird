//
//  SoundEffectHelper.m
//  Bird
//
//  Created by MacCoder on 2/10/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "SoundEffectHelper.h"
#import "SoundEffect.h"

@interface SoundEffectHelper()

@property (nonatomic, retain) NSArray *soundEffects;
@property (nonatomic) int index;

@end

@implementation SoundEffectHelper

- (id)initAVSoundNamed:(NSString *)fileName withCount:(int)count {
    self = [super init];
    if (self) {
        self.index = 0;
        NSMutableArray *t = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            [t addObject:[[SoundEffect alloc] initAVSoundNamed:fileName]];
        }
        self.soundEffects = t;
    }
    return self;
}

- (void)play {
    if (self.index >= self.soundEffects.count) {
        self.index = 0;
    }
    SoundEffect *soundEffect = [self.soundEffects objectAtIndex:self.index];
    [soundEffect play];
    self.index++;
}

@end
