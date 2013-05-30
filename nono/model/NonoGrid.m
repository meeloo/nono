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

+ (id)gridWithWidth:(NSUInteger)width andHeight:(NSUInteger)height
{
    return [[[self.class alloc] initWithWidth:width andHeight:height] autorelease];
}

+ (id)gridWithGrid:(NonoGrid*)aGrid
{
    return [[[self.class alloc] initWithGrid:aGrid] autorelease];
}

-(id)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height
{
    self = [super init];
    if (self != nil)
    {
        _width = width;
        _height = height;
        _grid = calloc(_width, sizeof(NonoColor*));
        for (NSUInteger x = 0; x < width; x++)
        {
            _grid[x] = calloc(_height, sizeof(NonoColor));
        }
        
        for (NSUInteger x = 0; x < _width; x++)
        {
            for (NSUInteger y = 0; y < _height; y++)
            {
                self->_grid[x][y] = nncEmpty();
            }
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


- (void)dealloc
{
    for (NSUInteger x = 0; x < self.width; x++)
    {
        free(_grid[x]);
    }
    free(_grid);
    [super dealloc];
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
        NonoEntry* currentEntry = [[NonoEntry alloc] init];
        currentEntry.color = _grid[x][0];
        NSMutableArray* colEntries = [NSMutableArray arrayWithCapacity:height];
        for (NSUInteger y = 0; y < height; y++)
        {
            if (!nncEqual(_grid[x][y], currentEntry.color))
            {
                if (!currentEntry.color.empty)
                {
                    [colEntries addObject:currentEntry];
                }
                
                [currentEntry release];
                currentEntry = [[NonoEntry alloc] init];
                currentEntry.color = _grid[x][y];
            }
            currentEntry.count++;
        }
        
        if (!currentEntry.color.empty)
        {
            [colEntries addObject:currentEntry];
        }
        
        [xEntries addObject:colEntries];
        [currentEntry release];
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
        NonoEntry* currentEntry = [[NonoEntry alloc] init];
        currentEntry.color = _grid[0][y];
        NSMutableArray* rowEntries = [NSMutableArray arrayWithCapacity:width];
        for (NSUInteger x = 0; x < width; x++)
        {
            if (!nncEqual(_grid[x][y], currentEntry.color))
            {
                if (!currentEntry.color.empty)
                {
                    [rowEntries addObject:currentEntry];
                }
                
                [currentEntry release];
                currentEntry = [[NonoEntry alloc] init];
                currentEntry.color = _grid[x][y];
            }
            currentEntry.count++;
        }
        
        if (!currentEntry.color.empty)
        {
            [rowEntries addObject:currentEntry];
        }
        
        [yEntries addObject:rowEntries];
        [currentEntry release];
    }
    return yEntries;
}

+ (id)randomGrid
{
    NonoGrid* grid = [self.class gridWithWidth:(random()%45)+5 andHeight:(random())%45+5];
    if (grid != nil)
    {
        for (NSUInteger x = 0; x < grid->_width; x++)
        {
            for (NSUInteger y = 0; y < grid->_height; y++)
            {
                grid->_grid[x][y] = (random() & 1) ? nncEmpty() : nnc(0, 0, 0);
            }
        }
    }
    return grid;
}

- (void)print
{
    NSUInteger width = self.width;
    NSUInteger height = self.height;
    for (NSUInteger y = 0; y < height; y++)
    {
        for (NSUInteger x = 0; x < width; x++)
        {
            if (nncEqual(_grid[x][y], nncEmpty()))
            {
                printf(" -");
            }
            else
            {
                printf(" O");
            }
        }
        printf("\n");
    }
}

+ (void)initialize
{
    srandomdev();
}

+ (id)debugGrid
{
    NonoGrid* grid = [self.class gridWithWidth:5 andHeight:5];
    if (grid != nil)
    {
        grid->_grid[0][0] = nncEmpty();
        grid->_grid[0][1] = nncEmpty();
        grid->_grid[0][2] = nnc(0, 0, 0);
        grid->_grid[0][3] = nncEmpty();
        grid->_grid[0][4] = nncEmpty();
        
        grid->_grid[1][0] = nncEmpty();
        grid->_grid[1][1] = nnc(0, 0, 0);
        grid->_grid[1][2] = nnc(0, 0, 0);
        grid->_grid[1][3] = nnc(0, 0, 0);
        grid->_grid[1][4] = nncEmpty();
        
        grid->_grid[2][0] = nnc(0, 0, 0);
        grid->_grid[2][1] = nnc(0, 0, 0);
        grid->_grid[2][2] = nncEmpty();
        grid->_grid[2][3] = nnc(0, 0, 0);
        grid->_grid[2][4] = nnc(0, 0, 0);
        
        grid->_grid[3][0] = nncEmpty();
        grid->_grid[3][1] = nnc(0, 0, 0);
        grid->_grid[3][2] = nnc(0, 0, 0);
        grid->_grid[3][3] = nnc(0, 0, 0);
        grid->_grid[3][4] = nncEmpty();
        
        grid->_grid[4][0] = nncEmpty();
        grid->_grid[4][1] = nncEmpty();
        grid->_grid[4][2] = nncEmpty();
        grid->_grid[4][3] = nncEmpty();
        grid->_grid[4][4] = nncEmpty();
    }
    return grid;
}

@end
