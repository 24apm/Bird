//
//  ViewController.h
//  Bird
//
//  Created by MacCoder on 2/5/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "BackgroundView.h"
#import "LadyBugView.h"

@interface ViewController : UIViewController <ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet BackgroundView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *obstacleLayer;
@property (weak, nonatomic) IBOutlet UIButton *tapButton;
@property (weak, nonatomic) IBOutlet LadyBugView *ladyBugView;

@property (nonatomic, retain) ADBannerView *adBannerView;

@end
