//
//  SoundManagerBase.h
//  Bird
//
//  Created by MacCoder on 2/10/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundManager : NSObject

+ (SoundManager *)instance;
- (void)play:(NSString *)fileName;
- (void)prepare:(NSString *)fileName count:(int)count;

@end
