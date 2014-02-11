//
//  SoundManagerBase.m
//  Bird
//
//  Created by MacCoder on 2/10/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "SoundManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import "SoundEffectHelper.h"
#import "SoundEffect.h"

@interface SoundManager()

@property (nonatomic, retain) NSMutableDictionary *soundEffects;

@end

@implementation SoundManager

+ (SoundManager *)instance {
    static SoundManager *instance = nil;
    if (!instance) {
        instance = [[SoundManager alloc] init];
        instance.soundEffects = [NSMutableDictionary dictionary];
    }
    return instance;
}

- (void)play:(NSString *)fileName {
    SoundEffectHelper *soundEffect = [self.soundEffects objectForKey:fileName];
    if (!soundEffect) {
        [self prepare:fileName];
    }
    [soundEffect play];
}

- (void)prepare:(NSString *)fileName {
    [self prepare:fileName count:1];
}

- (void)prepare:(NSString *)fileName count:(int)count {
    SoundEffectHelper *soundEffects = [self.soundEffects objectForKey:fileName];
    if (!soundEffects) {
        soundEffects = [[SoundEffectHelper alloc] initAVSoundNamed:fileName withCount:count];
        [self.soundEffects setObject:soundEffects forKey:fileName];
    }
}

@end
