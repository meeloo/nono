//
//  NonoSolver.h
//  nono
//
//  Created by Charles Francoise on 5/29/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NonoGrid.h"

@interface NonoSolver : NSObject

- (id)initWithColEntries:(NSArray*)colEntries andRowEntries:(NSArray*)rowEntries;

- (NonoGrid*)solve;

- (BOOL)isSolvedByGrid:(NonoGrid*)grid;
- (BOOL)hasUniqueSolution;

@end
