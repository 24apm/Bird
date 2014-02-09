//
//  LadyBugView.h
//  Bird
//
//  Created by MacCoder on 2/6/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "XibView.h"
#import "WorldObjectView.h"

typedef enum {
    LadyBugViewStateTutorialMode,
    LadyBugViewStateGameMode
} LadyBugViewState;

@interface LadyBugView : WorldObjectView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) LadyBugViewState currentState;
@property (nonatomic) CGPoint startingPoint;

- (void)drawStep;
- (void)paused;
- (void)resume;
- (void)refresh;

@end
