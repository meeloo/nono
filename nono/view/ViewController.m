//
//  ViewController.m
//  nono
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "ViewController.h"

#import "NonoGrid.h"
#import "NonoSolver.h"

@interface ViewController ()

@end

@implementation ViewController

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

- (IBAction)start:(id)sender
{
    NonoGrid* grid = [NonoGrid randomGrid];
    NonoSolver* solver = [[[NonoSolver alloc] initWithXEntries:[grid getXEntries] andYEntries:[grid getYEntries]] autorelease];
    NonoGrid* solution = [solver solve];
    NSAssert([grid isEqualToGrid:solution], @"Solution does is not equal to debug grid.");
}

@end
