//
//  ResultView.h
//  Bird
//
//  Created by MacCoder on 2/8/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "XibView.h"

#define RESULT_VIEW_DISMISSED_NOTIFICATION @"RESULT_VIEW_DISMISSED_NOTIFICATION"

@interface ResultView : XibView

@property (weak, nonatomic) IBOutlet UILabel *currentScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxScoreLabel;
@property (strong, nonatomic) UIViewController *vc;
@property (strong, nonatomic) NSString *sharedText;
@property (strong, nonatomic) UIImage *sharedImage;

- (void)show;

@end
