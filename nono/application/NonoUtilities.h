//
//  Utilities.h
//  nono
//
//  Created by Charles Francoise on 6/2/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NonoColor.h"

@interface NonoUtilities : NSObject

+ (UIColor*)colorWithNonoColor:(NonoColor)nonoColor;
+ (NonoColor)nonoColorWithColor:(UIColor*)color;

@end
