//
//  NonoSolver.m
//  nono
//
//  Created by Charles Francoise on 5/29/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoSolver.h"
#import "NonoGrid.h"
#import "NonoEntry.h"

@interface NonoSolver ()

@property (nonatomic, retain) NSArray* colEntries;
@property (nonatomic, retain) NSArray* rowEntries;

@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, assign) NSUInteger height;

@property (nonatomic, assign) BOOL isSolving;
@property (nonatomic, assign) BOOL hasFoundSolution;

// Lazy caching of solution
@property (nonatomic, retain) NonoGrid* solution;

@end

@implementation NonoSolver

- (id)initWithColEntries:(NSArray*)colEntries andRowEntries:(NSArray*)rowEntries
{
    self = [super init];
    if (self != nil)
    {
        _colEntries = [colEntries retain];
        _rowEntries = [rowEntries retain];
        _width = _colEntries.count;
        _height = _rowEntries.count;
        _solution = nil;
    }
    return self;
}

- (void)dealloc
{
    [_colEntries release];
    [_rowEntries release];
    [_solution release];
    [super dealloc];
}

- (BOOL)isSolvedByGrid:(NonoGrid*)grid
{
    @autoreleasepool
    {
        NSUInteger width = self.colEntries.count;
        NSUInteger height = self.rowEntries.count;
        NonoEntry* currentEntry = [NonoEntry entry];
        
        {
            for (NSUInteger x = 0; x < width; x++)
            {
                NSEnumerator* entryEnumerator = [self.colEntries[x] objectEnumerator];
                
                currentEntry.color = grid.grid[x][0];
                currentEntry.count = 0;
                for (NSUInteger y = 0; y < height; y++)
                {
                    NonoColor color = grid.grid[x][y];
                    if (!nncEqual(color, currentEntry.color))
                    {
                        if (!currentEntry.color.empty)
                        {
                            //new color - check currentEntry against grid entry
                            NonoEntry* gridEntry = [entryEnumerator nextObject];
                            if (![gridEntry isEqual:currentEntry])
                            {
                                return NO;
                            }
                        }
                        
                        currentEntry.color = color;
                        currentEntry.count = 0;
                    }
                    
                    currentEntry.count++;
                }
                
                NonoEntry* gridEntry;
                if (gridEntry = [entryEnumerator nextObject])
                {
                    if (![gridEntry isEqual:currentEntry])
                    {
                        return NO;
                    }
                }
                
                if ([entryEnumerator nextObject] != nil)
                {
                    return NO;
                }
            }
        }
        
        {
            for (NSUInteger y = 0; y < height; y++)
            {
                NSEnumerator* entryEnumerator = [self.rowEntries[y] objectEnumerator];
                
                currentEntry.color = grid.grid[0][y];
                currentEntry.count = 0;
                for (NSUInteger x = 0; x < width; x++)
                {
                    NonoColor color = grid.grid[x][y];
                    if (!nncEqual(color, currentEntry.color))
                    {
                        if (!currentEntry.color.empty)
                        {
                            //new color - check currentEntry against grid entry
                            NonoEntry* gridEntry = [entryEnumerator nextObject];
                            if (![gridEntry isEqual:currentEntry])
                            {
                                return NO;
                            }
                        }
                        
                        currentEntry.color = color;
                        currentEntry.count = 0;
                    }
                    
                    currentEntry.count++;
                }
                
                NonoEntry* gridEntry;
                if (gridEntry = [entryEnumerator nextObject])
                {
                    if (![gridEntry isEqual:currentEntry])
                    {
                        return NO;
                    }
                }
                
                if ([entryEnumerator nextObject] != nil)
                {
                    return NO;
                }
                
            }
        }
    }
    
    return YES;
}

- (NonoGrid*)solve
{
    if (self.solution != nil)
    {
        return self.solution;
    }
    
    self.isSolving = YES;
    self.hasFoundSolution = NO;
    
    NonoGrid* grid = [self solveFlat];
    
    self.isSolving = NO;
    
    return grid;
}

- (BOOL)hasUniqueSolution
{
    self.isSolving = NO;
    self.hasFoundSolution = NO;
    NonoGrid* grid = [self solveFlat];
    return (grid != nil);
}

- (NonoGrid*)solveFlat
{
    NonoGrid* grid = [NonoGrid gridWithWidth:self.width andHeight:self.height];
    
    // Count max number of entries
    NSUInteger maxEntries = 0;
    for (NSArray* entries in self.rowEntries)
    {
        maxEntries = MAX(entries.count, maxEntries);
    }
    
    // Calculate minimum and maximum values of entry start
    // and row at which entry is found.
    NSUInteger minX[self.height][maxEntries];
    NSUInteger curX[self.height][maxEntries];
    NSUInteger maxX[self.height][maxEntries];
    NSUInteger currentRow = 0;
    NSUInteger currentEntryIndex;
    for (NSArray* entries in self.rowEntries)
    {
        currentEntryIndex = 0;
        NonoEntry* prevEntry = nil;
        NonoEntry* currentEntry = nil;
        for (currentEntry in entries)
        {
            // If first entry of row
            if (prevEntry == nil)
            {
                minX[currentRow][0] = 0;
            }
            else
            {
                minX[currentRow][currentEntryIndex] = minX[currentRow][currentEntryIndex - 1] + prevEntry.count + (nncEqual(currentEntry.color, prevEntry.color) ? 1 : 0);
            }
            curX[currentRow][currentEntryIndex] = minX[currentRow][currentEntryIndex];
            
            prevEntry = currentEntry;
            currentEntryIndex++;
        }
        
        prevEntry = nil;
        for (currentEntry in [entries reverseObjectEnumerator])
        {
            currentEntryIndex--;
            // If last entry of row
            if (prevEntry == nil)
            {
                maxX[currentRow][currentEntryIndex] = self.width - currentEntry.count + 1;
            }
            else
            {
                maxX[currentRow][currentEntryIndex] = maxX[currentRow][currentEntryIndex + 1] - currentEntry.count - (nncEqual(currentEntry.color, prevEntry.color) ? 1 : 0);
            }
            
            prevEntry = currentEntry;
        }
        
        currentRow++;
    }
    
    currentRow = 0;
    currentEntryIndex = 0;
    while (!(self.isSolving && self.hasFoundSolution))
    {
        if (currentRow < self.height)
        {
            NSArray* entries = self.rowEntries[currentRow];
            if (currentEntryIndex < entries.count)
            {
                NonoEntry* currentEntry = entries[currentEntryIndex];
                
                // Fill current entry
                NSUInteger lastX = curX[currentRow][currentEntryIndex] + currentEntry.count;
                for (NSUInteger x = curX[currentRow][currentEntryIndex]; x < lastX; x++)
                {
                    grid.grid[x][currentRow] = currentEntry.color;
                }
                
                currentEntryIndex++;
            }
            else
            {
                currentRow++;
                currentEntryIndex = 0;
            }
        }
        else
        {
            if ([self isSolvedByGrid:grid])
            {
                if (!self.isSolving && self.hasFoundSolution)
                {
                    return nil;
                }
                self.hasFoundSolution = YES;
            }
            else
            {
                NSArray* entries;
                do
                {
                    // Reset entry
                    if (currentRow < self.height)
                    {
                        entries = self.rowEntries[currentRow];
                        if (currentEntryIndex < entries.count)
                        {
                            curX[currentRow][currentEntryIndex] = minX[currentRow][currentEntryIndex];
                        }
                    }
                    
                    // Backtrack one entry
                    if (currentEntryIndex == 0)
                    {
                        if (currentRow == 0)
                        {
                            return nil;
                        }
                        else
                        {
                            currentRow--;
                            entries = self.rowEntries[currentRow];
                            currentEntryIndex = entries.count;
                        }
                    }
                    
                    // Erase entry
                    if (entries.count > 0)
                    {
                        currentEntryIndex--;
                        NonoEntry* currentEntry = entries[currentEntryIndex];
                        NSUInteger lastX = curX[currentRow][currentEntryIndex] + currentEntry.count;
                        for (NSUInteger x = curX[currentRow][currentEntryIndex]; x < lastX; x++)
                        {
                            grid.grid[x][currentRow] = nncEmpty();
                        }
                        
                        curX[currentRow][currentEntryIndex]++;
                    }
                }
                while (curX[currentRow][currentEntryIndex] == maxX[currentRow][currentEntryIndex]);
                
                // Shift all following entries on row
                NSUInteger dx = curX[currentRow][currentEntryIndex] - minX[currentRow][currentEntryIndex];
                for (NSUInteger i = currentEntryIndex + 1; i < entries.count; i++)
                {
                    curX[currentRow][i] += dx;
                }
            }
        }
    }
    
    // Cache solution for next call to solve
    self.solution = grid;
    return grid;
}

@end
