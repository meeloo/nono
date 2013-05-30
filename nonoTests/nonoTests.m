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

- (void)testPrint
{
    // Visual test only
    NonoGrid* grid = [NonoGrid debugGrid];
    [grid print];
}

- (void)testIsEqualToGrid
{
    NonoGrid* grid1 = [NonoGrid debugGrid];
    NonoGrid* grid2 = [NonoGrid debugGrid];
    if (![grid1 isEqualToGrid:grid2])
    {
        STFail(@"Debug grids are not equal.");
    }
}

- (void)testGetColor
{
    NonoGrid* grid = [NonoGrid debugGrid];
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
    NonoGrid* grid = [NonoGrid debugGrid];
    NonoColor color = nnc(255, 128, 0);
    [grid setColor:color AtX:0 andY:0];
    if (!nncEqual(color, [grid getColorAtX:0 andY:0]))
    {
        STFail(@"Color in (0, 0) not equal to given color.");
    }
}

- (void)testXEntries
{
    NonoGrid* grid = [NonoGrid debugGrid];
    NSArray* xEntries = [grid getXEntries];
    STFail(@"TODO - add X entries test");
}

- (void)testYEntries
{
    NonoGrid* grid = [NonoGrid debugGrid];
    NSArray* yEntries = [grid getYEntries];
    STFail(@"TODO - add Y entries test.");
}

- (void)testIsSolvedByGrid
{
    NonoGrid* grid = [NonoGrid debugGrid];
    NonoSolver* solver = [[[NonoSolver alloc] initWithXEntries:[grid getXEntries] andYEntries:[grid getYEntries]] autorelease];
    STAssertTrue([solver isSolvedByGrid:grid], @"Debug grid does not solve itself.");
}

/*- (void)testIsSolvedByGridRandom
{
    // Test with a hundred thousand random grids
    for (NSUInteger i = 0; i < 1E5; i++)
    {
        @autoreleasepool
        {
            NonoGrid* grid = [NonoGrid randomGrid];
            NonoSolver* solver = [[NonoSolver alloc] initWithXEntries:[grid getXEntries] andYEntries:[grid getYEntries]];
            STAssertTrue([solver isSolvedByGrid:grid], @"Random grid does not solve itself.");
        }
    }
}*/

- (void)testSolve
{
    NonoGrid* grid = [NonoGrid randomGrid];
    NonoSolver* solver = [[[NonoSolver alloc] initWithXEntries:[grid getXEntries] andYEntries:[grid getYEntries]] autorelease];
    NonoGrid* solution = [solver solve];
    STAssertTrue([grid isEqualToGrid:solution], @"Solution does is not equal to debug grid.");
}



@end
