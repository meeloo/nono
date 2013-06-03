//
//  ViewController.m
//  nono
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoMainViewController.h"
#import "NonoPlayViewController.h"
#import "NonoGrid.h"

@interface NonoMainViewController ()

@end

@implementation NonoMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
}


- (IBAction)playButtonPressed:(id)sender
{
    NonoGrid* grid = [NonoGrid debugGrid];
    NonoPlayViewController* playViewController = [[[NonoPlayViewController alloc] initWithSolution:grid] autorelease];
    
    [self.parentViewController addChildViewController:playViewController];
    [self.parentViewController transitionFromViewController:self
                                           toViewController:playViewController
                                                   duration:0.0
                                                    options:UIViewAnimationOptionTransitionNone
                                                 animations:^{}
                                                 completion:^(BOOL success) {
                                                     if (success)
                                                     {
                                                         [self removeFromParentViewController];
                                                     }
                                                 }];
}

- (IBAction)createButtonPressed:(id)sender
{
}

@end
