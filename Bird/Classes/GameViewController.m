//
//  ViewController.m
//  Bird
//
//  Created by MacCoder on 2/5/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "GameViewController.h"
#import "GameLoopTimer.h"
#import "GameConstants.h"
#import "PipeView.h"
#import "Utils.h"
#import "UIView+ViewUtil.h"
#import "AnimUtil.h"
#import "ResultView.h"
#import "MainView.h"
#import "TutorialView.h"
#import "SoundEffect.h"
#import "SoundManager.h"
#import "MenuView.h"

#define SOUND_EFFECT_BUMP @"bumpEffect"
#define SOUND_EFFECT_BOUNCE @"bounceEffect"

@interface GameViewController ()

@property (strong, nonatomic) NSMutableArray *worldObstacles;
@property (strong, nonatomic) NSMutableArray *scorableObjects;

@property (nonatomic) BOOL isGameOver;
@property (nonatomic) BOOL isRunning;

@property (nonatomic) int score;
@property (nonatomic) PipeView *lastGeneratedPipe;

@property (nonatomic) int maxScore;
@property (nonatomic) BOOL firstTapped;
@property (strong, nonatomic) TutorialView *tutorialView;
@property (strong, nonatomic) ResultView *resultView;
@property (strong, nonatomic) MainView *mainView;
@property (strong, nonatomic) MenuView *menuView;

@end

@implementation GameViewController

- (void)initialize {
    [[GameLoopTimer instance] initialize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawStep) name:DRAW_STEP_NOTIFICATION object:nil];
    self.currentGameState = -1;
    self.worldObstacles = [NSMutableArray array];
    self.scorableObjects = [NSMutableArray array];
    self.score = 0;
    self.maxScore = 0;
    self.isRunning = YES;
    self.lastGeneratedPipe = nil;
    _isGameOver = YES;
    [self loadUserData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainMenuCallback) name:RESULT_VIEW_DISMISSED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tutorialCallback) name:MAIN_VIEW_DISMISSED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeCallback) name:MENU_VIEW_DISMISSED_NOTIFICATION object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainMenuCallback) name:MENU_VIEW_GO_TO_MAIN_MENU_NOTIFICATION object:nil];

    [self createObstacle];
    
    self.tutorialView = [[TutorialView alloc] init];
    [self.containerView addSubview:self.tutorialView];
    self.tutorialView.hidden = YES;
    self.tutorialView.size = self.containerView.size;
    
    self.resultView = [[ResultView alloc] init];
    [self.containerView addSubview:self.resultView];
    self.resultView.hidden = YES;
    self.resultView.size = self.containerView.size;
    self.resultView.vc = self;
    self.resultView.sharedImage = [UIImage imageNamed:@"man.png"];
    
    self.mainView = [[MainView alloc] init];
    [self.containerView addSubview:self.mainView];
    self.mainView.hidden = YES;
    self.mainView.size = self.containerView.size;
    
    self.menuView = [[MenuView alloc] init];
    [self.containerView addSubview:self.menuView];
    self.menuView.hidden = YES;
    self.menuView.size = self.containerView.size;
    
    if (BLACK_AND_WHITE_MODE) {
        [self blackAndWhite];
    }
    [self preloadSounds];
    [self updateGameState:GameStateMainMode];
}

- (void)preloadSounds {
    [[SoundManager instance] prepare:SOUND_EFFECT_BUMP count:1];
    [[SoundManager instance] prepare:SOUND_EFFECT_BOUNCE count:5];
}

- (void)gameViewsHidden:(BOOL)hidden {
    self.ladyBugView.hidden = hidden;
    self.obstacleLayer.hidden = hidden;
    self.scoreLabel.hidden = hidden;
    self.menuButton.hidden = hidden;
}

- (void)saveUserData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:@(self.maxScore) forKey:@"maxScore"];
    [defaults synchronize];
}

- (IBAction)menuPressed:(id)sender {
    [self updateGameState:GameStateMenuMode];
}

- (void)loadUserData {
    self.maxScore = [[[NSUserDefaults standardUserDefaults] valueForKey:@"maxScore"] intValue];
}

- (void)mainMenuCallback {
    [self updateGameState:GameStateMainMode];
}

- (void)tutorialCallback {
    [self updateGameState:GameStateTutorialMode];
}

- (void)resumeCallback {
    [self updateGameState:GameStateResumeMode];
}

- (void)refresh {
    [self gameViewsHidden:YES];
    self.containerView.hidden = NO;
    self.containerView.userInteractionEnabled = YES;
    self.mainView.hidden = YES;
    self.tutorialView.hidden = YES;
    self.resultView.hidden = YES;
    self.menuView.hidden = YES;
    self.menuButton.hidden = YES;
    
    switch (self.currentGameState) {
        case GameStateMainMode:
            self.isRunning = YES;
            self.mainView.hidden = NO;
            [self.mainView show];
            break;
        case GameStateTutorialMode:
            [self gameViewsHidden:NO];
            self.containerView.userInteractionEnabled = NO;
            self.tutorialView.hidden = NO;
            [self restartGame];
            self.ladyBugView.currentState = LadyBugViewStateTutorialMode;
            [self.ladyBugView refresh];
            break;
        case GameStateGameMode:
            self.containerView.hidden = YES;
            [self gameViewsHidden:NO];
            self.ladyBugView.currentState = LadyBugViewStateGameMode;
            [self.ladyBugView refresh];
            break;
        case GameStateMenuMode:
            self.isRunning = NO;
            [self gameViewsHidden:NO];
            self.menuView.hidden = NO;
            [self.menuView show];
            break;
        case GameStateResumeMode:
            [self gameViewsHidden:NO];
            self.containerView.userInteractionEnabled = NO;
            self.isRunning = YES;
            break;
        case GameStateResultMode:
            self.resultView.hidden = NO;
            [self gameViewsHidden:NO];
            self.scoreLabel.hidden = YES;
            self.menuButton.hidden = YES;
            self.resultView.sharedText = [NSString stringWithFormat:@"High Score: %d!", self.maxScore];
            [self showResult];
            break;
        default:
            break;
    }
}

- (void)updateGameState:(GameState)gameState {
    if (self.currentGameState != gameState) {
        self.currentGameState = gameState;
        [self refresh];
    }
}

- (IBAction)tapButtonPressed:(id)sender {
    if (self.isGameOver == YES) return;
    
    self.firstTapped = YES;
    [self.ladyBugView resume];
    self.ladyBugView.properties.speed = CGPointMake(0.f, TAP_SPEED_INCREASE * IPAD_SCALE);
    
    self.ladyBugView.properties.acceleration = CGPointMake(self.ladyBugView.properties.acceleration.x, self.ladyBugView.properties.acceleration.y + TAP_ACCELATION_INCREASE);
    
    self.ladyBugView.properties.rotation = 0.f;
    
    if (self.ladyBugView.frame.origin.y < 0.f) {
        self.ladyBugView.properties.speed = CGPointMake(0.f, 0);
        
        self.ladyBugView.properties.acceleration = CGPointMake(self.ladyBugView.properties.acceleration.x, 0);
    }
    [[SoundManager instance] play:SOUND_EFFECT_BOUNCE];
}

- (void)createObstacle {
    PipeView *pipeView;
    for (int i = 0; i < PIPES_COUNT; i++) {
        pipeView = [[PipeView alloc] init];
        
        if (BLACK_AND_WHITE_MODE) {
            pipeView.pipeTopView.image = nil;
            pipeView.pipeTopView.backgroundColor = [UIColor blackColor];
            pipeView.pipeDownView.image = nil;
            pipeView.pipeDownView.backgroundColor = [UIColor blackColor];
        }
        
        [self.worldObstacles addObject:pipeView];
        [self.obstacleLayer addSubview:pipeView];
    }
    [self resetPipes];
}

- (void)blackAndWhite {
    self.backgroundView.backgroundImage.image = nil;
    self.backgroundView.backgroundImage.backgroundColor = [UIColor whiteColor];
    
    self.ladyBugView.imageView.image = nil;
    self.ladyBugView.imageView.backgroundColor = [UIColor blackColor];
}

- (void)resetPipe:(PipeView *)pipeView {
    float randomY = [Utils randBetweenMin:self.view.frame.size.height * 0.3f max:self.view.frame.size.height * 0.7f];
    [pipeView setupGapDistance:self.ladyBugView.frame.size.height * OBSTACLE_GAP_BY_CHARACTER_MULTIPLIER gapCenterY:randomY];
    [self.scorableObjects addObject:pipeView];
    if (self.lastGeneratedPipe) {
        pipeView.x = self.lastGeneratedPipe.x + self.view.width * OBSTACLE_GAP_BY_SCREEN_WIDTH_PERCENTAGE;
    } else {
        pipeView.x = self.view.width * 1.5f;
    }
    self.lastGeneratedPipe = pipeView;
}

- (void)resetPipes {
    for (PipeView *pipeView in self.worldObstacles) {
        // off map
        [self resetPipe:pipeView];
    }
}

- (void)restartGame {
    self.isRunning = YES;
    self.isGameOver = NO;
    [self.scorableObjects removeAllObjects];
    [self.ladyBugView resume];
    self.ladyBugView.center = CGPointMake(self.ladyBugView.center.x, self.view.center.y) ;
    self.ladyBugView.startingPoint = self.ladyBugView.center;
    self.score = 0;
    self.firstTapped = NO;
    self.lastGeneratedPipe = nil;
    [self resetPipes];
    [self refreshLabel];
}

- (void)setFirstTapped:(BOOL)firstTapped {
    _firstTapped = firstTapped;
    if (firstTapped) {
        [self updateGameState:GameStateGameMode];
    }
}

- (IBAction)rematchPressed:(id)sender {
    [self restartGame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
    [self.mainView show];
    
    [self createAdBannerView];
    [self.view addSubview:self.adBannerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)boundaryTestForLadyBug {
    
    if ((self.ladyBugView.frame.origin.y + self.ladyBugView.frame.size.height) > self.view.frame.size.height) {
        self.ladyBugView.frame = CGRectMake(self.ladyBugView.frame.origin.x, (self.self.view.frame.size.height - self.ladyBugView.frame.size.height), self.ladyBugView.frame.size.width, self.ladyBugView.frame.size.height);
        self.ladyBugView.properties.rotation = 90.f;
        [self.ladyBugView paused];
        self.isGameOver = YES;
    }
}

- (void)boundaryTestForPipes {
    if (self.isGameOver) return;

    for (PipeView *pipeView in self.worldObstacles) {
        // off map
        if (pipeView.center.x < -pipeView.frame.size.width) {
            [self resetPipe:pipeView];
        }
    }
}

- (void)collisionDetection {
    if (self.isGameOver) return;
    
    for (PipeView *pipe in self.worldObstacles) {
        
        CGRect topFrame = [pipe.pipeTopView.superview convertRect:pipe.pipeTopView.frame toView:self.ladyBugView.superview];
        CGRect bottomFrame = [pipe.pipeDownView.superview convertRect:pipe.pipeDownView.frame toView:self.ladyBugView.superview];
        
        if (CGRectIntersectsRect(self.ladyBugView.frame, topFrame)) {
            self.isGameOver = YES;
        } else if (CGRectIntersectsRect(self.ladyBugView.frame, bottomFrame)) {
            self.isGameOver = YES;
        }
    }
}

- (void)showResult {
    int tMaxScore = self.maxScore;
    if (self.score > self.maxScore) {
        self.maxScore = self.score;
        [self saveUserData];
    } else {
        self.resultView.recordLabel.hidden = YES;
    }
    self.resultView.currentScoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
    self.resultView.maxScoreLabel.text = [NSString stringWithFormat:@"%d", tMaxScore];
    self.resultView.lastMaxScore = tMaxScore;
    self.resultView.maxScore = self.maxScore;
    [self.resultView show];
}


- (void)animateCollision {
    float duration = 0.2f;
    self.flashOverlay.alpha = 0.f;
    [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.flashOverlay.alpha = 1.0f;
    } completion:^(BOOL completed){
        [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionLayoutSubviews animations:^{
        } completion:^(BOOL completed){
            self.flashOverlay.alpha = 0.0f;
        } ];
    } ];
    
    [AnimUtil wobble:self.view duration:0.1f angle:M_PI/128.f];
    
    [[SoundManager instance] play:SOUND_EFFECT_BUMP];
}

- (void)checkIfScored {
    if (self.isGameOver) return;
    if (self.scorableObjects.count <= 0) return;
    
    NSMutableArray *scorableObjectsTemp = [NSMutableArray array];
    for (PipeView *pipeView in self.scorableObjects) {
        // passed ladybug
        CGRect pipeFrame = [pipeView.superview convertRect:pipeView.frame toView:self.ladyBugView.superview];
        if (self.ladyBugView.center.x > pipeFrame.origin.x + pipeView.frame.size.width) {
            self.score++;
            [self refreshLabel];
        } else {
            [scorableObjectsTemp addObject:pipeView];
        }
    }
    self.scorableObjects = scorableObjectsTemp;
}

- (void)refreshLabel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
}

- (void)stopObstacles {
    for (PipeView *pipeView in self.worldObstacles) {
        pipeView.properties.speed = CGPointMake(0.f, 0.f);
    }
}

- (void)resumeObstacles {
    for (PipeView *pipeView in self.worldObstacles) {
        pipeView.properties.speed = CGPointMake(OBSTACLE_SPEED * IPAD_SCALE, 0.f);
    }
}

- (void)drawStep {
    if (!self.isRunning) return;
    
    [self.backgroundView drawStep];
    
    if (self.currentGameState == GameStateTutorialMode || self.currentGameState == GameStateGameMode || self.currentGameState == GameStateResultMode || self.currentGameState == GameStateResumeMode) {
        if (self.firstTapped) {
            for (PipeView *pipeView in self.worldObstacles) {
                [pipeView drawStep];
            }
            [self boundaryTestForPipes];
            [self collisionDetection];
            [self boundaryTestForLadyBug];
            [self checkIfScored];
        }
        [self.ladyBugView drawStep];
    }
}

- (void)setIsGameOver:(BOOL)isGameOver {
    if (self.isGameOver == isGameOver) return;
    if (DEBUG_MODE) {
        isGameOver = NO;
    }
    
    _isGameOver = isGameOver;
    if (isGameOver) {
        [self animateCollision];
        [self stopObstacles];
        [self updateGameState:GameStateResultMode];
    } else {
        [self resumeObstacles];
    }
}

#pragma mark - ADs

- (void) createAdBannerView
{
//    self.adBannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
//    CGSize bannerSize = [ADBannerView sizeFromBannerContentSizeIdentifier:self.adBannerView.currentContentSizeIdentifier];
//
//    CGRect bannerFrame = self.adBannerView.frame;
//    bannerFrame.origin.y = -bannerSize.height;
//    self.adBannerView.frame = bannerFrame;
//    
//    self.adBannerView.delegate = self;
//    self.adBannerView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
    
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        self.adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    } else {
        self.adBannerView = [[ADBannerView alloc] init];
    }
    self.adBannerView.delegate = self;
}

- (void)layoutAnimated:(BOOL)animated
{
    // As of iOS 6.0, the banner will automatically resize itself based on its width.
    // To support iOS 5.0 however, we continue to set the currentContentSizeIdentifier appropriately.
    CGRect contentFrame = self.view.bounds;
    if (contentFrame.size.width < contentFrame.size.height) {
        self.adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    } else {
        self.adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    }
    
    CGRect bannerFrame = self.adBannerView.frame;
    if (self.adBannerView.bannerLoaded) {
        contentFrame.size.height -= self.adBannerView.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        self.view.frame = contentFrame;
        [self.view layoutIfNeeded];
        self.adBannerView.frame = bannerFrame;
    }];
}

#pragma mark - ADBannerViewDelegate

- (void)viewDidLayoutSubviews
{
    [self layoutAnimated:[UIView areAnimationsEnabled]];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self layoutAnimated:YES];
}


@end
