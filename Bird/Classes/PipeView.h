//
//  PipView.h
//  Bird
//
//  Created by MacCoder on 2/7/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "WorldObjectView.h"

@interface PipeView : WorldObjectView

@property (weak, nonatomic) IBOutlet UIImageView *pipeTopView;
@property (weak, nonatomic) IBOutlet UIImageView *pipeDownView;


- (void)setupGapDistance:(float)gapDistance gapCenterY:(float)gapCenterY;

@end
