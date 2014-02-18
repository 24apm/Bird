//
//  MenuView.h
//  Bird
//
//  Created by MacCoder on 2/8/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "XibView.h"
#import "LadyBugView.h"

@interface MainView : XibView

#define MAIN_VIEW_DISMISSED_NOTIFICATION @"MAIN_VIEW_DISMISSED_NOTIFICATION"
#define SHOW_LEADERBOARD_NOTIFICATION @"SHOW_LEADERBOARD_NOTIFICATION"

@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet LadyBugView *ladyBugView;

- (void)show;

@end
