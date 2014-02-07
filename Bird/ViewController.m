//
//  ViewController.m
//  Bird
//
//  Created by MacCoder on 2/5/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "ViewController.h"
#import "GameLoopTimer.h"
#import "GameConstants.h"

@interface ViewController ()

@property (weak, nonatomic) NSMutableArray *worldObjects;

@end

@implementation ViewController

- (void)initialize {
    [[GameLoopTimer instance] initialize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawStep) name:DRAW_STEP_NOTIFICATION object:nil];
    self.worldObjects = [NSMutableArray array];
}

- (IBAction)tapButtonPressed:(id)sender {
    self.ladyBugView.properties.gravity = CGPointMake(0.f, GRAVITY);

    self.ladyBugView.properties.speed = CGPointMake(0.f, 0.f);

    
    self.ladyBugView.properties.acceleration = CGPointMake(self.ladyBugView.properties.acceleration.x, self.ladyBugView.properties.acceleration.y + TAP_ACCELATION_INCREASE);
    
    self.ladyBugView.properties.rotation = 0.f;
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

- (void)boundaryTest {
    if ((self.ladyBugView.frame.origin.y + self.ladyBugView.frame.size.height) > self.view.frame.size.height) {
        self.ladyBugView.frame = CGRectMake(self.ladyBugView.frame.origin.x, (self.self.view.frame.size.height - self.ladyBugView.frame.size.height), self.ladyBugView.frame.size.width, self.ladyBugView.frame.size.height);
        self.ladyBugView.properties.rotation = 90.f;
        [self.ladyBugView paused];
    }
}

- (void)drawStep {
    [self.backgroundView drawStep];
    [self.ladyBugView drawStep];
    [self boundaryTest];
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
