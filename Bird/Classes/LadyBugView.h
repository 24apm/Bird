//
//  LadyBugView.h
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "XibView.h"
#import "WorldObjectProperties.h"

@interface LadyBugView : XibView

@property WorldObjectProperties *properties;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)drawStep;
- (void)paused;

@end
