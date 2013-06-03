//
//  NonoGridViewController.m
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoGridViewController.h"
#import "NonoGrid.h"
#import "NonoUtilities.h"

@interface NonoGridViewController ()

@property (nonatomic, retain) NonoGrid* playGrid;

@property (nonatomic, retain) UIView* gridBackgroundView;
@property (nonatomic, retain) NSMutableArray* cellViews;

@end

@implementation NonoGridViewController

- (id)initWithGrid:(NonoGrid *)grid
{
    self = [super init];
    if (self)
    {
        _playGrid = [grid retain];
        
        _gridBackgroundView = [[UIView alloc] init];
        
        _cellViews = [[NSMutableArray alloc] initWithCapacity:grid.width];
        for (NSUInteger x = 0; x < grid.width; x++)
        {
            [_cellViews addObject:[NSMutableArray arrayWithCapacity:grid.height]];
        }
    }
    return self;
}

- (void)dealloc
{
    [_playGrid release];
    [_gridBackgroundView release];
    [_cellViews release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.gridBackgroundView];
    
    UIImage* gridImage = [UIImage imageNamed:@"5grid"];
    
    NSUInteger numGridsX = self.playGrid.width / 5;
    NSUInteger numGridsY = self.playGrid.height / 5;
    NSUInteger scaleFactor = MAX(numGridsX, numGridsY);
    CGRect frame = CGRectMake(0.0f, 0.0f, gridImage.size.width / scaleFactor, gridImage.size.height / scaleFactor);
    for (NSUInteger x = 0; x < numGridsX; x++)
    {
        frame.origin.x = x * frame.size.width;
        for (NSUInteger y = 0; y < numGridsY; y++)
        {
            frame.origin.y = y * frame.size.height;
            UIImageView* gridImageView = [[[UIImageView alloc] initWithImage:gridImage] autorelease];
            gridImageView.contentMode = UIViewContentModeScaleToFill;
            gridImageView.frame = frame;
            [self.gridBackgroundView addSubview:gridImageView];
        }
    }
    
    frame.size.width = gridImage.size.width / numGridsX;
    frame.size.height = gridImage.size.height / numGridsY;
    self.gridBackgroundView.frame = frame;
    self.gridBackgroundView.center = self.view.center;
    
    frame.size.width = 100.0f / scaleFactor;
    frame.size.height = 100.0f / scaleFactor;
    for (NSUInteger x = 0; x < self.playGrid.width; x++)
    {
        frame.origin.x = x * (frame.size.width + 1) + (self.gridBackgroundView.frame.origin.x + 1);
        NSMutableArray* col = self.cellViews[x];
        for (NSUInteger y = 0; y < self.playGrid.height; y++)
        {
            frame.origin.y = y * (frame.size.height + 1) + (self.gridBackgroundView.frame.origin.y + 1);
            UIView* cellView = [[[UIView alloc] initWithFrame:frame] autorelease];
            cellView.tag = x * self.playGrid.width + y;
            
            UITapGestureRecognizer* tapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTouched:)] autorelease];
            [cellView addGestureRecognizer:tapRecognizer];
            
            [col addObject:cellView];
            [self.view addSubview:cellView];
        }
    }
    
    [self updateCells];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cellTouched:(UITapGestureRecognizer*)tapRecognizer
{
    UIView* cellView = (UIView*)tapRecognizer.view;
    NSUInteger x = cellView.tag / self.playGrid.width;
    NSUInteger y = cellView.tag % self.playGrid.width;
    NonoColor color = self.playGrid.grid[x][y];
    if (nncEqual(color, nncEmpty()))
    {
        self.playGrid.grid[x][y] = nnc(0, 0, 0);
    }
    else
    {
        self.playGrid.grid[x][y] = nncEmpty();
    }
    [self updateCells];
}

- (void)updateCells
{
    for (NSUInteger x = 0; x < self.playGrid.width; x++)
    {
        NSMutableArray* col = self.cellViews[x];
        for (NSUInteger y = 0; y < self.playGrid.height; y++)
        {
            NonoColor color = self.playGrid.grid[x][y];
            UIView* cellView = col[y];
            cellView.backgroundColor = [NonoUtilities colorWithNonoColor:color];
        }
    }
}

@end
