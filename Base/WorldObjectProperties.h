//
//  WorldObjectProperties.h
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorldObjectProperties : NSObject

@property (nonatomic) CGPoint speed;
@property (nonatomic) CGPoint acceleration;
@property (nonatomic) CGPoint gravity;
@property (nonatomic) CGFloat rotation;

@end
