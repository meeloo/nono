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

@property (nonatomic, retain) NSArray* xEntries;
@property (nonatomic, retain) NSArray* yEntries;

@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, assign) NSUInteger height;

@property (nonatomic, assign) BOOL isSolving;
@property (nonatomic, assign) BOOL hasFoundSolution;

@end

@implementation NonoSolver

- (id)initWithXEntries:(NSArray*)xEntries andYEntries:(NSArray*)yEntries
{
    self = [super init];
    if (self != nil)
    {
        _xEntries = [xEntries retain];
        _yEntries = [yEntries retain];
        _width = _xEntries.count;
        _height = _yEntries.count;
    }
    return self;
}

- (void)dealloc
{
    [_xEntries release];
    [_yEntries release];
    [super dealloc];
}

- (BOOL)isSolvedByGrid:(NonoGrid*)grid
{
    NSUInteger width = self.xEntries.count;
    NSUInteger height = self.yEntries.count;
    
    {
        for (NSUInteger x = 0; x < width; x++)
        {
            @autoreleasepool
            {
                NSEnumerator* entryEnumerator = [self.xEntries[x] objectEnumerator];
                
                NonoEntry* currentEntry = [NonoEntry entry];
                currentEntry.color = [grid getColorAtX:x andY:0];
                for (NSUInteger y = 0; y < height; y++)
                {
                    NonoColor color = [grid getColorAtX:x andY:y];
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
                        
                        currentEntry = [NonoEntry entry];
                        currentEntry.color = color;
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
    
    {
        for (NSUInteger y = 0; y < height; y++)
        {
            @autoreleasepool
            {
                NSEnumerator* entryEnumerator = [self.yEntries[y] objectEnumerator];
                
                NonoEntry* currentEntry = [NonoEntry entry];
                currentEntry.color = [grid getColorAtX:0 andY:y];
                for (NSUInteger x = 0; x < width; x++)
                {
                    NonoColor color = [grid getColorAtX:x andY:y];
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
                        
                        currentEntry = [NonoEntry entry];
                        currentEntry.color = color;
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
    self.isSolving = YES;
    self.hasFoundSolution = NO;
    
    NonoGrid* grid = [NonoGrid gridWithWidth:self.width andHeight:self.height];
    BOOL result = [self fillEntryForGrid:grid
                                    minX:0
                                       Y:0
                            currentEntry:0];
    
    self.isSolving = NO;
    return (result ? grid : nil);
}

- (BOOL)hasUniqueSolution
{
    self.isSolving = NO;
    self.hasFoundSolution = NO;
    NonoGrid* grid = [NonoGrid gridWithWidth:self.width andHeight:self.height];
    return [self fillEntryForGrid:grid
                             minX:0
                                Y:0
                     currentEntry:0];
}

- (BOOL)fillEntryForGrid:(NonoGrid*)grid minX:(NSUInteger)minX Y:(NSUInteger)y currentEntry:(NSUInteger)currentEntryIndex
{
    NSArray* entries = self.yEntries[y];
    NonoEntry* currentEntry = entries[currentEntryIndex];
    NonoEntry* previousEntry = (currentEntryIndex == 0) ? nil : entries[currentEntryIndex-1];
    if ((previousEntry != nil) && nncEqual(previousEntry.color, currentEntry.color))
    {
        // Count one blank between two runs of the same color
        minX++;
    }
    
    if (minX > self.width)
    {
        // No more space for current entry
        return NO;
    }
    
    NSUInteger maxX = self.width + 1;
    previousEntry = nil;
    {
        for (NSUInteger i = entries.count; i > currentEntryIndex; i--)
        {
            NonoEntry* entry = entries[i-1];
            
            if ((previousEntry != nil) && nncEqual(previousEntry.color, entry.color))
            {
                // Count one blank between two runs of the same color
                maxX--;
            }
            
            maxX -= entry.count;
            
            previousEntry = entry;
        }
        
        if (maxX <= minX)
        {
            // No more space for remaining entries
            return NO;
        }
    }
    
    for (NSUInteger x = minX; x < maxX; x++)
    {
        for (NSUInteger i = 0; i < currentEntry.count; i++)
        {
            [grid setColor:currentEntry.color AtX:x+i andY:y];
        }
        
        if (y+1 == self.height && currentEntryIndex+1 == entries.count)
        {
            // This grid is done and has all entries filled
            // Test it
            if ([self isSolvedByGrid:grid])
            {
                if (self.hasFoundSolution)
                {
                    return NO;
                }
                else
                {
                    self.hasFoundSolution = YES;
                    return YES;
                }
            }
        }
        else
        {
            if (currentEntryIndex+1 < entries.count)
            {
                if ([self fillEntryForGrid:grid
                                      minX:(x+currentEntry.count)
                                         Y:y
                              currentEntry:(currentEntryIndex+1)])
                {
                    if (self.isSolving)
                    {
                        return YES;
                    }
                    else if (self.hasFoundSolution)
                    {
                        return NO;
                    }
                }
            }
            else
            {
                if ([self fillEntryForGrid:grid
                                      minX:0
                                         Y:y+1
                              currentEntry:0])
                {
                    if (self.isSolving)
                    {
                        return YES;
                    }
                    else if (self.hasFoundSolution)
                    {
                        return NO;
                    }
                }
            }
        }
        
        // Erase temp entry
        for (NSUInteger i = 0; i < currentEntry.count; i++)
        {
            [grid setColor:nncEmpty() AtX:x+i andY:y];
        }
    }
    
    return NO;
}

@end
