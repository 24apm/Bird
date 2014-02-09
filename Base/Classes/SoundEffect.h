//
//  SoundEffect.h
//  Fighting
//
//  Created by MacCoder on 6/1/13.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundEffect : NSObject <AVAudioPlayerDelegate>

+ (void)play:(NSString *)fileName;



@property (nonatomic, strong) AVAudioPlayer* theAudio;

- (id)initWithAVSoundNamed:(NSString *)fileName;
- (void)play;

@end
