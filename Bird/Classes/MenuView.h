//
//  MenuView.h
//  Bird
//
//  Created by MacCoder on 2/11/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "XibView.h"

#define MENU_VIEW_DISMISSED_NOTIFICATION @"MENU_VIEW_DISMISSED_NOTIFICATION"
#define MENU_VIEW_GO_TO_MAIN_MENU_NOTIFICATION @"MENU_VIEW_GO_TO_MAIN_MENU_NOTIFICATION"

@interface MenuView : XibView

- (void)show;

@end
