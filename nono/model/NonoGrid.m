//
//  NonoGrid.m
//  nono
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoGrid.h"
#import "NonoEntry.h"

@interface NonoGrid ()
{
    NonoColor** _grid;
}

@end

@implementation NonoGrid

-(id)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height
{
    self = [super init];
    if (self != nil)
    {
        _width = width;
        _height = height;
        _grid = calloc(_width, sizeof(NonoColor));
        for (NSUInteger x = 0; x < width; x++)
        {
            _grid[x] = calloc(_height, sizeof(NonoColor));
        }
    }
    return self;
}

- (id)initWithGrid:(NonoGrid*)aGrid
{
    self = [self initWithWidth:aGrid.width andHeight:aGrid.height];
    if (self != nil)
    {
        for (NSUInteger x = 0; x < _width; x++)
        {
            for (NSUInteger y = 0; y < _height; y++)
            {
                self->_grid[x][y] = aGrid->_grid[x][y];
            }
        }
    }
    return self;
}

- (BOOL)isEqualToGrid:(NonoGrid*)aGrid
{
    NSUInteger width = self.width;
    NSUInteger height = self.height;
    for (NSUInteger x = 0; x < width; x++)
    {
        for (NSUInteger y = 0; y < height; y++)
        {
            if (!nncEqual(self->_grid[x][y], aGrid->_grid[x][y]))
            {
                return NO;
            }
        }
    }
    return YES;
}

- (void)setColor:(NonoColor)color AtX:(NSUInteger)x andY:(NSUInteger)y
{
    if (x >= self.width || y >= self.height)
    {
        NSException* myException = [NSException
                                    exceptionWithName:NSRangeException
                                    reason:[NSString stringWithFormat:@"position (%d,%d) outside of grid bounds [%d,%d]", x, y,self.width, self.height]
                                    userInfo:nil];
        @throw myException;
    }
    
    _grid[x][y] = color;
}

- (NonoColor)getColorAtX:(NSUInteger)x andY:(NSUInteger)y
{
    if (x >= self.width || y >= self.height)
    {
        NSException* myException = [NSException
                                    exceptionWithName:NSRangeException
                                    reason:[NSString stringWithFormat:@"position (%d,%d) outside of grid bounds [%d,%d]", x, y,self.width, self.height]
                                    userInfo:nil];
        @throw myException;
    }
    
    return _grid[x][y];
}

- (NSArray*)getXEntries
{
    NSUInteger width = self.width;
    NSUInteger height = self.height;
    NSMutableArray* xEntries = [NSMutableArray arrayWithCapacity:width];
    for (NSUInteger x = 0; x < width; x++)
    {
        NonoEntry* currentEntry = [NonoEntry entry];
        NSMutableArray* colEntries = [NSMutableArray arrayWithCapacity:height];
        for (NSUInteger y = 0; y < height; y++)
        {
            if (nncEqual(_grid[x][y], currentEntry.color))
            {
                currentEntry.count++;
            }
            else
            {
                if (!currentEntry.color.empty)
                {
                    [colEntries addObject:currentEntry];
                }
                currentEntry = [NonoEntry entry];
                currentEntry.color = _grid[x][y];
            }
        }
        
        if (!currentEntry.color.empty)
        {
            [colEntries addObject:currentEntry];
        }
        
        [xEntries addObject:colEntries];
    }
    return xEntries;
}

- (NSArray*)getYEntries
{
    NSUInteger width = self.width;
    NSUInteger height = self.height;
    NSMutableArray* yEntries = [NSMutableArray arrayWithCapacity:height];
    for (NSUInteger y = 0; y < height; y++)
    {
        NonoEntry* currentEntry = [NonoEntry entry];
        NSMutableArray* rowEntries = [NSMutableArray arrayWithCapacity:width];
        for (NSUInteger x = 0; x < width; x++)
        {
            if (nncEqual(_grid[x][y], currentEntry.color))
            {
                currentEntry.count++;
            }
            else
            {
                if (!currentEntry.color.empty)
                {
                    [rowEntries addObject:currentEntry];
                }
                
                currentEntry = [NonoEntry entry];
                currentEntry.color = _grid[x][y];
            }
        }
        
        if (!currentEntry.color.empty)
        {
            [rowEntries addObject:currentEntry];
        }
        
        [yEntries addObject:rowEntries];
    }
    return yEntries;
}

#ifdef DEBUG
- (id)initDebugGrid
{
    self = [self initWithWidth:5 andHeight:5];
    if (self != nil)
    {
        _grid[0][0] = nncEmpty();
        _grid[0][1] = nncEmpty();
        _grid[0][2] = nnc(0, 0, 0);
        _grid[0][3] = nncEmpty();
        _grid[0][4] = nncEmpty();
        
        _grid[1][0] = nncEmpty();
        _grid[1][1] = nnc(0, 0, 0);
        _grid[1][2] = nnc(0, 0, 0);
        _grid[1][3] = nnc(0, 0, 0);
        _grid[1][4] = nncEmpty();
        
        _grid[2][0] = nnc(0, 0, 0);
        _grid[2][1] = nnc(0, 0, 0);
        _grid[2][2] = nnc(0, 0, 0);
        _grid[2][3] = nnc(0, 0, 0);
        _grid[2][4] = nnc(0, 0, 0);
        
        _grid[3][0] = nncEmpty();
        _grid[3][1] = nnc(0, 0, 0);
        _grid[3][2] = nnc(0, 0, 0);
        _grid[3][3] = nnc(0, 0, 0);
        _grid[3][4] = nncEmpty();
        
        _grid[4][0] = nncEmpty();
        _grid[4][1] = nncEmpty();
        _grid[4][2] = nnc(0, 0, 0);
        _grid[4][3] = nncEmpty();
        _grid[4][4] = nncEmpty();
    }
    return self;
}
#endif

@end
