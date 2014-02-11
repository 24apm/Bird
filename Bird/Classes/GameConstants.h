//
//  GameConstants.h
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IPAD_SCALE ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 2.2f : 1.0f)

#define GRAVITY 0.2f
#define TAP_ACCELATION_INCREASE 0.0f
#define TAP_SPEED_INCREASE -12.0f

#define OBSTACLE_SPEED -5.0f
#define OBSTACLE_GAP_BY_SCREEN_WIDTH_PERCENTAGE 0.75
#define OBSTACLE_GAP_BY_CHARACTER_MULTIPLIER 4.f

#define PIPES_COUNT 5
#define DEBUG_MODE NO
#define BLACK_AND_WHITE_MODE NO

@interface GameConstants : NSObject

@end
