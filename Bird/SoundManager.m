//
//  SoundManager.m
//  Bird
//
//  Created by MacCoder on 2/10/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "SoundManager.h"
#import "SoundEffect.h"

@interface SoundManager()

@property (strong, nonatomic) SoundEffect *crashSound;
@property (strong, nonatomic) NSMutableArray *tapSounds;
@property (nonatomic) int tapSoundIndex;

@end

@implementation SoundManager

+ (SoundManager *)instance {
    static SoundManager *instance = nil;
    if (!instance) {
        instance = [[SoundManager alloc] init];
    }
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)preloadSoundEffects {
    [[SoundEffect instance] prepare:@"bounceEffect.caf"];
    [[SoundEffect instance] prepare:@"bumpEffect.caf"];
    
    self.crashSound = [[SoundEffect alloc] init];
    [self.crashSound prepare:@"bumpEffect.caf"];
    
    self.tapSounds = [NSMutableArray array];
    SoundEffect *tapEffect;
    for (int i = 0; i < 5; i++) {
        tapEffect = [[SoundEffect alloc] init];
        [tapEffect prepare:@"bounceEffect.caf"];
        [self.tapSounds addObject:tapEffect];
    }
}

- (void)playCrashSound {
    [self.crashSound play];
}

- (void)playTapSound {
    if (self.tapSoundIndex >= self.tapSounds.count) {
        self.tapSoundIndex = 0;
    }
    SoundEffect *soundEffect = [self.tapSounds objectAtIndex:self.tapSoundIndex];
    [soundEffect play];
    self.tapSoundIndex++;
}


@end
