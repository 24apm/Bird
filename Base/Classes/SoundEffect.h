//
//  SoundEffect.h
//  Fighting
//
//  Created by MacCoder on 6/1/13.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundEffect : NSObject

+ (SoundEffect *)instance;
- (AVAudioPlayer *)createAVSoundNamed:(NSString *)fileName;
- (void)play:(NSString *)fileName;
- (void)prepare:(NSString *)fileName;
- (void)play;

@end
