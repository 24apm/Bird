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

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        return self;
    }
    
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (void)initialize {
    [[GameLoopTimer instance] initialize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawStep) name:DRAW_STEP_NOTIFICATION object:nil];
    self.worldObjects = [NSMutableArray array];
}

- (IBAction)tapButtonPressed:(id)sender {
    self.ladyBugView.properties.gravity = CGPointMake(0.f, GRAVITY);

    self.ladyBugView.properties.speed = CGPointMake(0.f, 0.f);

    
    self.ladyBugView.properties.acceleration = CGPointMake(self.ladyBugView.properties.acceleration.x, self.ladyBugView.properties.acceleration.y - TAP_ACCELATION_INCREASE);
    
    self.ladyBugView.properties.rotation = 0.f;    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawStep {
    [self.backgroundView drawStep];
    [self.ladyBugView drawStep];
    
    if ((self.ladyBugView.frame.origin.y + self.ladyBugView.frame.size.height) > self.view.frame.size.height) {
        self.ladyBugView.frame = CGRectMake(self.ladyBugView.frame.origin.x, (self.self.view.frame.size.height - self.ladyBugView.frame.size.height), self.ladyBugView.frame.size.width, self.ladyBugView.frame.size.height);
        self.ladyBugView.properties.rotation = 90.f;
        [self.ladyBugView paused];
    }
}



@end
