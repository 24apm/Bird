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
#import "ResultView.h"
#import "FXLabel.h"
#import "MenuView.h"

typedef enum {
    GameStateMenuMode,
    GameStateTutorialMode,
    GameStateGameMode,
    GameStateResultMode
} GameState;

@interface GameViewController : UIViewController <ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet BackgroundView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *obstacleLayer;
@property (weak, nonatomic) IBOutlet UIButton *tapButton;
@property (strong, nonatomic) IBOutlet LadyBugView *ladyBugView;
@property (weak, nonatomic) IBOutlet FXLabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIView *flashOverlay;
@property (strong, nonatomic) IBOutlet ResultView *resultView;
@property (strong, nonatomic) IBOutlet MenuView *menuView;
@property (nonatomic) GameState currentGameState;

@property (nonatomic, retain) ADBannerView *adBannerView;

@end
