//
//  WorldObjectView.h
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "XibView.h"
#import "WorldObjectProperties.h"

@interface WorldObjectView : XibView

@property (strong, nonatomic) WorldObjectProperties *properties;

- (void)drawStep;

@end
