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

@implementation SoundEffect {
    SystemSoundID soundID; 
}

+ (void)play:(NSString *)soundName {
    
    static SoundEffect *soundEffect;
    if(soundEffect == nil) {
      soundEffect = [[SoundEffect alloc] initWithAVSoundNamed:soundName];
    }
    [soundEffect play];
}

- (id)initWithAVSoundNamed:(NSString *)fileName {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"];
        self.theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        [self.theAudio prepareToPlay];
    }
    return self;
}

- (void)play {
    [self.theAudio play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"audioPlayerDidFinishPlaying");
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"audioPlayerDecodeErrorDidOccur");
}


@end
