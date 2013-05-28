//
//  nonoTests.m
//  nonoTests
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "nonoTests.h"
#import "NonoGrid.h"
#import "NonoColor.h"
#import "NonoSolver.h"

@implementation nonoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testIsEqualToGrid
{
    NonoGrid* grid1 = [[[NonoGrid alloc] initDebugGrid] autorelease];
    NonoGrid* grid2 = [[[NonoGrid alloc] initDebugGrid] autorelease];
    if (![grid1 isEqualToGrid:grid2])
    {
        STFail(@"Debug grids are not equal.");
    }
}

- (void)testGetColor
{
    NonoGrid* grid = [[[NonoGrid alloc] initDebugGrid] autorelease];
    NonoColor color = [grid getColorAtX:0 andY:0];
    if (!nncEqual(color, nncEmpty()))
    {
        STFail(@"Color in (0, 0) not empty.");
    }
    
    color = [grid getColorAtX:2 andY:0];
    if (!nncEqual(color, nnc(0, 0, 0)))
    {
        STFail(@"Color in (0, 0) not (0, 0, 0).");
    }
}

- (void)testSetColor
{
    NonoGrid* grid = [[[NonoGrid alloc] initDebugGrid] autorelease];
    NonoColor color = nnc(255, 128, 0);
    [grid setColor:color AtX:0 andY:0];
    if (!nncEqual(color, [grid getColorAtX:0 andY:0]))
    {
        STFail(@"Color in (0, 0) not equal to given color.");
    }
}

- (void)testXEntries
{
    NonoGrid* grid = [[[NonoGrid alloc] initDebugGrid] autorelease];
    NSArray* xEntries = [grid getXEntries];
    STFail(@"TODO - add X entries test");
}

- (void)testYEntries
{
    NonoGrid* grid = [[[NonoGrid alloc] initDebugGrid] autorelease];
    NSArray* yEntries = [grid getYEntries];
    STFail(@"TODO - add Y entries test.");
}

- (void)testIsSolvedByGrid
{
    NonoGrid* grid = [[[NonoGrid alloc] initDebugGrid] autorelease];
    NonoSolver* solver = [[NonoSolver alloc] initWithXEntries:[grid getXEntries] andYEntries:[grid getYEntries]];
    STAssertTrue([solver isSolvedByGrid:grid], @"Debug grid does not solve itself.");
}

- (void)testIsSolvedByGridRandom
{
    // Test with a hundred thousand random grids
    for (NSUInteger i = 0; i < 1E5; i++)
    {
        @autoreleasepool
        {
            NonoGrid* grid = [[[NonoGrid alloc] initRandomGrid] autorelease];
            NonoSolver* solver = [[NonoSolver alloc] initWithXEntries:[grid getXEntries] andYEntries:[grid getYEntries]];
            STAssertTrue([solver isSolvedByGrid:grid], @"Random grid does not solve itself.");
        }
    }
}



@end
