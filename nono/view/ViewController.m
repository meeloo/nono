//
//  ViewController.m
//  nono
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"

#import "NonoGrid.h"
#import "NonoSolver.h"

@interface ViewController ()

@property (nonatomic, retain) NonoSolver* solver;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender
{
    NonoGrid* grid = [NonoGrid randomGrid];
    _solver = [[NonoSolver alloc] initWithColEntries:[grid getColEntries] andRowEntries:[grid getRowEntries]];
    
    CGRect frame;
    frame.size.width = self.gridView.frame.size.width / grid.width;
    frame.size.height = self.gridView.frame.size.height / grid.height;
    for (NSUInteger x = 0; x < grid.width; x++)
    {
        frame.origin.x = x * frame.size.width;
        for (NSUInteger y = 0; y < grid.height; y++)
        {
            frame.origin.y = y * frame.size.height;
            UIView* cellView = [[[UIView alloc] initWithFrame:frame] autorelease];
            [self.gridView addSubview:cellView];
        }
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [_solver solve];
    });
}

- (void)update:(id)sender
{
    NonoGrid* grid = nil;//solver.grid;
    if (grid != nil)
    {
        for (NSUInteger x = 0; x < grid.width; x++)
        {
            for (NSUInteger y = 0; y < grid.height; y++)
            {
                UIView* cellView = self.gridView.subviews[x * grid.width + y];
                NonoColor color = grid.grid[x][y];
                cellView.backgroundColor = [UIColor colorWithRed:color.r
                                                           green:color.g
                                                            blue:color.b
                                                           alpha:(color.empty ? 0.0f : 1.0f)];
            }
        }
    }
}

@end
