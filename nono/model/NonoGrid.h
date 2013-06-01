//
//  NonoGrid.h
//  nono
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NonoColor.h"

@interface NonoGrid : NSObject

@property (nonatomic, readonly) NSUInteger width;
@property (nonatomic, readonly) NSUInteger height;
@property (nonatomic, readonly) NonoColor** grid;

+ (id)debugGrid;
+ (id)randomGrid;

+ (id)gridWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
+ (id)gridWithGrid:(NonoGrid*)aGrid;

- (id)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
- (id)initWithGrid:(NonoGrid*)aGrid;

- (BOOL)isEqualToGrid:(NonoGrid*)aGrid;

- (NSArray*)getColEntries;
- (NSArray*)getRowEntries;

- (void)print;

@end
