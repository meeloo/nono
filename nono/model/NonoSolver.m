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

@end

@implementation NonoSolver

- (id)initWithXEntries:(NSArray*)xEntries andYEntries:(NSArray*)yEntries
{
    self = [super init];
    if (self != nil)
    {
        _xEntries = [xEntries retain];
        _yEntries = [yEntries retain];
    }
    return self;
}

- (void)dealloc
{
    [_xEntries release];
    [_yEntries release];
    [super dealloc];
}

- (NonoGrid*)solve
{
    
}

- (BOOL)isSolvedByGrid:(NonoGrid*)grid
{
    NSUInteger width = self.xEntries.count;
    NSUInteger height = self.yEntries.count;
    
    {
        for (NSUInteger x = 0; x < width; x++)
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
    
    {
        for (NSUInteger y = 0; y < height; y++)
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
    
    return YES;
}

- (BOOL)hasUniqueSolution
{
    NSUInteger width = self.xEntries.count;
    NSUInteger height = self.yEntries.count;
    
    NonoGrid* emptyGrid = [[[NonoGrid alloc] initWithWidth:width andHeight:height] autorelease];
    [self fillRowsForGrid:emptyGrid minX:0 Y:0 currentEntry:0];
}

- (void)fillRowsForGrid:(NonoGrid*)grid minX:(NSUInteger)minX Y:(NSUInteger)y currentEntry:(NSUInteger)currentEntryIndex
{
}

@end
