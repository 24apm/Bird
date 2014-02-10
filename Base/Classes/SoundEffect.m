//
//  SoundEffect.m
//  Fighting
//
//  Created by MacCoder on 6/1/13.
//
//

#import "SoundEffect.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundEffect()

@property (nonatomic, retain) NSMutableDictionary *soundEffects;

@end

@implementation SoundEffect

+ (SoundEffect *)instance {
    static SoundEffect *instance = nil;
    if (!instance) {
        instance = [[SoundEffect alloc] init];
        instance.soundEffects = [NSMutableDictionary dictionary];
    }
    return instance;
}

- (id)initWithAVSoundNamed:(NSString *)fileName {
    NSString *fileExt = [fileName pathExtension];
	fileName = [fileName stringByDeletingPathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExt];
    if (self = [self initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL]) {
        [self prepareToPlay];
    }
    return self;
}

- (void)play:(NSString *)fileName {
    SoundEffect *soundEffect = nil;//[self.soundEffects objectForKey:fileName];
    if (!soundEffect) {
        [self prepare:fileName];
        soundEffect = [self.soundEffects objectForKey:fileName];
    }
    [soundEffect play];
}

- (void)prepare:(NSString *)fileName {
    [self.soundEffects setObject:[[SoundEffect instance] initWithAVSoundNamed:fileName] forKey:fileName];
}

@end
