//
//  NonoPlayViewController.m
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoPlayViewController.h"
#import "NonoGridViewController.h"
#import "NonoColorChooser.h"

#import "NonoGrid.h"

@interface NonoPlayViewController ()

@property (nonatomic, retain) NonoGrid* solution;
@property (nonatomic, retain) NonoGrid* playGrid;

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
        
        _playGrid = [NonoGrid gridWithWidth:solution.width andHeight:solution.height];
        
        _gridViewController = [[NonoGridViewController alloc] initWithGrid:_playGrid];
        [self addChildViewController:_gridViewController];
        [_gridViewController didMoveToParentViewController:self];
    }
    return self;
}

- (void)dealloc
{
    [_colorChooser release];
    [_gridViewController release];
    [_solution release];
    [_playGrid release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView* gridView = self.gridViewController.view;
    CGRect frame = gridView.frame;
    frame.origin.x = (self.view.frame.size.width - frame.size.width) / 2.0f;
    frame.origin.y = 20.0f;
    gridView.frame = frame;
    [self.view addSubview:gridView];
    
    self.colorChooser.colors = [self.solution getColors];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)colorChanged:(NonoColorChooser*)colorChooser
{
    self.gridViewController.currentColor = colorChooser.selectedColor;
}

@end
