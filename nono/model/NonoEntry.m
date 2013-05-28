//
//  NonoEntry.m
//  nono
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoEntry.h"

@implementation NonoEntry

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _color = nncEmpty();
        _count = 1;
    }
    return self;
}

+ (id)entry
{
    return [[[NonoEntry alloc] init] autorelease];
}

@end
