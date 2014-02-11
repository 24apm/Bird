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

@property (nonatomic, retain) AVAudioPlayer *audio;

@end

@implementation SoundEffect

- (id)initAVSoundNamed:(NSString *)fileName {
    self = [super init];
    if (self) {
        NSString *fileExt = [fileName pathExtension];
        if (!fileExt || fileExt.length <= 0) {
            fileExt = @"caf";
        }
        fileName = [fileName stringByDeletingPathExtension];
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExt];
        self.audio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        [self.audio prepareToPlay];
    }
    return self;
}

- (void)play {
    [self.audio play];
}

@end
