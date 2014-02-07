//
//  Utils.m
//  Fighting
//
//  Created by 15inch on 5/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (CGSize)screenSize {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UIInterfaceOrientation currentOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    
    if (currentOrientation != UIInterfaceOrientationPortrait){
        screenSize.width = [[UIScreen mainScreen] bounds].size.height;
        screenSize.height = [[UIScreen mainScreen] bounds].size.width;
    }
    return screenSize;
}


@end
