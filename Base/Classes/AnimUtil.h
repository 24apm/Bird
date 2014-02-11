//
//  AnimUtil.h
//  Fighting
//
//  Created by 15inch on 5/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimUtil : NSObject

+ (void)plop:(UIView*)view;
+ (void)blink:(UIView *)view;
+ (void)wobble:(UIView *)view duration:(float)duration angle:(CGFloat)angle;
+ (void)wobble:(UIView *)view duration:(float)duration angle:(CGFloat)angle repeatCount:(float)repeatCount;

@end
