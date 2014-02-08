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

@interface GameViewController ()

@property (strong, nonatomic) NSMutableArray *worldObstacles;
@property (nonatomic) BOOL isGameOver;

@end

@implementation GameViewController

- (void)initialize {
    [[GameLoopTimer instance] initialize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawStep) name:DRAW_STEP_NOTIFICATION object:nil];
    self.worldObstacles = [NSMutableArray array];
    [self createObstacle];
    self.isGameOver = NO;
}

- (IBAction)tapButtonPressed:(id)sender {
    if (self.isGameOver == YES) return;

    self.ladyBugView.properties.gravity = CGPointMake(0.f, GRAVITY);

    self.ladyBugView.properties.speed = CGPointMake(0.f, -5.f);

    
//    self.ladyBugView.properties.acceleration = CGPointMake(self.ladyBugView.properties.acceleration.x, self.ladyBugView.properties.acceleration.y + TAP_ACCELATION_INCREASE);
    
    self.ladyBugView.properties.rotation = 0.f;
}

- (void)createObstacle {
    PipeView *pipeView;
    for (int i = 0; i < 2; i++) {
        pipeView = [[PipeView alloc] init];
        [self.worldObstacles addObject:pipeView];
        [self.obstacleLayer addSubview:pipeView];
        pipeView.center = CGPointMake(self.view.frame.size.width * (i + 1), self.view.center.y);
        float randomY = [Utils randBetweenMin:self.view.frame.size.height * 0.3f max:self.view.frame.size.height * 0.7f];
        
        [pipeView setupGapDistance:self.ladyBugView.frame.size.height * 3.f gapCenterY:randomY];
        pipeView.properties.speed = CGPointMake(OBSTACLE_SPEED, 0.f);
    }
}

- (IBAction)rematchPressed:(id)sender {
    self.isGameOver = NO;
    int i = 1.f;
    for (PipeView *pipeView in self.worldObstacles) {
        // off map
            pipeView.center = CGPointMake(self.view.frame.size.width * i * 2.0f, pipeView.center.y);
            float randomY = [Utils randBetweenMin:self.view.frame.size.height * 0.3f max:self.view.frame.size.height * 0.7f];
            [pipeView setupGapDistance:self.ladyBugView.frame.size.height * 3.f gapCenterY:randomY];
        i++;
    }
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
    }
}

- (void)boundaryTestForPipes {
    for (PipeView *pipeView in self.worldObstacles) {
        // off map
        if (pipeView.center.x < -pipeView.frame.size.width) {
            pipeView.center = CGPointMake(self.view.frame.size.width * 4.f, pipeView.center.y);
            float randomY = [Utils randBetweenMin:self.view.frame.size.height * 0.3f max:self.view.frame.size.height * 0.7f];
            [pipeView setupGapDistance:self.ladyBugView.frame.size.height * 3.f gapCenterY:randomY];
        }
    }
}

- (void)collisionDetection {
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


- (void)drawStep {
    if (self.isGameOver == NO) {
        [self.backgroundView drawStep];
        for (PipeView *pipeView in self.worldObstacles) {
            [pipeView drawStep];
        }
        [self boundaryTestForPipes];
//        [self collisionDetection];
    }

    [self.ladyBugView drawStep];
    [self boundaryTestForLadyBug];
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
