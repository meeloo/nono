//
//  NonoGridViewController.m
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoGridViewController.h"
#import "NonoGrid.h"

@interface NonoGridViewController ()

@property (nonatomic, retain) NonoGrid* playGrid;

@end

@implementation NonoGridViewController

- (id)initWithGrid:(NonoGrid *)grid
{
    self = [super init];
    if (self)
    {
        _playGrid = [grid retain];
    }
    return self;
}

- (void)dealloc
{
    [_playGrid release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect frame = self.parentViewController.view.frame;
    frame.origin = CGPointZero;
    self.view.frame = frame;
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
