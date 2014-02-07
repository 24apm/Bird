//
//  XibView.m
//  WhatTheWord
//
//  Created by 15inch on 5/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "XibView.h"

@implementation XibView

@synthesize loaderView;

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self; 
}

- (void)setup {
    if(!loaderView) {
        loaderView = [[UIView alloc] initWithFrame:self.frame];
        [self addSubview:loaderView];
        
        NSString *nibName = NSStringFromClass([self class]);
        NSArray *nibObjects = nil;
        Class UINibClass = NSClassFromString(@"UINib");
        if (UINibClass && [UINibClass respondsToSelector:@selector(nibWithNibName:bundle:)]) {
            UINib *nib = [UINibClass nibWithNibName:nibName bundle:nil];
            nibObjects = [nib instantiateWithOwner:self options:nil];
        } else {
            nibObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        }
        
        UIView *xibView = [nibObjects objectAtIndex:0];
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = loaderView.autoresizingMask;
        loaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        loaderView.frame = xibView.frame;
        [loaderView addSubview:xibView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
