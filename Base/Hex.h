//
//  Hex.h
//  Guessing
//
//  Created by MacCoder on 7/7/13.
//  Copyright (c) 2013 MacCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hex : NSObject


@end

@interface UIColor (Hex)

- (NSUInteger)colorCode;

@end

@implementation UIColor (Hex)

- (NSUInteger)colorCode
{
    float red, green, blue;
    if ([self getRed:&red green:&green blue:&blue alpha:NULL])
    {
        NSUInteger redInt = (NSUInteger)(red * 255 + 0.5);
        NSUInteger greenInt = (NSUInteger)(green * 255 + 0.5);
        NSUInteger blueInt = (NSUInteger)(blue * 255 + 0.5);
        
        return (redInt << 16) | (greenInt << 8) | blueInt;
    }
    
    return 0;
}

@end
