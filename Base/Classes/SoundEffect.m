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

- (AVAudioPlayer *)createAVSoundNamed:(NSString *)fileName {
    NSString *fileExt = [fileName pathExtension];
	fileName = [fileName stringByDeletingPathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExt];
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audio prepareToPlay];
    return audio;
}

- (void)play:(NSString *)fileName {
    AVAudioPlayer *audio = nil;//[self.soundEffects objectForKey:fileName];
    if (!audio) {
        [self prepare:fileName];
        audio = [self.soundEffects objectForKey:fileName];
    }
    [audio play];
}

- (void)prepare:(NSString *)fileName {
    [self.soundEffects setObject:[[SoundEffect instance] createAVSoundNamed:fileName] forKey:fileName];
}

@end
