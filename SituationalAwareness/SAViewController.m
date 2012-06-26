//
//  SAViewController.m
//  SituationalAwareness
//
//  Created by Xi Cao on 26/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SAViewController.h"
#import "GvaView.h"

@interface SAViewController ()
@property (nonatomic, weak) IBOutlet GvaView *gvaView;
@end

@implementation SAViewController

@synthesize gvaView = _gvaView;

- (void)setGvaView:(GvaView *)gvaView 
{
    _gvaView = gvaView;
    [self.gvaView setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];// hide status bar
    return UIInterfaceOrientationIsLandscape(orientation);// only support landscape
}

@end
