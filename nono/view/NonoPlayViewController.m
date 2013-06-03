//
//  NonoPlayViewController.m
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoPlayViewController.h"
#import "NonoGridViewController.h"
#import "NonoColorChooserViewController.h"

#import "NonoGrid.h"

@interface NonoPlayViewController ()

@property (nonatomic, retain) NonoGrid* solution;
@property (nonatomic, retain) NonoGrid* playGrid;

@property (nonatomic, retain) NonoGridViewController* gridViewController;
@property (nonatomic, retain) NonoColorChooserViewController * colorChooserViewController;

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
        
        _colorChooserViewController = [[NonoColorChooserViewController alloc] initWithColors:[_solution getColors]];
        [self addChildViewController:_colorChooserViewController];
        [_colorChooserViewController didMoveToParentViewController:self];
    }
    return self;
}

- (void)dealloc
{
    [_gridViewController release];
    [_colorChooserViewController release];
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
    
    UIView* colorChooserView = self.colorChooserViewController.view;
    frame = colorChooserView.frame;
    frame.origin.x = (self.view.frame.size.width - frame.size.width) / 2.0f;
    frame.origin.y = gridView.frame.origin.y + gridView.frame.size.height + 40.0f;
    colorChooserView.frame = frame;
    [self.view addSubview:colorChooserView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
