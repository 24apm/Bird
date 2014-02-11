//
//  MenuView.h
//  Bird
//
//  Created by MacCoder on 2/8/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "XibView.h"

@interface MainView : XibView

#define MAIN_VIEW_DISMISSED_NOTIFICATION @"MAIN_VIEW_DISMISSED_NOTIFICATION"

@property (strong, nonatomic) IBOutlet UIView *titleView;

- (void)show;

@end
