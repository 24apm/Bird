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
#import "THLabel.h"
#import "MainView.h"
#import "GameCenterManager.h"
#import <GameKit/GameKit.h>
#import "FloorView.h"

typedef enum {
    GameStateMainMode,
    GameStateTutorialMode,
    GameStateGameMode,
    GameStateMenuMode,
    GameStateResumeMode,
    GameStateResultMode
} GameState;

@interface GameViewController : UIViewController <ADBannerViewDelegate, GKLeaderboardViewControllerDelegate, GameCenterManagerDelegate>

@property (weak, nonatomic) IBOutlet BackgroundView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *obstacleLayer;
@property (weak, nonatomic) IBOutlet UIButton *tapButton;
@property (strong, nonatomic) IBOutlet LadyBugView *ladyBugView;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet THLabel *scoreLabel;
@property (strong, nonatomic) IBOutlet THLabel *maxScoreLabel;
@property (strong, nonatomic) IBOutlet THLabel *highestScoreText;

@property (strong, nonatomic) IBOutlet UIView *flashOverlay;;
@property (nonatomic) GameState currentGameState;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet FloorView *floorView;

@property (nonatomic, retain) ADBannerView *adBannerView;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property (nonatomic, retain) NSString* currentLeaderBoard;

@end
