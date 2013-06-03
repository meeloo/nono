//
//  NonoPlayViewController.m
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoPlayViewController.h"

#import "NonoGridViewController.h"

#import "NonoGrid.h"

@interface NonoPlayViewController ()

@property (nonatomic, retain) NonoGrid* solution;

@property (nonatomic, retain) NonoGridViewController* gridViewController;

@end

@implementation NonoPlayViewController

- (id)initWithSolution:(NonoGrid*)solution
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self = [super initWithNibName:@"NonoPlayViewController_iPhone" bundle:nil];
    }
    else
    {
        self = [super initWithNibName:@"NonoPlayViewController_iPad" bundle:nil];
    }
    
    if (self)
    {
        _solution = [solution retain];
        
        NonoGrid* playGrid = [NonoGrid gridWithWidth:solution.width andHeight:solution.height];
        _gridViewController = [[NonoGridViewController alloc] initWithGrid:playGrid];
        [self addChildViewController:_gridViewController];
    }
    return self;
}

- (void)dealloc
{
    [_gridViewController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView* gridView = self.gridViewController.view;
    [self.view addSubview:gridView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
