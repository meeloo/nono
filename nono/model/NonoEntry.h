//
//  NonoEntry.h
//  nono
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NonoColor.h"

@interface NonoEntry : NSObject

@property (nonatomic, assign) NonoColor color;
@property (nonatomic, assign) NSUInteger count;

+ (id)entry;

@end
