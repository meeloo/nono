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

- (id)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
- (id)initWithGrid:(NonoGrid*)aGrid;
#ifdef DEBUG
- (id)initDebugGrid;
#endif

- (BOOL)isEqualToGrid:(NonoGrid*)aGrid;

- (void)setColor:(NonoColor)color AtX:(NSUInteger)x andY:(NSUInteger)y;
- (NonoColor)getColorAtX:(NSUInteger)x andY:(NSUInteger)y;

- (NSArray*)getXEntries;
- (NSArray*)getYEntries;

@end
