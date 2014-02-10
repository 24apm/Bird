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
@property (nonatomic, retain) AVAudioPlayer *audio;

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
    self.audio = [self createAVSoundNamed:fileName];
    if (self.audio) {
        [self.audio play];
    }
}

- (void)prepare:(NSString *)fileName {
    [self createAVSoundNamed:fileName];
}

@end
