//
//  NonoSolver.m
//  nono
//
//  Created by Charles Francoise on 5/29/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoSolver.h"
#import "NOnoGrid.h"

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

- (NonoGrid*)solve
{
    
}

- (BOOL)isSolvedByGrid:(NonoGrid*)grid
{
}

- (BOOL)hasUniqueSolution
{
}

@end
