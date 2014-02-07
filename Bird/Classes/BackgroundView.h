//
//  BackgroundView.h
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "XibView.h"

@interface BackgroundView : XibView

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

- (void)drawStep;

@end
