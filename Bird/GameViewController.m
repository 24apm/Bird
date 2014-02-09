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

@interface GameViewController ()

@property (strong, nonatomic) NSMutableArray *worldObstacles;
@property (strong, nonatomic) NSMutableArray *scorableObjects;

@property (nonatomic) BOOL isGameOver;
@property (nonatomic) int score;
@property (nonatomic) int maxScore;

@end

@implementation GameViewController

- (void)initialize {
    [[GameLoopTimer instance] initialize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawStep) name:DRAW_STEP_NOTIFICATION object:nil];
    self.worldObstacles = [NSMutableArray array];
    self.scorableObjects = [NSMutableArray array];
    self.score = 0;
    self.maxScore = 0;
    self.isGameOver = NO;
    [self loadUserData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultViewDissed) name:RESULT_VIEW_DISMISSED_NOTIFICATION object:nil];
    [self createObstacle];
}


- (void)saveUserData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:@(self.maxScore) forKey:@"maxScore"];
    [defaults synchronize];
}

- (void)loadUserData {
    self.maxScore = [[[NSUserDefaults standardUserDefaults] valueForKey:@"maxScore"] intValue];
}

- (void)resultViewDissed {
    [self restartGame];
}

- (IBAction)tapButtonPressed:(id)sender {
    if (self.isGameOver == YES) return;
    
    
    [self.ladyBugView resume];
    self.ladyBugView.properties.speed = CGPointMake(0.f, TAP_SPEED_INCREASE);
    
    self.ladyBugView.properties.acceleration = CGPointMake(self.ladyBugView.properties.acceleration.x, self.ladyBugView.properties.acceleration.y + TAP_ACCELATION_INCREASE);
    
    self.ladyBugView.properties.rotation = 0.f;
    
    if (self.ladyBugView.frame.origin.y < 0.f) {
        self.ladyBugView.properties.speed = CGPointMake(0.f, 0);
        
        self.ladyBugView.properties.acceleration = CGPointMake(self.ladyBugView.properties.acceleration.x, 0);
        
    }

}

- (void)createObstacle {
    PipeView *pipeView;
    for (int i = 0; i < 1; i++) {
        pipeView = [[PipeView alloc] init];
        [self.worldObstacles addObject:pipeView];
        [self.obstacleLayer addSubview:pipeView];

    }
    [self resetPipes];
}

- (void)resetPipe:(PipeView *)pipeView {
    float randomY = [Utils randBetweenMin:self.view.frame.size.height * 0.3f max:self.view.frame.size.height * 0.7f];
    [pipeView setupGapDistance:self.ladyBugView.frame.size.height * 4.f gapCenterY:randomY];
    [self.scorableObjects addObject:pipeView];
}

- (void)resetPipes {
    int i = 1.f;
    for (PipeView *pipeView in self.worldObstacles) {
        // off map
        [self resetPipe:pipeView];
        pipeView.center = CGPointMake(self.view.frame.size.width * i * 1.5f, pipeView.center.y);
        
        i++;
    }
}

- (void)restartGame {
    self.isGameOver = NO;
    [self.scorableObjects removeAllObjects];
    [self resetPipes];
    [self.ladyBugView resume];
    self.ladyBugView.center = CGPointMake(self.ladyBugView.center.x, self.view.center.y) ;
    self.score = 0;
    [self refreshLabel];
}

- (IBAction)rematchPressed:(id)sender {
    [self restartGame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
    
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
            pipeView.center = CGPointMake(self.view.frame.size.width + pipeView.frame.size.width, pipeView.center.y);
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
    [UIView animateWithDuration:0.3f
                          delay:0.3f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
        self.resultView.y = 0.f;
    } completion:^(BOOL complete) {
    }];
    
    self.resultView.currentScoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
    
    if (self.score > self.maxScore) {
        self.maxScore = self.score;
        [self saveUserData];
    }
    self.resultView.maxScoreLabel.text = [NSString stringWithFormat:@"%d", self.maxScore];
}

- (void)hideResult {
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         self.resultView.y = self.view.height;
                     } completion:^(BOOL complete) {
                     }];
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
}

- (void)checkIfScored {
    if (self.isGameOver) return;

    if (self.scorableObjects.count <= 0) return;
    for (PipeView *pipeView in self.scorableObjects) {
        // passed ladybug
        CGRect pipeFrame = [pipeView.superview convertRect:pipeView.frame toView:self.ladyBugView.superview];
        if (self.ladyBugView.center.x > pipeFrame.origin.x + pipeView.frame.size.width) {
            [self.scorableObjects removeObject:pipeView];
            self.score++;
            [self refreshLabel];
        }
    }
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
        pipeView.properties.speed = CGPointMake(OBSTACLE_SPEED, 0.f);
    }
}

- (void)drawStep {
    [self.backgroundView drawStep];
    for (PipeView *pipeView in self.worldObstacles) {
        [pipeView drawStep];
    }
    [self boundaryTestForPipes];
   
    [self collisionDetection];
    [self boundaryTestForLadyBug];
    
    [self.ladyBugView drawStep];
    [self checkIfScored];
}

- (void)setIsGameOver:(BOOL)isGameOver {
    if (self.isGameOver == isGameOver) return;
    
    _isGameOver = isGameOver;
    if (isGameOver) {
        [self animateCollision];
        [self stopObstacles];
        [self showResult];
    } else {
        [self resumeObstacles];
        [self hideResult];
    }
}

#pragma mark - ADs

- (void) createAdBannerView
{
    self.adBannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    CGSize bannerSize = [ADBannerView sizeFromBannerContentSizeIdentifier:self.adBannerView.currentContentSizeIdentifier];

    CGRect bannerFrame = self.adBannerView.frame;
    bannerFrame.origin.y = -bannerSize.height;
    self.adBannerView.frame = bannerFrame;
    
    self.adBannerView.delegate = self;
    self.adBannerView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
}

- (void) adjustBannerView
{
    CGRect adBannerFrame = self.adBannerView.frame;
    
    if([self.adBannerView isBannerLoaded])
    {
        adBannerFrame.origin.y = 0.f;
    }
    else
    {
        CGSize bannerSize = [ADBannerView sizeFromBannerContentSizeIdentifier:self.adBannerView.currentContentSizeIdentifier];
        adBannerFrame.origin.y = -bannerSize.height;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.adBannerView.frame = adBannerFrame;
    }];
}

#pragma mark - ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self adjustBannerView];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self adjustBannerView];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    //TO DO
    //Check internet connecction here
    /*
     if(internetNotAvailable)
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet." message:@"Please make sure an internet connection is available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     [alert release];
     return NO;
     }*/
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    
}


@end
